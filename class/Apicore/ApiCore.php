<?php
/*******************************************************
 * 
 *      Nucleo de API de consultas turepuesto.com
 * 
 ******************************************************/

namespace ApiCore;

use 
\Jacwright\RestServer\RestException,
\ApiCore\modules\user,
\ApiCore\modules\car,
\ApiCore\modules\ask,
\Apicore\modules\response,
\Apicore\modules\notification,
\Apicore\modules\location;


class ApiCore extends bin\Core {
    function __construct(){
        bin\Core::__construct();
        try{
            // Registro de modulos de Backend
            $this->user = new user;
            $this->car = new car;
            $this->ask = new ask;
            $this->response = new response;
            $this->location = new location;
            $this->notification = new notification;
            //$this->upd = new upload;
        }catch(PDOException $e){
            die('no se pudo conectar');
        }
    }

    /**
     * Main with no attributes load on server
     * @noAuth
     * @url GET /
     */
    public function main(){
        return ['data'=>null,'message'=> 'ready on GET Request'];
    }

    /**
     * Main with no attributes load on server
     * @noAuth
     * @url GET /uigen
     */
    public function uIDgen(){
        return $this->user->uID();
    }

    /**
     * Main with no attributes load on server
     * @noAuth
     * @url GET /about
     */
    public function about(){
        return ['data'=>['application'=>APP,'ver'=>VER,'web'=>DEVELOPER],'message'=> 'ready'];
    }

    /**
     * Registro de Usuario.
     * @noAuth
     * @url POST /login
     */
    public function login(){
        return $this->user->login($this->data);
     }

    /**
     * Nuevo Usuario.
     * @url GET /users
     * @url GET /users/$id
     */
    public function users($id = null){
        
        $user = null;
        if($id){
            $this->response($user = $this->user->user($id));
        }else{
            $this->response($user = $this->user->user());
        }
        return $user;
     }

    /**
     * Nuevo Usuario.
     * @noAuth
     * @url POST /user/new
     */
    public function new_user(){
       return $this->user->add($this->data);
    }

    /**
     * Nuevo Usuario.
     * @url POST /user/add
     */
    public function add_user(){
       return $this->user->add($this->data,true);
    }

    /**
     * Editar Usuario [Datos, Quien, Por].
     * @url POST /user/edit/$ID
     */
    public function edit_user($ID){
        $this->data['ID'] = $ID;
        return $this->user->edit($this->data);
    }

    /**
     * Eliminar Usuario
     * @url POST /user/del/$ID
     */
    public function delete_user($ID){
        return $this->user->delete($ID);
    }    

    /**
     * Carga automatica de token para verificacion
     * @url POST /autoload
     */
    public function autoload(){
        return $this->user->autoload();
    }

    /**
    * Cerrar Session Usuario
    * @url POST /logout
    * @noAuth
    */
    public function logout(){
        return $this->user->logout();
    }

    /**
     * Chequear Usuario [Datos, Quien, Por].
     * @url POST /user/check
     * @noAuth
     */
    public function check_user(){
        return $this->user->check_user($this->data);
    }

    /**
     * Verificacion de cuenta [ID Token].
     * @url GET /user/verify/$ID
     * @noAuth
     */
    public function verify_user($ID){
        return $this->user->verify($ID);
    }





    /**
     * Notificationes
     * @url POST /notifications
     * 
     */
    public function noti(){
        return $this->notification->show_notifications();
    }













































    /**
     * Mostrar Marcas.
     * @url GET /car/brands
     * @noAuth
     */
    public function car_brands(){
        return $this->car->car_brands($this->data);
    }


    /**
     * Mostrar TODAS las Marcas.
     * @url GET /car/brands/all
     */
    public function car_brands_all(){
        return $this->car->car_brands($this->data,true);
    }    


    /**
     * Agregar una nueva Marca
     * @url POST /car/brands/add
     */
    public function car_brands_add(){
        return $this->car->car_brands_add($this->data);
    }

    /**
     * Editar una Marca
     * @url POST /car/brands/edit/$ID
     */
    public function car_brands_edit($ID){
        $this->data['ID'] = $ID;
        return $this->car->car_brands_edit($this->data);
    }

    /**
     * Editar una Marca
     * @url POST /car/brands/del/$ID
     */
    public function car_brands_delete($ID){
        return $this->car->car_brands_delete($ID);
    }


    /**
     * Agregar una nueva Marca
     * @url GET /car/models
     * @noAuth
     */
    public function car_models(){
        return $this->car->car_models($this->data);
    }

    /**
     * Agregar una nueva Marca
     * @url GET /car/models/brand/$ID
     * @noAuth
     */
    public function car_models_fromID($ID){
        return $this->car->car_models($ID);
    }


    /**
     * Mostrar todos los modelos
     * @url GET /car/models/all
     * @noAuth
     */
    public function car_models_all(){
        return $this->car->car_models($this->data,true);
    }    

    /**
     * Agregar un Modelo
     * @url POST /car/models/add
     */
    public function car_models_add(){
        return $this->car->car_models_add($this->data);
    }


