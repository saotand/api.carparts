<?php

/***************************
 *
 * Modulo de preguntas ASK
 *
 ***************************/

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

class ask extends core {

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
			'requests'    => [
				'ID'    =>    true,
				'userID'    => true,
				'model'   => true,
				'year'    => true,
				'part'  => true,
				'image' => false,
				'details'  => false,
				'startdate'  => false,
				'enddate'  => false,
				'active'=> false
			]
		];

		// Listado de mensajes y errores
		$this->l = @$lang['ask'];

		// Objetos de Formulario
		$this->o = @$lang['ask']['forms'];

		// Datos unicos de tabla
		$this->unique = [
			'requests'        => []
		];

		// Inicio de la base de datos
		$this->db = $this->startdb();
	}



	// Preparar los Datos para ingresar
	function prepare_data($data,$cols,$table){
		$data['ID'] = $this->uID();
		$data_formatted = [];
		$l = $this->l[$table];
		foreach($cols as $key=>$required){
			$data = (array) $data;
			$value_exists = isset($data[$key]);
			if($key === ''){
				//echo $data[$key];
			}else if($key=="image"){
				//var_dump($data['image']);
				$image_dir = "images/storefiles/request/";
				if(is_array($data[$key])){
					$cOrder = 0;
					foreach($data[$key] as $Vimg){
						$tID = $this->uID();
						$Vimg = (Array) $Vimg;
						$imgTemp = $this->txt2img($Vimg['data'],$tID,$image_dir);
						$imgT = ['ID'=>$tID,'relID'=>$data['ID'],'order'=>$cOrder,'path'=>$imgTemp];
						$b64img[] = $imgT;
						$addimg = $this->db->insert('requests_images',$imgT);
						$cOrder++;
					}
				}else{
					$b64img = $this->txt2img($data[$key],$data['ID'],$image_dir);
					$data_formatted['image'] = $b64img;
				}
			}else{
				if($required){
					if($value_exists){
						$data_formatted[$key] = $data[$key];
					}else{
						return $this->response(null,null,sprintf($l['fieldrequired'],$this->o[$key]),406);
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

	function plusTable($ID){
		$all = ['car_models' => 'car_brands','car_parts' => 'car_parts_class'];
		$rel = ['car_brands' => 'brandID','car_parts_class' => 'classID'];
		$d = ['count[+]'=>1];
		$w = ['ID'=>$ID];
		foreach($all as $t => $tp){
			$find_base = $this->db->get($t,'*',$w);
			if($find_base){
				$add1 = $this->db->update($t,$d,$w);
				$w2 = ['ID'=>$find_base[$rel[$tp]]];
				$find_parent = $this->db->get($tp,'*',$w2);
				if($find_parent){
					$add2 = $add1 = $this->db->update($tp,$d,$w2);
				}
			}
		}
	}

	//Mostrar Preguntas
	function ask($ID=null,$all=false,$raw = false){
		$auth = $this->getauth();
		$t = 'ask_data';
		$c = '*';
		$w = null;
		$order = ['startdate'=>'DESC'];
		if($ID){
			$w = ['ID'=>$ID];
			$w['ORDER'] = $order;
			$preguntas = $this->db->get($t,$c,$w);
			if($auth['level'] >= 3){
				// No actions
			}else{
				if($auth['ID']!==$preguntas['userID']){
					return $this->response(null,null,"Acceso denegado",404);
				}
			}
		}else{
			if($all){
				$w = [];
				$w['ORDER'] = $order;
				if($auth['level'] >= 3){
					$preguntas = $this->db->select($t,$c,$w);
				}else{
					return $this->response(null,null,"Acceso denegado",404);
				}
			}else{
				$w = ['userID'=>$auth['ID']];
				$w['ORDER'] = $order;
				$preguntas = $this->db->select($t,$c,$w);
				// Listado de respuestas por pregunta
				// Tablas de respuestas
				$rt = 'responses';
				// Columnas
				$rc = ['ID','requestID','status','details','price','currency','image','recreated','reedited','selected'];
				// Holder de Where de consultas
				$rw = [];
				// Holder inicilizado de respuestas
				$responses = [];
				// Contador
				$i = 0;
				// Bucle de Consultas
				foreach($preguntas as $p){
					$rw = ['requestID'=>$p['ID']];
					$r = $this->db->select($rt,$rc,$rw);
					$responses = $r;
					$preguntas[$i]['responses'] = $responses;
					$i++;
				}
			}
		}
		$q = $this->db->last();
		$e = $this->db->error();
		if($preguntas){
			return $this->response($preguntas,'OK');
		}else{
			return $this->response([],'OK');
		}
	}

	// Añadir Preguntas
	function add($data){
		// Constantes

		// Tabla
		$t = 'requests';

		// Columnas
		$c = $this->t[$t];

		// Autenticación
		$auth = $this->getauth();

		// Datos sin ser procesado
		$d1 = (array) $data;

		// ID del usuario quien pregunta
		$d1['userID'] = $auth['ID'];

		// Datos a ser Procesados
		$d = $this->prepare_data($d1,$c,$t);

		// Creacion o asignacion del ID
		$ID = isset($d['ID'])?$d['ID']:$this->uID();

		// Condicion de ID
		$d['ID'] = $ID;

		// Condicion de consulta
		$w = ['ID' => $ID];

		// Función de insertar datos
		$add_ask = $this->db->insert($t,$d);

		// Captura de filas Afectadas
		$a = $add_ask->rowCount();

		// Consulta SQL
		$q = $this->db->last();

		// Captura de errores
		$e = $this->db->error();

		// Impresión de respuesta o error si lo hay
		if($a){
			$added = $this->db->get($t,'*',$w);
			if(!$added['image']){
				$added['image'] = $this->db->select($t.'_images',['ID','path','ord'],['relID'=>$ID,'ORDER'=>['ord'=>'ASC']]);
			}
			$a1 = $this->plusTable($d['model']);
			$a2 = $this->plusTable($d['part']);
			return $this->response($added,'OK');
		}else{
			if($e[2]){
				return $this->response(null,null,"Error en BD: ".$e[2],406);
			}else{
				return $this->response(null,null,'No se pudo agregar la consulta',406);
			}
		}
	}

	function ask_sel($ID){
		$auth = $this->getauth();
		$t = 'responses';
		$c = '*';
		$w = ['ID'=>$ID];
		//Obtengo la respuesta
		$responsedata = $this->db->get($t,$c,$w);
		$newID = $this->uID();
		// Modifico la pregunta agregando la respuesta seleccionada
		$ct = 'response_complete';
		$cc = '*';
		$cw = ['requestID'=>$responsedata['requestID']];
		$cd = ['ID'=>$newID,'requestID'=>$responsedata['requestID'],'responseID'=>$responsedata['ID']];
		$exist = $this->db->get($ct,$cc,$cw);
		if($exist){
			return $this->response(null,null,'Ya has respondido a esta Solicitud',406);
		}else{
			$completed = $this->db->insert($ct,$cd);
			return $this->response('Seleccionado','OK');
		}
	}


	function notilist($filter){
		$auth = $this->getauth();
		$b = 'car_brands';
		$m = 'car_models';
		$p = 'car_parts';
		$s = 'car_parts_class';
		$c = ['name(text)','ID(value)'];
		$brands = $this->db->select($b,$c);
		$i = 0;
		foreach($brands as $b){
			$brands[$i]['type'] = 'brand';
			$i++;
		}
		$c2 = ['car_models.name(text)','car_models.ID(value)','car_brands.name(parent)','car_brands.ID(parentID)'];
		$jm = ['[>]car_brands'=>['brandID'=>'ID']];
		$models = $this->db->select($m,$jm,$c2);
		$i = 0;
		foreach($models as $b){
			$models[$i]['type'] = 'model';
			$i++;
		}
		$sparts = $this->db->select($s,$c);
		$i = 0;
		foreach($sparts as $b){
			$sparts[$i]['type'] = 'spart';
			$sparts[$i]['childs'] = $this->db->select($p,['name(text)','ID(value)'],['classID'=>$sparts[$i]['value'],'ORDER'=>['text'=>'ASC']]);
			$i++;
		}
		$c3 = ['car_parts.name(text)','car_parts.ID(value)','car_parts_class.name(parent)','car_parts_class.ID(parentID)'];
		$jp = ['[>]car_parts_class'=>['classID'=>'ID']];
		$parts = $this->db->select($p,$jp,$c3);
		$i = 0;
		foreach($parts as $b){
			if($parts[$i]['text'] == 'Otros'){
				$parts[$i]['text'] = $parts[$i]['text'].' de '.$parts[$i]['parent'];
			}
			$parts[$i]['type'] = 'part';
			$i++;
		}
		if($filter){
			if($filter=="brands"){
				$all = $brands;
			}else if($filter == "models"){
				$all = $models;
			}else if($filter == "subparts"){
				$all = $sparts;
			}else if($filter == "parts"){
				$all = $parts;
			}else{
				$all = array_merge($brands,$models,$sparts,$parts);
			}
		}else{
			$all = array_merge($brands,$models,$sparts,$parts);
		}
		return $this->response($all,'ok');
	}

	// Preguntas por responder
	function asks($ID = false){
		$auth = $this->getauth();
		$set_brand = false;
		$t = "ask_data";
		$tp = "users_sell_profile";
		$tbs = 'car_brands';
		$tcp = 'car_parts';
		$tcpc = 'car_parts_class';
		$cols = ['ID','image','username','userlast','useremail','subpart','part','brand','model','year','details','startdate'];
		$profile = $this->db->select($tp,'sell',['userID'=>$auth['ID']]);
		$asks = [];

		// Contador de elementos de  $profile
		$hasprofile = count($profile);

		// Si el usuario tiene perfil de vendedor
		if($hasprofile){
			$i = 0;
			foreach($profile as $p){
				if($p == '000000000000000000000000000000'){
					unset($profile[$i]);
					$set_brand = true;
				}
				$i++;
			}
			// Variable de Consulta SQL Vacía
			$w = [];
			foreach($profile as $p){
				// Ver en tabla Marcas [Condicional con la verificacion de *]
				if(!$set_brand){
					if($this->db->has('car_brands',['ID'=>$p])){
						$w['brandID'][] = $p;
					}
				}
				// Ver en Modelos [Deshabilitado]
				if($this->db->has('car_models',['ID'=>$p])){
					$w['OR']['modelID'][] = $p;
				}
				// Ver en Subpartes
				if($this->db->has('car_parts_class',['ID'=>$p])){
					$w['OR']['spartID'][] = $p;
				}
				// Ver en partes
				if($this->db->has('car_parts',['ID'=>$p])){
					$w['OR']['partID'][] = $p;
				}
			}
			// No mostrar solicitudes del mismo usuario
			$w['userID[!]'] = $auth['ID'];
			// Ordenar la consulta por fecha de creacion
			$w['ORDER'] = ['startdate'=>'DESC'];
			$asks_temp = $this->db->select($t,$cols,@$w);
			$c = ['ID','price','currency','details','image','recreated(created)'];
			foreach($asks_temp as $at){
				//var_dump($at);
				$at['asked'] = false;
				$w = ['requestID'=>$at['ID'],"reuserID"=>$auth['ID']];
				$asked = $this->db->get('responses',$c,$w);
				if($asked){
					$at['asked'] = $asked;
				}
				$asks[] = $at;
			}
			$error = $this->db->error();
			$query = $this->db->last();
		}
		// Retorno de Contenido
		return $this->response($asks,'OK');
	}

	// Mostrar notificaciones
	function notifications($read){
	}
}
?>
