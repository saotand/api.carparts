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

class user extends core{

	protected $cols = [
		'email'			=> true,
		'pass'			=> true,
		'name'			=> true,
		'last'			=> true,
		'doc'				=> true,
		'doctype'		=> true,
		'nac'				=> true,
		'created'		=> false,
		'phone'			=> false,
		'birth'			=> false,
		'level'			=> false,
		'seller'		=> false,
		'profile'		=> false,
		'image'			=> false
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
		if($ID){
			$this->msg = "Cargado ".HOY;
			$this->data = $this->user($ID);
		}else{
			$this->msg = "ready";
			$this->data = null;
		}
	}

	// Prepara los datos de envio a la base de datos
	function prepare_data($data , $cols, $id = false){
		$auth = $this->getauth();
		$t = 'users';
		$data_formatted = [];
		if(isset($data['ID'])){
				$ID = $data['ID'];
		}else{
				$data['ID'] = $this->uID();
				$ID = $data['ID'];
		}
		//$ID = @$data['ID'];
		$w = ['ID'=>$ID];
		//Key primary
		$kp = "email";
		//Pass Length
		$pl = 6;
		foreach($cols as $k => $v){
			$ss = isset($data[$k]);
			if($k == 'email'){
				if($v){ // Email requerido
					$checkemail = filter_var($data[$k], FILTER_VALIDATE_EMAIL);
					if($checkemail){
						$checkexists = $this->db->has($t,[$kp=>@$data_formatted[$k]]);
						$is_same_account = $this->db->get($t,'ID',[$kp => $data[$k]]);
						if(!$checkexists && ($auth['ID'] !== $ID ) || ( ($auth['ID']== NULL) && ($ID== NULL))|| ($ID ===$is_same_account) ){
							if($v){
								if($ss){
									$data_formatted[$k] = strtolower($data[$k]);
								}else{
									return $this->response(null,null,$this->l['emailmissing'],406);
								}
							}else{
								if($ss){
									$data_formatted[$k] = strtolower($data[$k]);
								}
							}
						}else{
							// Correo ya existe
							return $this->response(null,null,$this->l['emailtaken'],406);
						}
					}else{
						return $this->response(null,null,$this->l['emailinvalid'],406);
					}
				}else{ // Email no requerido
					if($ss){
						$checkemail = filter_var($data[$k], FILTER_VALIDATE_EMAIL);
						if($checkemail){
							$checkexists = $this->db->has($t,[$kp=>@$data_formatted[$k]]);
							$is_same_account = $this->db->get($t,'ID',[$kp => $data[$k]]);
							if(!$checkexists && ($auth['ID'] !== $ID ) || ( ($auth['ID']== NULL) && ($ID== NULL))|| ($ID ===$is_same_account) ){
								if($ss){
									$data_formatted[$k] = strtolower($data[$k]);
								}
							}else{
								// Correo ya existe
								return $this->response(null,null,$this->l['emailtaken'],406);
							}
						}else{
							return $this->response(null,null,$this->l['emailinvalid'],406);
						}
					}
				}
			}else if($k == 'image'){
				$image_dir = "images/storefiles/users/";
				$oldIMG = $this->db->get('users','image',['ID'=>$data['ID']]);
				if($oldIMG){
					if($data[$k] != $oldIMG){
						unlink($oldIMG);
						$b64img = $this->txt2img($data[$k],$data['ID'],$image_dir);
						$data_formatted['image'] = $b64img;
					}
				}else{
					$b64img = $this->txt2img($data[$k],$data['ID'],$image_dir);
					$data_formatted['image'] = $b64img;
				}
			}elseif($k == 'pass'){
				// Longitud de la contraseña
				$passlength = @(int) strlen($data[$k]);
				// Nos aseguramos de tener el email del usuario a editar
				if(isset($data_formatted[$kp])){
					$email = $data_formatted[$kp];
				}else{
					$email = $this->db->get($t,$kp,$w);
				}
				if($v){
					if($ss){
						if($passlength>=$pl){
							$passdata =  $this->pass($email,$data[$k]);
							$data_formatted[$k] = $passdata;
						}else{
							return $this->response(null,null,sprintf($this->l['passminlength'],$pl),406);
						}
					}else{
						$this->response(null,null,$this->l['passmissing'],406);
					}
				}else{
					if($passlength !== 0){
						if($passlength>=$pl){
							$passdata =  $this->pass($email,$data[$k]);
							$data_formatted[$k] = $passdata;
						}else{
							return $this->response(null,null,sprintf($this->l['passminlength'],$pl),406);
						}
					}
				}
			}else{
				if($v){
					if($ss){
						$data_formatted[$k] = $data[$k];
					}else{
						return $this->response(null,null,sprintf($this->l['requiredfield'],$this->o[$k]),406);
					}
				}else{
					if($ss){
						$data_formatted[$k] = $data[$k];
					}
				}
			}
		}
		if($id){
			$data_formatted['ID']= $ID;
		}
		return $data_formatted;
	}

