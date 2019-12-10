<?php

/**********************************************
 * 
 * Modulo de Modelos Marcas Partes y Subpartes
 * 
 **********************************************/

namespace Apicore\modules;
// Manejo de Excepciones
use
  \Apicore\bin\Core,
  \Jacwright\Restserver\RestException,
  \Firebase\JWT\BeforeValidException,
  \Firebase\JWT\ExpiredException,
  \Firebase\JWT\SignatureInvalidException,
  \Firebase\JWT\JWT,
  Exception,
  PDO;

  class car extends Core {
    
    //Columnas Entrada de Datos
    protected $cols = [];

    // Entradas de error de lenguaje
    private $unique,$l,$o;

    // Inicio de Clase
    function __construct(){
      global $conexion, $lang;
      
        $this->data = json_decode(file_get_contents('php://input'),true,1024);
        $this->head = apache_request_headers();
        $this->auth = (!empty($this->head['Authorization']))?$this->head['Authorization']:null;
        $this->JWT = new JWT;

      // Variables de Inicio
      // Tablas:  'Tabla'=>['campo' => 'requerido [true:false]']
      $this->t = [
        'car_brands'    => [
          'name'    => true,
          'image'   => false,
          'count'    => false,
          'active'  => false
        ],
        'car_models'    => [
          'ID'      => true,
          'brandID' => true,
          'name'    => true,
          'image'   => false,
          'active' => false
        ],
        'car_years'     => [
          'ID'  => true
        ],
        'car_parts'     => [
          'name' => true,
          'image' => false,
          'classID' => false,
          'active' => false,
          'count' => false
        ],
        'car_parts_class' => [
          'name' => true,
          'count' => false,
          'active' => false,
          'updated' => false
        ],
        'car_parts_ref' => [
          'ID'  => true
        ]
      ];
      // Listado de mensajes y errores
      $this->l = @$lang['car'];
      // Objetos de Formulario
      $this->o = @$lang['car']['forms'];
      // Datos unicos de tabla
      $this->unique = [
        'car_brands'        => ['name'],
        'car_models'        => ['name'],
        'car_years'         => [],
        'car_parts'         => ['name'],
        'car_parts_family'  => ['name'],
        'car_parts_ref'     => []
      ];

      // Inicio de la base de datos
      $this->db = $this->startdb();
    }

    // Preparar los Datos para ingresar
    function prepare_data($data,$cols,$table){
      $data_formatted = [];
      $l = $this->l[$table];
      $kp = 'name';
      $minLength = 2;
      foreach($cols as $key=>$required){
        $data = (array) $data;
        $value_exists = isset($data[$key]);
        if($key === 'name'){
          if($required){
            if($value_exists){
              $nl = strlen($data[$key]);
              if($nl<$minLength){
                // Error en caso de que no tenga el minimo de caracteres
                $this->response(null,null,sprintf($l['minlength'],$this->o[$key],$minLength),406);
              }else{
                $data_formatted[$key] = $data[$key];
              }
            }else{
              return $this->response(null,null,sprintf($l['fieldrequired'],$this->o[$key]),406);
            }
          }else{
            if($value_exists){
              $data_formatted[$key] = $data[$key];
            }
          }
        }elseif($key === 'format'){
        }elseif($key === 'familyID'){
/*
        }elseif($key === 'brandID'){
          $t = 'car_brands';
          $data_formatted[$key] = @$this->returnIDfromName($t,$data[$key]);
*/
        }else{
          if($required){
            if($value_exists){
              $data_formatted[$key] = $data[$key];
            }else{
              $this->response(null,null,sprintf($l['fieldrequired'],$this->o[$key]));
            }
          }else{
            if($value_exists){
              $data_formatted[$key] = $data[$key];
            }
          }
        }
      }
      return $data_formatted;
    }

    // Revisa si el valor de un campo ya existe
    function unique_field($data,$t){
      $u = $this->unique[$t];
      $l = $this->l[$t];
      foreach($u as $uf){
        $w = [$uf=>$data[$uf]];
        $u = $this->db->has($t,$w);
        if($u){
          return $this->response(null,null,sprintf($l['duplicated'],$this->o[$uf]),406);
        }
      }
    }

    function returnIDfromName($t,$value,$column_return = 'ID',$column_name = 'name'){
      $cn = 'name';
      $r = $this->db->get($t,$column_return,[$column_name=>$value]);
      return $r;
      
    }

    // Mostrar marcas
    function car_brands($data,$all = false){
      $t = 'car_brands';
      $t2 = 'car_models';
      if($all){
        $w = ['ORDER'=>['name'=>'ASC']];
        $c = ['ID','name','image','count','active'];
        $brands = $this->db->select($t,$c,$w);
      }else{
        $c = [$t.'.ID(ID)',$t.'.name(name)',$t.'.image(image)',$t.'.count(count)',$t.'.active(active)'];
        $w = ['ORDER'=>[$t.'.count'=>'DESC']];
        $j = ['[><]'.$t2=>['ID'=>'brandID']];
        $query = "
        SELECT DISTINCT 
        `car_brands`.`ID` AS `ID`,
        `car_brands`.`name` AS `name`,
        `car_brands`.`image` AS `image`,
        `car_brands`.`count` AS `count`,
        `car_brands`.`active` AS `active`
        FROM `car_brands`
        INNER JOIN `car_models` ON `car_brands`.`ID` = `car_models`.`brandID`
        WHERE `car_brands`.`active` = '1' AND `car_models`.`active` = '1'
        ORDER BY `car_brands`.`count` DESC
        ";
        $brands = $this->db->query($query)->fetchAll(2);
        //$brands = array_unique($this->db->select($t,$j,$c,$w));

      }
      $e = $this->db->error();
      $q = $this->db->last();
      $b = $brands;
      if($brands){
        $brands = [];
        foreach($b as $v){
          $w = ['brandID'=>$v['ID']];
          $cars = $this->db->count('car_models','*',$w);
          $v['cars'] = $cars;
          $brands[] = $v;
        }
        return $this->response($brands,"ok");
      }else{
        return $this->response(["item"=>"0","text"=>"Sin resultados"],null,"Sin resultados",406);
      }
    }

    // Agregar Marca
    function car_brands_add($data){
      $t = 'car_brands';
      $c = $this->t[$t];
      $sc = array_merge((array) 'ID',array_keys($c));
      $l = $this->l[$t];
      $ID = $this->uID();
      $w = ['ID'=>$ID];
      $prepared_data = $this->prepare_data($data,$c,$t);
      $prepared_data['ID'] = $ID;
      // Verifico si no hay campos unicos 406 en caso de:
      $this->unique_field($prepared_data,$t);
      $add = $this->db->insert($t,$prepared_data);
      $err = $this->db->error();
      $upd = $add->rowCount();
      if($upd>0){
        // Marca Agregada
        $addedbrand = $this->db->get($t,$sc,$w);
        return $this->response($addedbrand,"Marca agregada");
      }else{
        if($err[2]){
          // Error por la base de datos
          return $this->response(null,null,"Db error",406);
        }else{
          // No hubo Cambios
          return $this->response(null,"No Cahnges");
        }
      }
    }

    function car_brands_edit($data){
      $t = 'car_brands';
      $c = $this->t[$t];
      $sc = array_merge((array) 'ID',array_keys($c));
      $l = $this->l[$t];
      $ID = $data['ID'];
      $w = ['ID'=>$ID];
      $prepared_data = $this->prepare_data($data,$c,$t);

      $add = $this->db->update($t,$prepared_data,$w);
      $err = $this->db->error();
      $que = $this->db->last();
      $upd = $add->rowCount();
       if($upd>0){
        // Marca Agregada
        $addedbrand = $this->db->get($t,$sc,$w);
        return $this->response($addedbrand,"Marca editada");
      }else{
        if($err[2]){
          // Error por la base de datos
          return $this->response(null,null,"Db error",406);
        }else{
          // No hubo Cambios
          return $this->response(null,"No Changes");
        }
      }
    }

    function car_brands_delete($ID){
      $t = 'car_brands';
      $w = ['ID'=>$ID];
      $del = $this->db->delete($t,$w);
      $err = $this->db->error();
      $que = $this->db->last();
      $del = $del->rowCount();
      if($del>0){
        return $this->response(['delete'=>$ID],"Marca Eliminada");
      }else{
        if($err[2]){
          // Error por la base de datos
          return $this->response(null,null,"Db error",406);
        }else{
          // No hubo Cambios
          return $this->response(null,"No se realizaron cambios");
        }
      }
    }
 /*
  /********************************************************** */
  // Pendiente de Crear operaciones de editar o borrar Marcas
  /********************************************************** */
    function car_models($data,$all=false){
      $t = 'car_models';
      $t2 = 'car_brands';
      $d = $this->clean_get_method($_GET,$data);
      $returned = NULL;
      $c = [
        $t.'.ID(ID)',
        $t.'.brandID(brandID)',
        $t.'.name(name)',
        $t.'.image(image)',
        $t.'.created(created)',
        $t.'.count(count)',
        $t.'.active(active)',
        $t2.'.name(bname)'
      ];
      $j = ['[>]'.$t2=>['brandID'=>'ID']];
      if($all){
        $returned = $this->db->select($t,$j,$c);
      }else{
        if($d){
          $w = ['brandID'=>$d];
          if(isset($d['brandID'])){
            $w = [$t.'.brandID'=>$d['brandID']];
          }elseif(isset($d['name'])){
            $w = [$t2.'.name'=>$d['name']];
          }elseif(is_string($d)){
            $w = [$t.'.brandID'=>$d];
          }else{
            return $this->response(null,null,"Identificador Requerido",404);
          }
        }else{
          return $this->response(null,null,"Identificador Requerido",404);
        }
        // Solo los elementos activos
        $w[$t.'.active'] = "1";
        
        $returned = $this->db->select($t,$j,$c,$w);
        $e = $this->db->error();
        $q = $this->db->last();
     }
      return $this->response($returned,"ok");
    }

    function car_models_add($data){
      $t = 'car_models';
      $c = $this->t[$t];
      $l = $this->l[$t];
      $ID = $this->uID();
      $dt = $this->prepare_data($data,$c,$t);
      $dt['ID'] = $ID;
      $add = $this->db->insert($t,$dt);
      $upd = $add->rowCount();
      $err = $this->db->error();
      $qry = $this->db->last();
      if($upd){
        // Marca Agregada
        $modeladded = $this->db->get($t,'*',['ID'=>$ID]);
        return $this->response($modeladded,"Modelo agregado");
      }else{
        if($err[2]){
          // Error por la base de datos
          return $this->response(null,null,$err[2],406);
        }else{
          // No hubo Cambios
          return $this->response(null,"No Changes");
        }
      }
      return $this->response($dt,"ok");
    }

    function car_models_edit($data){
      $auth = $this->getauth();
      $t = 'car_models';
      $c = $this->t[$t];
      $sc = (array_keys($c));
      $l = $this->l[$t];
      $ID = $data['ID'];
      $w = ['ID'=>$ID];
      $prepared_data = $this->prepare_data($data,$c,$t);
      unset($prepared_data['ID']);

      $edit = $this->db->update($t,$prepared_data,$w);
      $err = $this->db->error();
      $que = $this->db->last();
      $upd = $edit->rowCount();
       if($upd){
        // Modelo Agregado
        $addedmodel = $this->db->get($t,$sc,$w);
        return $this->response($addedmodel,"Modelo editado");
      }else{
        if($err[2]){
          // Error por la base de datos
          return $this->response(null,null,"Db error",406);
        }else{
          // No hubo Cambios
          return $this->response(null,"No Changes");
        }
      }
    }

    function car_models_del($ID){
      $t = 'car_models';
      $w = ['ID'=>$ID];
      $del = $this->db->delete($t,$w);
      $err = $this->db->error();
      $que = $this->db->last();
      $del = $del->rowCount();
      if($del){
        return $this->response(['delete'=>$ID],"modelo Eliminado");
      }else{
        if($err[2]){
          // Error por la base de datos
          return $this->response(null,null,"Db error",406);
        }else{
          // No hubo Cambios
          return $this->response(null,"No se realizaron cambios");
        }
      }
    }

    function car_parts($data,$all = false, $solo = false){
      $t1 = 'car_parts';
      $t2 = $t1.'_class';
      $t3 = $t1-'_ref';
      $parts = [];
/*
      "ID": "0089880f627098cdb66cba6629922b",
      "name": "Electro Ventilador",
      "image": null,
      "classID": "70f4d8e0c2e4106e8d3a058e156f19",
      "count": "0",
      "updated": "2019-08-13 05:54:28",
      "active": "1"
*/
      $j = [
        '[>]'.$t2 => ['classID'=>'ID']
      ];

      $c = [
        $t1.'.ID',
        $t1.'.name',
        $t1.'.image',
        $t1.'.classID',
        $t1.'.count',
        $t1.'.updated',
        $t1.'.active',
        $t2.'.name(sname)'
      ];

      if($all){
        $parts = $this->db->select($t1,$j,$c);
      }else{
      if($solo){
        $sp = $this->db->select($t2,'*',['active'=>'1','ORDER'=>['name'=>'ASC']]);
      }else{
        $c = [$t1.'.ID(ID)',$t1.'.name(name)',$t2.'.name(family)'];
        $j = ['[>]'.$t2=>['classID'=>'ID']];
        $w = [$t1.'.active'=>'1',$t2.'.active'=>'1','ORDER'=>[$t1.'.count'=>'DESC',$t2.'.name']];
        $p = $this->db->select($t1,$j,$c,$w);
      }
      $e = $this->db->error();
      $q = $this->db->last();
      if($e[2]){
        return $this->response(null,null,$e[2],406);
      }else{
        if($solo){
          foreach($sp as $SP => $V){
            $c = $this->db->select($t1,'*',['classID'=>$V['ID'],'active'=>'1','ORDER'=>['name'=>'ASC']]);
            foreach($c as $k=>$v){
              $childs[] = ['text'=> ucwords($v['name']),'value' => $v['ID']];
            }
            if(isset($childs) && count($childs)>0){
            $parts[] = [
              'text'=> ucwords($V['name']),
              'value' => $V['ID'],
              'parts'=> $childs
            ];
          }
            $childs = [];
          }
        }else{
          if(count($p)>0){
            foreach($p as $k => $v){
              $subpart = ucwords($v['family']).' - ';
              $parts[] = ['text' => $subpart.ucwords($v['name']),"value"=>$v['ID']];
            }
          }else{
           $parts = ['No se encontraron Elementos']; 
          }
        }
      }
    }

      return $this->response($parts,'ok');
    }

    function car_parts_add($data){
      $auth = $this->getlevel();
      $t = 'car_parts';
      $c = $this->t[$t];
      $d = $this->prepare_data($data,$c,$t);
      $ID = $this->uID();
      $d['ID'] = $ID;
      if($auth === "5"){
        $duplicate = $this->db->has($t,['name'=>$d['name'],'classID'=>$d["classID"]]);
        if($duplicate){
          return $this->response(null,null,'Parte Duplicada',406);
        }else{
          $partadd = $this->db->insert($t,$d);
          $e = $this->db->error();
          $q = $this->db->last();
          $a = $partadd->rowCount();
          if($a){
            return $this->response($d,'ok');
          }else{
            if($e[2]){
              return $this->response(null,null,$e[2],406);
            }else{
              return $this->response(null,null,'error desconocido',406);
            }
          }
        }
      }else{
        return $this->response(null,null,"No tienes el nivel de acceso");
      }
    }

    function car_parts_edit($data){
      $auth = $this->getauth();
      $t = "car_parts";
      $c = $this->t[$t];
      $ID = $data->ID?$data->ID:$data['ID'];
      $w = ['ID'=>$ID];
      $d = $this->prepare_data($data,$c,$t);
      if($auth['level'] === "5"){
        $editPart = $this->db->update($t,$d,$w);
        $a = $editPart->rowCount();
        $q = $this->db->last();
        $e = $this->db->error();
        if(!$e[2]){
          // Preparar el objeto enviado
          $return = $d;
          $return['ID'] = $ID;
          if($a){
            // enviar el objeto editado
            return $this->response($return,'ok');
          }else{
            // enviar objeto editado
            return $this->response($return,'Sin cambios');
          }
          
        }else{
          return $this->response(null,null,"Error en consulta BD: ".$e[2],406);
        }
      }else{
        // Sin autorizacion para editar
        return $this->response(null,null,"No tienes el nivel de acceso para editar partes");
      }
    }

    function car_parts_del($data){
      $auth = $this->getauth();
      $t = "car_parts";
      $w = ['ID'=> $data];
      if($auth['level']==="5"){
        $checkPART = $this->db->has($t,$w);
        if($checkPART){
          $deletedpart = $this->db->delete($t,$w);
          $a = $deletedpart->rowCount();
          $e = $this->db->last();
          $q = $this->db->error();
          if($a){
            return $this->response(['delete'=>$data],'ok');
          }else{
            if($e){
              return $this->response(null,null,"Error en consulta BD: ".$e[2],406);
            }else{
              return $this->response(null,null,"Sin Cambios",406);
            }
          }
        }else{
          return $this->response(null,null,"No se puede eliminar por que no existe el item",404);        }
      }else{
        // Sin autorizacion para editar
        return $this->response(null,null,"No tienes el nivel de acceso para Eliminar partes",406);
      }

    }


    function car_parts_class($data,$all = false){
      $t1 = 'car_parts';
      $t2 = $t1.'_class';
      $t3 = $t1-'_ref';
      $parts = [];
      $c = [$t1.'.name(name)',$t2.'.name(family)'];
      $j = ['[>]'.$t2=>['classID'=>'ID']];
      $w = ['ORDER'=>[$t1.'.count'=>'DESC',$t2.'.name']];
      if($all){
        $parts = $this->db->select($t2,'*');
        return $this->response($parts,'OK');
      }else{
        $p = $this->db->select($t1,$j,$c,$w);
        $e = $this->db->error();
        $q = $this->db->last();
        if($e[2]){
          return $this->response(null,null,$e[2],406);
        }else{
          if(count($p)>0){
            foreach($p as $k => $v){
              $parts[] = ucwords($v['family']).' - '.ucwords($v['name']);
            }
          }else{
            $parts = ['No se encontraron Elementos'];
          }
        }
      }
    }

    function car_parts_class_add($data){
      $auth = $this->getauth();
      $t = 'car_parts_class';
      $c = $this->t[$t];
      $ID = $this->uID();
      $d = $this->prepare_data($data,$c,$t);
      $d['ID'] = $ID;
      $new_class_added = $this->db->insert($t,$d);
      $e = $this->db->error();
      $q = $this->db->last();
      $a = $new_class_added->rowCount();
      if($a){
        $subpart = $this->db->get($t,'*',['ID'=>$ID]);
        return $this->response($subpart,"Subparte agregada");
      }else{
        if($e[2]){
          return $this->response(null,null,"error en consulta: ".$e[2],406);
        }else{
          return $this->response(null,null,"Sin Cambios",406);
        }
      }
    }

    function car_parts_class_edit($data){
      $auth = $this->getauth();
      $t = 'car_parts_class';
      $c = $this->t[$t];
      $d = $this->prepare_data($data,$c,$t);
      $ID = $data->ID ? $data->ID : $data['ID'];
      $w = ['ID'=>$ID];
      if($auth['level'] === "5"){
        $check = $this->db->has($t,$w);
        if($check){
          $editsubpart = $this->db->update($t,$d,$w);
          $a = $editsubpart->rowCount();
          $q = $this->db->last();
          $e = $this->db->error();
          $spedited = $this->db->get($t,'*',$w);
          if($a){
            return $this->response($spedited,"Subparte editada");
          }else{
            if($e[2]){
              return $this->response(null,null,$e[2],406);
            }else{
              return $this->response($spedited,"Sin Cambios");
            }
          }
        }else{
        return $this->response(null,null,"No se encuentra la sub parte a Editar",404);
        }
      }else{
        return $this->response(null,null,"No tienes el nivel de acceso para editar sub partes",406);
      }
      
    }

    function car_parts_class_del($data){
      $auth = $this->getauth();
      $t = 'car_parts_class';
      $c = $this->t[$t];
      $ID = isset($data->ID) ? $data->ID : is_array($data)?$data['ID']:$data;
      $w = ['ID'=>$ID];
      if($auth['level'] === "5"){
        $check = $this->db->has($t,$w);
        if($check){
          $deleteSubpart = $this->db->delete($t,$w);
          $a = $deleteSubpart->rowCount();
          $e = $this->db->error();
          $q = $this->db->last();
          if($a){
            return $this->response(['delete'=>$ID],'ok');
          }else{
            if($e[2]){
              return $this->response(null,null,"Error al eliminar: ".$e[2],406);
            }else{
              return $this->response(null,"No se pudo eliminar la subparte");
            }
          }
        }else{
          return $this->response(null,null,"No se encuentra la sub parte a Eliminar",404);
        }
      }else{
        return $this->response(null,null,"No tienes el nivel de acceso para Eliminar sub partes.",406);
      }
    }

    // End of the Class
  }
?>