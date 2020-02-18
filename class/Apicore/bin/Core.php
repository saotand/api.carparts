<?php

/*************************************************************
 *
 *  Nucleo de API funciones comunes para todas las Clases heredadas
 *
 * /*********************************************************/

namespace Apicore\bin;

define('DS', DIRECTORY_SEPARATOR);
define('IPATH', DS.'..'.DS.'..'.DS );
include_once(__DIR__.IPATH.'autoloader.php');
require_once(__DIR__.IPATH.'config'.DS.'config.php');
require_once(__DIR__.IPATH.'config'.DS.'lang'.DS.'esES.php');

// Manejo de Exepciones
use
	Exception,
	\Jacwright\Restserver\RestException,
	\Firebase\JWT\JWT,
	\Firebase\JWT\BeforeValidException,
	\Firebase\JWT\ExpiredException,
	\Firebase\JWT\SignatureInvalidException,
	\upload\uploadclass;

abstract class Core{
	// Reservado Sistema
	protected $data, $head;

	// Variables de Clase
	private $db,$t;

	// Codigos de Error en HTTP
	protected $codes = array(
		'100' => 'Continue',
		'200' => 'OK',
		'201' => 'Created',
		'202' => 'Accepted',
		'203' => 'Non-Authoritative Information',
		'204' => 'No Content',
		'205' => 'Reset Content',
		'206' => 'Partial Content',
		'300' => 'Multiple Choices',
		'301' => 'Moved Permanently',
		'302' => 'Found',
		'303' => 'See Other',
		'304' => 'Not Modified',
		'305' => 'Use Proxy',
		'307' => 'Temporary Redirect',
		'400' => 'Bad Request',
		'401' => 'Unauthorized',
		'402' => 'Payment Required',
		'403' => 'Forbidden',
		'404' => 'Not Found',
		'405' => 'Method Not Allowed',
		'406' => 'Not Acceptable',
		'409' => 'Conflict',
		'410' => 'Gone',
		'411' => 'Length Required',
		'412' => 'Precondition Failed',
		'413' => 'Request Entity Too Large',
		'414' => 'Request-URI Too Long',
		'415' => 'Unsupported Media Type',
		'416' => 'Requested Range Not Satisfiable',
		'417' => 'Expectation Failed',
		'422' => 'Unprocessable Entity',
		'500' => 'Internal Server Error',
		'501' => 'Not Implemented',
		'503' => 'Service Unavailable'
	);

	// Constructor
	function __construct(){
		// Variables Globales
		global $conexion, $JWT_DATA, $lang;
		// Varibles de entrada formato Json Decodificado a un [array assoc]
		$this->data = json_decode(file_get_contents('php://input'),true,1024);
		$this->head = apache_request_headers();
		$this->auth = (!empty($this->head['Authorization']))?$this->head['Authorization']:null;
		$this->db = $this->startdb();
		$this->JWT = new JWT;
		// Tratamiento de imagenes
		//$this->up = new upload;
	}

	static function startdb(){
		global $conexion;
		// Conexion a la Base de Datos
		try{
			$db = new \Medoo\Medoo($conexion);
		}catch(\Medoo\Medoo\PDOException $e){
			throw new Exception($e);
		}
		return $db;
	}

	// Funcion para autorizar urls seguras
	public function authorize(){
		global $conexion;
		$db = new \Medoo\Medoo($conexion);
		if(isset($this->auth)){
			try{
				//Verificamos si el Token es Válido
				$tokentmp  = (array) $this->user->decript($this->auth);
				$token = (array) $tokentmp["data"];
			}catch(ExpiredException $e){
				$this->response(null,null,$e->getMessage(),'401');
			}catch(BeforeValidException $e){
				$this->response(null,null,$e->getMessage(),'401');
			}catch(SignatureInvalidException $e){
				$this->response(null,null,$e->getMessage(),'401');
			}catch(DomainException $e){
				$this->response(null,null,$e->getMessage(),'401');
			}finally{
				$data = isset($token) ? $token:null;
				if($data){
					$userchecked = $this->user->JWT_user($data);
					if($userchecked){
						$c = "*";
						$w = ['ID'=>$data['ID']];
						$userbanned = $db->get('users_ban',$c,$w);
						// si el Usuario y el token son válidos
						// Si el usuario no esta bloqueado
						if(!$userbanned){
							return $userchecked;
						}else{
							return false;
						}
					}else{
						// Si el token es valido pero el usuario no
						return false;
					}
				}else{
					// Token inválido
					return false;
				}
			}
		}else{
			// No hay datos para autentificar (Usar @noauth en apicore)
			return false;
		}
	}