	// Permite ver si se carga un usuario (LOGIN) o si
	// un campo unico existe
	function exists($where=NULL){
		if(is_null($where)){
			$where = ['ID[!]'=>''];
		}elseif(is_array($where)){
			$response = $this->db->has($this->t,$where);
			return $response;
		}else{
			return false;
		}
	}

// ******* Carga de usuario de JWT AUTENTICACION [auth] *****
    function JWT_user($data){
        if(isset($data['ID']) && isset($data['email'])){
            $w = [
                 'ID'=>$data['ID']
                ,'email'=>$data['email']
            ];
            $is_user = $this->db->has($this->t,$w);
            return $is_user;
        }else{
            return false;
        }
    }

    // Verificar Cuenta de Usuario
    function verify($ID){
        $t = "users";
        $w = ["ID"=>$ID];
        $check = $this->db->has($t,$w);
        if($check){
            $user = $this->db->get($t,'*',$w);
            if($user['verified']){
                $this->response(NULL,NULL,"Usuario ya verificado",406);
            }else{
                $udp = ['verified'=>1];
                $toverify = $this->db->update($t,$udp,$w);
                $q = $this->db->last();
                $e = $this->db->error();
                $a = (int) $toverify->rowCount();
                if($e[2]){
                    // Mostrar error
                    return $this->response(NULL,NULL,"Error al verificar la cuenta",406);
                }else{
                    if($a){
                        // Cuenta verificada
                        return $this->response(NULL,"Cuenta Verificada");
                    }else{
                        // No se pudo verificar la cuenta
                        return $this->response(NULL,"Cuenta ya verificada");
                    }
                }
            }
        }else{
            $this->response(NULL,NULL,"Link de verificacion invalido",404);
        }
    }


