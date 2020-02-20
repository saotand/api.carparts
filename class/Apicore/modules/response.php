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

  class response extends core {

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
        'responses'    => [
          'ID'    =>    false,
          'requestID' => true,
          'reuserID'  => true,
          'price' => true,
          'status'   => false,
          'details' => false,
          'currency' => false,
          'image' => false,
          'recreated'=> false,
          'reedited'=> false
        ]
      ];

      // Listado de mensajes y errores
      $this->l = @$lang['responses'];

      // Objetos de Formulario
      $this->o = @$lang['responses']['forms'];

      // Datos unicos de tabla
      $this->unique = [
        'requests'        => []
      ];

      // Inicio de la base de datos
      $this->db = $this->startdb();
    }

    function prepare_data($data){
      $t = 'responses';
      $auth = $this->getAuth();
      $c = $this->t[$t];
      $ID = $this->uID();
      $formatted_data = [];

      // Recorrido por el vector que normaliza las variables de entrada
      foreach($c as $k=>$v){
        if($k == 'ID'){
          $formatted_data[$k] = $ID;
        }elseif($k == 'requestID'){
          $formatted_data[$k] = $data['requestID'];
        }elseif($k == 'reuserID'){
          $formatted_data[$k] = $auth['ID'];
        }elseif($k == 'status'){
          $formatted_data[$k] = "0";
        }elseif($k == 'image'){
          $image_dir = "images/storefiles/responses/";
          $b64img = $this->txt2img($data[$k],$ID,$image_dir);
          $formatted_data[$k] = $b64img;
        }elseif($k == 'recreated'){
          $formatted_data[$k] = HOY;
        }else{
          @$formatted_data[$k] = $data[$k];
        }
      }
      return $formatted_data;
    }




    function add($data,$requestID){
      $t = 'responses';
      $auth = $this->getAuth();
      $data = $this->prepare_data($this->data);
      // Verificamos si existe la pregunta a responder
      $checkResponse = $this->db->has('requests',['ID'=>$requestID]);
      // La pregunta existe y se envia la respuesta
      if($checkResponse){
        // Verificamos si ya el usuario ha respondido esa pregunta
        $checkAlreadyResponse = $this->db->has($t,['requestID'=>$data['requestID'],'reuserID'=>$auth['ID']]);
        if($checkAlreadyResponse){ // El usuario ya ha respondido
          return $this->response(null,null,"Ya has respondido esta Solicitud",406);
        }else{ // El usuario no ha respondido
          $add = $this->db->insert($t,$data);
          $affected = $add->rowCount();
          $err = $this->db->error();
          $qry = $this->db->last();
          if($err[2]){
            return $this->response(null,null,"error al enviar la respuesta",404);
          }else{
            if($affected){
              return $this->response($data,'Respuesta enviada');
            }else{
            return $this->response(null,null,"No se pudo enviar la respuesta",404);
            }
          }
        }
      }else{ // No existe la pregunta y se devuelve error
        return $this->response(null,null,"No se encuentra la respuesta",404);
      }


    }

    function remove($ID){
      $t = 'responses';
      $c = ['ID','requestID','reuserID','status','details','price','currency','image','recreated','reedited'];

      $response = null;

      // Usuario quien ejecuta la funcion
      $auth = $this->getAuth();
      $w = ['ID'=>$ID];
      $responsetodelete = $this->db->get($t,$c,$w);

      // Si se encuentre la respuesta en la BBDD
      if($responsetodelete){
        // Comparar si el mimo usuaario creo la respuesta a eliminar
        if($auth['ID'] == $responsetodelete['reuserID']){
          //Eliminar la respuesta y agregar accion a bitacora
          $getimgtodel = $this->db->get($t,'image',$w);
          $deleted = $this->db->delete($t,$w);
          $qry = $this->db->last();
          $err = $this->db->error();
          if($err[2]){
            return $this->response(null,null,"No pudo Eliminar la respuesta",406);
          }else{
            $affected = $deleted->rowCount();
            if($affected){
              unlink($getimgtodel);
              // Borro la Respuesta
              return $this->response(null,"Respuesta Eliminada");
            }else{
              // No se borro la respuesta
              return $this->response(null,null,"Error al Eliminar la respuesta",406);
            }
          }
        }else{
          // Comprobar si el usuario es administrador
          if($auth['level'] == "5"){
            // Eliminar la respuesta y agregar a bitacora (admin)
            //echo "caso2";
            return $this->response(null,null,"No se puede eliminar Respuestas de otro usuario");
          }else{
            // Denegar la peticion al no ser ni el autor ni estar autorizado
          return $this->response(null,null,"No puedes Eliminar la respuesta",406);
          }
        }
      }else{ // Si no se encuentra la respuesta en la BBDD
        return $this->response(null,null,"No se encuentra la respuesta",404);
      }

    }


  }
?>