	// Respuesta por defecto de clase
	public function response($data=null, $message = null, $error = null, $code = '200'){
		if($code == '200'){
			http_response_code($code);
			return [ "data"=>$data, "message" => $message];
		}elseif($code >= 201 && $code <= 299){
			http_response_code($code);
			return [ "data"=>$data, "message" => $message];
		}elseif($code >= 300 && $code <= 399){
			throw new RestException($code, $error);
			return ["error"=>$error, "code"=>$code];
		}elseif($code >= 400 && $code <= 499){
			throw new RestException($code, $error);
			return ["error"=>$error, "code"=>$code];
		}elseif($code >= 500 && $code <= 599){
			throw new RestException($code, $error);
			return ["error"=>$error, "code"=>$code];
		}elseif($code>=600){
			return ["error"=>$error, "code"=>$code];
		}
	}

	function time_elapsed_A($secs){
		$bit = array(
			'y' => $secs / 31556926 % 12,
			'w' => $secs / 604800 % 52,
			'd' => $secs / 86400 % 7,
			'h' => $secs / 3600 % 24,
			'm' => $secs / 60 % 60,
			's' => $secs % 60
		);
		foreach($bit as $k => $v){
			if($v > 0){$ret[] = $v . $k;}
		}
		return join(' ', $ret);
	}


	function time_elapsed_B($secs){
		$bit = array(
			' año'			=> $secs / 31556926 % 12,
			' semana'		=> $secs / 604800 % 52,
			' dia'			=> $secs / 86400 % 7,
			' hora'			=> $secs / 3600 % 24,
			' minuto'		=> $secs / 60 % 60,
			' segundo'	=> $secs % 60
		);
		foreach($bit as $k => $v){
			if($v > 1)$ret[] = $v . $k . 's';
			if($v == 1)$ret[] = $v . $k;
		}
		array_splice($ret, count($ret)-1, 0, 'y');
		$ret[] = 'ago.';
		return join(' ', $ret);
	}

	function clrstr($string){
		$string = trim($string);
		$string = str_replace(array('á','à','ä','â','ª','Á','À','Â','Ä'),array('a','a','a','a','a','A','A','A','A'),$string );
		$string = str_replace(array('é','è','ë','ê','É','È','Ê','Ë'), array('e','e','e','e','E','E','E','E'), $string);
		$string = str_replace(array('í','ì','ï','î','Í','Ì','Ï','Î'),array('i','i','i','i','I','I','I','I'),$string);
		$string = str_replace(array('ó','ò','ö','ô','Ó','Ò','Ö','Ô'),array('o','o','o','o','O','O','O','O'), $string);
		$string = str_replace(array('ú','ù','ü','û','Ú','Ù','Û','Ü'),array('u','u','u','u','U','U','U','U'), $string );
		$string = str_replace(array('ñ','Ñ','ç','Ç'), array('n','N','c','C'),$string );
		//Esta parte se encarga de eliminar cualquier caracter extraño
		$string = str_replace(array("\\","¨","º","-","~","#","@","|","!","\"","·","$","%","&","/","(",")","?","'","¡","¿","[","^","<code>","]","+","}","{","¨","´",">","<",";",",",":","."," "),'', $string);
		return $string;
	}

	// Captura y almacena datos de entrada si son requeridos y/o listados
	function check_data($data,$force = false , $refdata = NULL){
		$clean_data = [];
		$required = $refdata ? $refdata : $this->cols;
		foreach($required as $col => $req){
			if($req || $force){
				if(isset($data[$col])){
					@$clean_data[$col] = $data[$col];
				}else{
					// No puede continuar si Falta una variable Requerida no se ejecuta con force
					if(!$force){
						return false;
					}
				}
			}else{
				// No es requerida agrega si existe en el listado
				@$clean_data[$col] = $data[$col];
			}
		}
		return $clean_data;
	}

	function uID($lenght = 30) {
		// uniqid gives 30 chars, but you could adjust it to your needs.
		if (function_exists("random_bytes")) {
			$bytes = random_bytes(ceil($lenght / 2));
		} elseif (function_exists("openssl_random_pseudo_bytes")) {
			$bytes = openssl_random_pseudo_bytes(ceil($lenght / 2));
		} else {
			throw new Exception("No Existen funciones aleatorias de criptografía segura disponibles");
		}
		return substr(bin2hex($bytes), 0, $lenght);
	}

