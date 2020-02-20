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
  Exception,
  PDO;

class notification extends core{


    protected $cols = [
        'userID'     => true,
        'action'      => true,
        'module'      => true,
        'item'      => true,
        'created'       => true,
        'doctype'   => true,
        'auth'       => true,
        'view'   => false,
    ];

    // LANG required errors
    protected $unique;

    public $JWT;

    // Funcion Constructora
    function __construct($ID=false){
        global $conexion, $JWT_DATA, $lang;
        $this->head = apache_request_headers();
        $this->auth = (!empty($this->head['Authorization']))?$this->head['Authorization']:null;
        $this->t = 'users';
        $this->l = @$lang['user'];
        $this->o = @$lang['forms'];
        // Json Web Token
        $this->JWT = new JWT;

        $this->unique = [
            'email' => @$this->l['emailtaken'],
            'doc'   => @$this->l['docexists']
        ];

        //Asiganacion de la base de datos
        $this->db = $this->startdb();
        $this->msg = "ready";
        $this->data = null;
    }


    public function show_notifications(){
      return $this->response();
    }

}
?>