    // Mostrar la informacion de un usuarios o todos
    function user($ID = NULL, $cols = null){
        $levelauth = $this->getlevel();
        $t = $this->t; //Tabla de la base de datos
        if($levelauth === "5"){
            if(is_null($cols)){
                $cols = [
                    'ID',
                    'email',
                    'name',
                    'last',
                    'doc',
                    'doctype',
                    'nac',
                    'phone',
                    'level',
                    'birth',
                    'created',
                    'active',
                    'verified',
                    'image'
                ];
            }else{

            }
            unset($cols['pass']);
            if($ID){
                $usx = $this->db->has($t,['ID'=>$ID]);
                if($usx){
                    $user = $this->db->get($t,$cols,['ID'=>$ID]);
                }else{
                    return $this->response(NULL,NULL,'No existe el Usuario','404');
                }
            }else{
                $user = $this->db->select($t,$cols);
            }
            return $this->response($user,'OK');
        }else{
            return $this->response(NULL,NULL,'Se requiere acceso administrativo','404');
        }
    }
// ******************** Crear Contraseña ***************
    function pass($user,$pass){
        $u = strtolower($user);
        $p = strtolower($pass);
        return $this->crypt_pass($user.":".$pass);
    }
// ******************** Inicio de sesion ***************
	function login($data){
		//$t = $this->t;
		$t = 'user_data';
		$c = ['email' => true, 'pass'=> true];
		$sp = 'users_sell_profile'; //Tabla de perfil de ventas
		$se = 'users_seller';       //Tabla de Empresas
		$login_data = $this->prepare_data($data,$c);
		$user = $this->db->get($t,'*',$login_data);
		if($user){
			$ID = $user['ID'];
			$w = ['ID'=>$ID]; // Condicion para buscar el usuario
			// Encriptar el token de usuario para JS
			$tub = "users_ban"; //Tabla de usuarios Baneados
			$banc = ['ID','ban_start','ban_end','ban_details']; //Columnas de tabla ban
			$ban = $this->db->get($tub,$banc,$w);
			if(!$ban){ // Si no esta el usuario en la tabla ban
				// Variables de tabla de configuracion
				$tc = 'users_config';
				$ip = ip2long($_SERVER['SERVER_ADDR']);
				// Constructor de datos para MEDOO
				$data = ['ID' => $ID,'ip' => $ip, 'login_count[+]'=>1];
				// Where en caso de que ya exista
				// Si ya existe los datos en configuracion
				$ft = $this->db->has($tc,$w);
				if($ft){
					$this->db->update($tc,$data,$w);
				}else{
					unset($data['login_count[+]']);
					$data['theme'] = 1;
					$data['login_count'] = 1;
					$this->db->insert($tc,$data);
				}
				$wID = ['userID'=>$user['ID']];
				// Si es un vendedor
				if($user['level']==1){
					// Agregamos El perfil de vendedor a la carga del usuario
					$user['profile'] = $this->db->select($sp,'sell',$wID);
					// Agregamos la empresa al perfil del Vendedor
					$user['seller'] = $this->db->get($se,'*',$wID);
				}
				// Creacion del token para el frontend
				$this->token = $this->encript($user);
				// Molde para enviar datos de respuesta [frontend]
				$datareturn = ['token' => $this->token /*, 'user' => $user */ ];
				return $this->response($datareturn,$this->l['login']);
			}else{
				$ban_descrip = isset($ban['ban_details'])?': '.$ban['ban_details'] : NULL;
				return $this->response(null,null,sprintf($this->l['userbanned'],$ban_descrip), '401');
			}
		}else{
			// Datos de usuario invalidos
			return $this->response(null,null,$this->l['invalid'], '401');
		}
	}

// ******************** Añadir nuevo usuario ***************
	function add($data,$returnID = false){
		$t = $this->t;              //Tabla usuarios
		$sp = 'users_sell_profile'; //Tabla de perfil de ventas
		$se = 'users_seller';       //Tabla de Empresas
		$c = $this->cols;           //Columnas de tabla
		$x = 'email';               //Columna Indice
		$x2 = 'doc';                // 2ª columna indice
		$levelauth = $this->getlevel();
		$get_data = isset($data)?$data:NULL;
		if($get_data){
			$X = $get_data[$x];
			$iX = [$x => $X];
			$X2 = $get_data[$x2];
			$iX2 = [$x2 => $X2];
			$emailcheck = $this->exists($iX);
			$doccheck = $this->exists($iX2);
			if(!$emailcheck){ // Si no Existe el usuario
				if(!$doccheck){ // Si no se repite la ID (Cedula o documento Similar)
					$db_data = $this->prepare_data($get_data,$c,true); // Limpiar Datos solo requeridos y opcionales
					if(isset($db_data['level'])){
						$level = $db_data['level'];
						if($level>1){
							if($levelauth=="5"){
								// Autorizado para poner ese nivel
							}else{
								// No autorizado para poner ese nivel
								return $this->response(null,null,$this->l['userdenied'],406);
							}
						}
					}
					// Identificador de Base de Datos de Usuario ID unico en Sistema
					//$db_data['ID'] = $this->uID();
					$wID = ['ID'=>$db_data['ID']];
					// Si es vendedor
					if($level==1){
						// Agregar datos de Perfil de vendedor
						if(isset($db_data['profile'])){
							$profile_error = false;
							$profile = $db_data['profile'];
							foreach($profile as $pID){
								$dataProfileEach = ['userID'=>$db_data['ID'],'sell'=>$pID];
								$already = $this->db->get($sp,'*',$dataProfileEach);
								if(!$already){
									$pInsert =  $this->db->insert($sp,$dataProfileEach);
									$pQuery =   $this->db->last();
									$pError =   $this->db->error();
								}
								if($pError){
									$profile_error = true;
								}
							}
						}
						// Agregar datos de Empresa
						if(isset($db_data['seller'])){
							$seller = $db_data['seller'];
							if($seller['image']){
								$image = $seller['image'];
								unset($seller['image']);
								// ****** AGREGAR FUNCION DE subir IMAGEN Y DEVOLVER LA DIRECCION URL
							}
							$seller['userID'] = $db_data['ID'];
							$addCompany = $this->db->insert($se,$seller);
							$pQuery = $this->db->last();
							$pError = $this->db->error();
						}
					}
					// Limpiar los datos de Vendedor y perfil de la consulta SQL Principal
					unset($db_data['profile']);
					unset($db_data['seller']);
					// Agregamos el usuario a la Base de Datos
					$inserted = $this->db->insert($t,$db_data);
					// Verificamos que Se agrego el usuario (Filas Afectadas)
					$affected = $inserted->rowCount();
					// Consulta para depuracion [var_dump($query);]
					$query = $this->db->last();
					// Error para depuracion [var_dump($error);]
					$error = $this->db->error();
					// Consultamos los Datos de usuario para comprobar los datos
					$newuserdata = $this->db->get($t,'*',$wID);
					// Si es un vendedor
					if($newuserdata['level']==1){
						// Agregamos El perfil de vendedor a la carga del usuario
						$newuserdata['profile'] = $this->db->select($sp,'*',$wID);
						// Agregamos la empresa al perfil del Vendedor
						$newuserdata['seller'] = $this->db->get($se,'*',$wID);
					}
					// Creacion del token para el frontend
					$this->token = $this->encript($newuserdata);
					$datareturn = ['token' => $this->token /*, user' => $user */];
					if($affected){
						if($returnID){
							return $this->response($newuserdata,$this->l['created']);
						}else{
							return $this->response($datareturn,$this->l['created']);
						}
					}else{
						if(isset($error[2])){
							return $this->response(null,null,$this->l['cannotcreate'],406);
						}else{
							return $this->response(null,$this->l['nochange']);
						}
					}
				}else{
					return $this->response(null,null,$this->l['docexists'],406);
				}
			}else{
				return $this->response(null,null,$this->l['emailexist'],406);
			}
		}else{
			return $this->response(null, null,$this->l['emptyform']);
		}
	}