	function base64_to_image($base64_string, $output_file ,$path=DS) {
		$data = explode(',', $base64_string);
		$info = explode(';',$data[0]);
		$mime = explode(':',$info[0]);
		$smime = explode('/',$mime[1]);
		$ext = $smime[1];
		$file = $output_file.".".$ext;
		$ifp = fopen($output_file, "wb");
		fwrite($ifp, base64_decode($data[1]));
		fclose($ifp);
		return $output_file.".".$ext;
	}

	function storeimage($path,$file,$options){
		/* CREAR LA SUBIDA DE ARCHIVO PARA MODIFICAR */
	}

	function clean_get_method($get,$data){
		$G = @$_GET;
		unset($G['format']);
		$GC = count($G);
		if($GC){
			return $G;
		}else{
			return $data;
		}
	}

	function getauth(){
		$this->db = $this->startdb();
		if(isset($this->auth)){
			$decryptuser = $this->decript($this->auth);
			$getuser = (array) $decryptuser['data'];
			$user = $this->db->get('user_data','*',['ID'=>$getuser['ID']]);
			if($getuser['pass']===$user['pass']){
				return $user;
			}else {
				return false;
			}
		}else{
			return false;
		}
	}

	// Obtine el nivel de acceso del ususario si hay datos en auth
	function getlevel(){
		$level = (array) $this->getauth();
		return @$level['level'];
	}

	// Encriptar el JWT
	function encript($data){
		$token = array(
			'iat'=>time(),                      //Token init
			'exp'=>time() + (24 * 60 * 60),     //Token Expires 24h
			'data' => $data                     //Data encrypted
		);
		return $this->JWT->encode($token,MKEY);
	}

	// Desencriptar el JWT
	function decript($data){
		try{
			$decrypted = (array) $this->JWT->decode($data,MKEY,array('HS256'));
		}catch(Exception $e){
			return $this->response(null,null,"Token Expirada",401);
		}
		$decrypted['data'] = (array) $decrypted['data'];
		return $decrypted;
	}

	// Encriptar contraseña
	function crypt_pass($string){
		$encripted = crypt($string,KEY_HASH);
		$ec = ltrim($encripted,KEY_HASH);
		return $ec;
	}

	function getimgtxt($imageb64){
		$data = NULL;
		$d1 = explode(',',$imageb64);
		if($d1[0]!=""){
			$d2 = explode(';',@$d1[0]);
			$d3 = explode(':',@$d2[0]);
			$d4 = explode('/',@$d3[1]);
			$data['mime'] = isset($d2[0])?$d2[0]:NULL;
			$data['ext'] = isset($d4[1])?$d4[1]:NULL;
			$data['image'] = isset($d1[1])?$d1[1]:NULL;
		}
		return $data;
	}

	function txt2img($b64img,$filename,$path){
		$imageraw = $this->getimgtxt($b64img);
		$file = NULL;
		if($imageraw['image']){
			$file = $path.$filename.".".$imageraw['ext'];
			$ifp = fopen($file,"wb");
			fwrite($ifp,base64_decode($imageraw['image']));
			fclose($ifp);
			return $file;
		}else{
			return NULL;
		}
	}

	function dateload($mode = ''){
			$get_num_day = date('w');
			$get_num_month = date('n');
			$get_day = date('d');
			$get_month = date('m');
			$get_year = date('Y');
			$get_hour = date('h');
			$get_24hour = date('H');
			$get_minute = date('i');
			$get_second = date('s');
			$get_ampm = date('A');
			$day = [
				"Domingo",
				"Lunes",
				"Martes",
				"Miercoles",
				"Jueves",
				"Viernes",
				"S&aacute;bado"
			];
			$month = [
				"",
				"Enero",
				"Febrero",
				"Marzo",
				"Abril",
				"Mayo",
				"Junio",
				"Julio",
				"Agosto",
				"Septiembre",
				"Octubre",
				"Noviembre",
				"Diciembre"
			];
			switch($mode){
				case "1":
					$date = "$get_day/$get_month/$get_year";
				break;
				case "2":
					$date = "$day[$get_num_day], $get_day de $month [$get_num_month] de $get_year";
				break;
				case "3":
					$date = "$get_hour:$get_minute:$get_second $get_ampm";
				break;
				case "4":
					$date = "$get_24hour:$get_minute:$get_second";
				break;
				case "5":
					$date = "$get_24hour:$get_minute:$get_second";
				break;
				default:
					$date = "$get_year-$get_month-$get_day";
				break;
			}
			return $date;
	}
}
?>
