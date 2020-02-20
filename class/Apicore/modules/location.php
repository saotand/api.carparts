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

  class location extends core {

    //Columnas Entrada de Datos
    protected $cols = [];

    // Entradas de error de lenguaje
    // private $unique,$l,$o;

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
        '_location'    => [
          'ID'    =>    true,
          'item'    => true,
          'parentID'   => true,
          'typez'   => true
        ]
      ];

      // Inicio de la base de datos
      $this->db = $this->startdb();
    }

    function location(){
      $t = '_location';
      $location = [];
      $cols = ["item(text)","ID(value)","livein","search","active"];
      $wcountry = ["parentID"=>"0",'active'=>"1"];
      $country = $this->db->select($t,$cols,$wcountry);

      foreach($country as $c=>$v){
        $location[$c] = $v;
        $citys = [];
        $wcity = ['parentID'=>$v['value'],'active'=>"1"];
        $childsC = $this->db->select($t,$cols,$wcity);
        foreach($childsC as $ct => $vt){
          $wlocal = ['parentID' => $vt['value'],'active'=>"1"];
          $childsL = $this->db->select($t,$cols,$wlocal);
          $childsC[$ct]['childs'] = $childsL;
        }
        $location[$c]['childs'] = $childsC;
      }
      return $this->response($location,"OK");
    }

    function add_location(){

    }
  }

  ?>