	// Editar Usuario
	function edit($data){
		$t = $this->t;
		// Al editar todos los campos son opcionales
		$c = [
			'email'     => false,
			'pass'      => false,
			'name'      => false,
			'last'      => false,
			'doc'       => false,
			'doctype'   => false,
			'nac'       => false,
			'created'   => false,
			'phone'     => false,
			'birth'     => false,
			'level'     => false,
			'image'     => false
		];
		// Datos de usuario quien hace la edicion
		$userauth = $this->getauth();
		// Captura de array de entrada
		$getData = (array) isset($data)?$this->prepare_data($data,$c):NULL;
		// Obtiene le ID de la cuenta que se va a editar
		$ID = isset($data['ID'])?$data['ID']:NULL;
		// Condicion en consulta para cambiar cuenta de usuario
		$w = ['ID'=>$ID];
		// Verificamos si el usuario Existe
		$user = $this->db->has($t,$w);
		// Si el usuario Existe
		if($user){
			$userdata = $this->db->get($t,'*',$w);
			if($userauth['ID'] === $userdata['ID']){ // El usuario edita su perfil
				if($userauth['level'] === "5"){ // El usuario tiene privilegios para editar nivel
				}else{ //el usuario no tiene privilegios para editar el nivel
					unset($userdata['level']);
				}
			}else{ // Otro usuario esta editando el perfil
				if($userauth['level'] === "5"){ // El usuario tiene privilegios para editar nivel
				}else{ //el usuario no tiene privilegios para editar el nivel
					unset($userdata['level']);
				}
			}
			$update_user = $this->db->update($t,$getData,$w);
			$returneditdata = $this->db->get($t,'*',$w);
			unset($returneditdata['pass']);
			$q = $this->db->last();
			$e = $this->db->error();
			$a = $update_user->rowCount();
			if($a){
				// Operacion realizada
				return $this->response($returneditdata,'OK',null,202);
			}else{
				if($e[2]){
					// Si hay error
					return $this->response(null,null,'error en DB',406);
				}else{
					// no se realizaron cambios
					return $this->response('OK',$this->l['nochange']);
				}
			}
		}else{
			return $this->response(null,null,$this->l['noexist'],404);
		}
	}

	// Eliminar Usuario
	function delete($data){
		$auth = $this->getauth();
		$t = $this->t;
		$w = ['ID'=>$data];
		if($auth['level'] === "5"){
			$cuser = $this->db->has($t,$w);
			if($cuser){
				$delete = $this->db->delete($t,$w);
				$a = $delete->rowCount();
				$e = $this->db->error();
				$q = $this->db->last();
				if($a){
					return $this->response(['delete'=>$data],'Usuario Eliminado');
				}else{
					if($e[2]){
						return $this->response(null,null,"Error al eliminar el usuario",406);
					}else{
						return $this->response(null,null,"No se pudo eliminar el usuario",404);
					}
				}
			}else{
				return $this->response(null,null,"No Existe el usuario",404);
			}
		}else{
			return $this->response(null,null,"No puedes Eliminar Usuarios",406);
		}
	}

	function check_user($data){
		$result = $this->db->has($this->t,$data);
		$qry = $this->db->last();
		$error = $this->db->error();
		if($error[2]){
			return $this->response(null,null,"Consulta invalida",'404');
		}
		return $this->response($result);
	}

	function autoload(){
		$auth = $this->getauth();
		if($auth){
			return $this->response(['autocargado'=>true],'OK');
		}else{
			return $this->response(null,null,"Token Invalida");
		}
	}

	function logout(){
		$auth = $this->getauth();
		if($auth){
			return $this->response(true,"Has cerrado session");
		}else{
			return $this->response(false,"Error al Cerrar session");
		}
	}
}
?>