    /**
     * Editar Modelo
     * @url POST /car/models/edit/$ID
     */
    public function car_models_edit(){
        return $this->car->car_models_edit($this->data);
    }

    /**
     * Eliminar Modelo
     * @url POST /car/models/del/$ID
     */
    public function car_models_delete($ID){
        return $this->car->car_models_del($ID);
    }    

    /**
     * Mostrar las partes
     * @url GET /car/parts
     * @noAuth
     */
    public function car_parts($data){
        return $this->car->car_parts($data);
    }

    /**
     * Mostrar Solo las partes
     * @url GET /car/mparts
     * @noAuth
     */
    public function car_parts_menu($data){
        return $this->car->car_parts($data,NULL,true);
    }


    /**
     * Mostrar las partes
     * @url GET /car/parts/all
     * @noAuth
     */
    public function car_parts_all($data){
        return $this->car->car_parts($data,true);
    }

    /**
     * Añadir nueva parte
     * @url POST /car/parts/add
     */
    public function car_parts_add($data){
        return $this->car->car_parts_add($data);
    }

    /**
     * Editar Partes
     * @url POST /car/parts/edit/$ID
     */
    public function car_parts_edit($data){
        return $this->car->car_parts_edit($data);
    }

    /**
     * Eliminar Partes
     * @url POST /car/parts/del/$ID
     */
    public function car_parts_del($ID){
        return $this->car->car_parts_del($ID);
    }

    /**
     * Mostrar las Sub partes
     * @url GET /car/subparts/all
     */
    public function car_sub_parts_all($data){
        return $this->car->car_parts_class($data,true);
    }


    /**
     * Añadir Sub partes
     * @url POST /car/subparts/add
     */
    public function car_sub_parts_add($data){
        return $this->car->car_parts_class_add($data);
    }


    /**
     * Añadir Sub partes
     * @url POST /car/subparts/edit/$ID
     */
    public function car_sub_parts_edit($data){
        return $this->car->car_parts_class_edit($data);
    }

    
    /**
     * Eliminar Sub partes
     * @url POST /car/subparts/del/$ID
     */
    public function car_sub_parts_del($ID){
        return $this->car->car_parts_class_del($ID);
    }

    /**
     * Mostrar mis Preguntas (Ask)
     * @url GET /ask/
     */
    public function ask(){
        return $this->ask->ask();
    }

    /**
     * Mostrar Todas las Pregunta (Ask)
     * @url GET /ask/all
     */
    public function ask_all(){
        return $this->ask->ask(null,true);
    }

    /**
     * Mostrar Todas las Pregunta (Ask)
     * @url GET /ask/show/$ID
     */
    public function ask_ID($ID){
        return $this->ask->ask($ID);
    }

    /**
     * Mostrar Todas las Pregunta (Ask)
     * @url POST /ask/sel/$ID
     */
    public function ask_sel($ID){
        return $this->ask->ask_sel($ID);
    }




    /**
     * Crear Pregunta (Ask)
     * @url POST /ask/add
     */
    public function ask_add($data){
        return $this->ask->add($data);
    }


    /**
     * Listado de items para perfil de notificaciones (preguntas)
     * @url GET /ask/notilist
     */
    public function notificationlist($data){
        return $this->ask->notilist($data);
    }


    /**
     * Listado de items para perfil de notificaciones (preguntas)
     * @url GET /ask/notilist/$data
     * @noAuth
     */
    public function notificationlistf($data){
        return $this->ask->notilist($data);
    }


    /**
     * Listado de notificaciones (preguntas)
     * @url POST /ask/notifications/$read
     */
    public function notifications($read = false){
        return $this->ask->notfications($read);
    }


    /**
     * Listado de notificaciones (preguntas)
     * @url POST /ask
     */
    public function asks(){
        return $this->ask->asks();
    }


    /**
     * Mostrar TODAS las Respuestas
     * @url POST /response/
     * 
     */
    public function response_all(){
        return "all responses";
    }

    /**
     * Mostrar Respuesta desde un ID
     * @url POST /response/$responseID
     * 
     */
    public function response_ID($responseID){
        return "show: ".$responseID;
    }

    /**
     * Agregar Respuesta
     * @url POST /response/add/$responseID
     * 
     */
    public function response_add($data,$responseID){
        return $this->response->add($data,$responseID);
    }

    /**
     * Agregar Respuesta
     * @url POST /response/remove/$responseID
     * 
     */
    public function response_remove($responseID){
        return $this->response->remove($responseID);
    }

    /**
     * Listado de Zonas (Localizacion)
     * @url GET /location
     * @noAuth
     */
    public function location(){
        return $this->location->location();
    }

    /**
     * Añadir Zonas
     * @url POST /location
     */
    public function location_add(){
        return $this->location->add_location();
    }


    /**
     * Subir imagen
     * @noAuth
     * @url POST /upload
     */
    public function upload_image($data){
        return $this->upd->loadimage($data);
    }




}
?>