<?php
namespace Apicore\modules;
// Manejo de Excepciones
use
  \Apicore\bin\Core,
  \Jacwright\Restserver\RestException,
  \Firebase\JWT\BeforeValidException,
  \Firebase\JWT\ExpiredException,
  \Firebase\JWT\SignatureInvalidException,
  \Firebase\JWT\JWT,
  \upload\uploadclass,
  Exception,
  PDO;

class upload extends core {
   protected $image = [];
   public $JWT;

   function __construct(){
    global $conexion, $lang;
    $this->data = json_decode(file_get_contents('php://input'),true,1024);
    $this->head = apache_request_headers();
    $this->auth = (!empty($this->head['Authorization']))?$this->head['Authorization']:null;
   }

   function loadimage($data){
     $obj = ['data'=>$this->data];
     $this->base64_to_image($obj['data']['_image'],"imagen");
     return $this->response($obj ,"ok");
   }
}

?>
