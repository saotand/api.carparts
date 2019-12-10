<?php
// Archivo de lenguaje de mensajes
$lang = [
    'user' => [
        'created'       => "Usuario Creado",
        'invalid'       => "Datos invalidos",
        'login'         => "Acceso autorizado",
        'docexists'     => "Documento de identificacion ya existe",
        'exist'         => "No se puede realizar por que el usuario ya existe",
        'emailtaken'    => "El Correo electronico ya esta en uso",
        'noexist'       => "No se puede realizar por que el usuario no existe",
        'emailexist'    => "No se puede realizar por que el correo ya existe",
        'emailinvalid'  => "Formato de correo electrónico inválido",
        'emailmissing'  => "Debe ingresar el correo electrónico",
        'passmissing'   => "Debe escribir una contraseña",
        'passminlength' => "La contraseña debe tener un minimo de %d caracteres",
        'userbanned'    => "Cuenta de usuario inactiva: %s",
        'requiredfield' => "Falta un campo requerido: %s",
        'nochange'      => "No se Realizaron cambios",
        'create'        => "Usuario creado",
        'cannotcreate'  => "No se pudo crear el usuario debido a un error",
        'nocreate'      => "No puedes crear usuarios",
        'auth'          => "Acceso Autorizado",
        'noauth'        => "No puedes Acceder a este recurso",
        'cannotauth'    => "No puedes autentificarte (Cuenta Bloqueada?)",
        'delete'        => "Usuario Eliminado",
        'nodelete'      => "No puedes eliminar usuarios sin las credenciales apropiadas",
        'cannotdelete'  => "No se pudo eliminar el usuario debido a un error",
        'nodeleteself'  => "No estas autorizado para eliminar tu perfil",
        'edit'          => "Usuario Editado",
        'editself'      => "Informacion actualizada",
        'editnouser'    => "Debes especificar el Usuario a editar",
        'noedit'        => "No tienes permisos para editar este usuario",
        'noeditself'    => "No puedes Editar tu perfil",
        'admin'         => "Acceso de Administrador",
        'noadmin'       => "Solo administradores tienen acceso a este recurso",
        'usernametaken' => "El nombre de usuario no está disponible",
        'emailtaken'    => "El correo electrónico no está diponible",
        'emailwrong'    => "Formato de correo no válido",
        'nicknametaken' => "El apodo ya esta en uso",
        'databaserror'  => "Error en consulta DB  %s",
        'userdenied'    => "No se puede crear el usuario con ese nivel de acceso",
        'emptyform'     => "Se ha enviado datos vacios"
    ],
    'forms' => [
        'form'          => "Formulario",
        'email'         => "Correo electrónico",
        'name'          => "Nombre de usuario",
        'last'          => "Apellido",
        'password'      => "Contraseña",
        'phone'         => "Telefono",
        'doc'           => "Número de identificación (Cedula)",
        'nac'           => "Nacionalidad",
        'doctype'       => "Tipo de documento de identificacion",
        "birth"         => "Fecha de nacimiento"
    ],
 
    'car'=>[
        'car_brands'    => [
            'minlength'     => "El %s debe tener minimo %s caracteres",
            'fieldrequired' => "Falta un campo requerido: %s",
            'duplicated'    => "El valor del campo %s ya existe"
        ],
        'car_models'    => [
            'minlength'     => "El %s debe tener minimo %s caracteres",
            'fieldrequired' => "Falta un campo requerido: %s",
            'duplicated'    => "El valor del campo %s ya existe"
        ],
        'car_years'     => [
            'minlength'     => "El %s debe tener minimo %s caracteres",
            'fieldrequired' => "Falta un campo requerido: %s",
            'duplicated'    => "El valor del campo %s ya existe"
        ],
        'car_parts'     => [
            'minlength'     => "El %s debe tener minimo %s caracteres",
            'fieldrequired' => "Falta un campo requerido: %s",
            'duplicated'    => "El valor del campo %s ya existe"
        ],
        'car_parts_class'=> [
            'minlength'     => "El %s debe tener minimo %s caracteres",
            'fieldrequired' => "Falta un campo requerido: %s",
            'duplicated'    => "El valor del campo %s ya existe"
        ],
        'forms'         => [
            'ID'        => "identificador",
            'name'      => "nombre",
            'brandID'   => "identificador de marca",
            'partID'    => "identificador de parte",
            'image'     => "Imagen"
        ]
    ],
    'ask' => [
        'requests'  => [
            'fieldrequired'=> "Falta un campo requerido: %s"
        ],
        'forms' => [
            'ID'        => "Identificador de la pregunta",
            'userID'      => "Identificador del usuario",
            'brand'     => "Marca",
            'model'     => "Modelo del carro",
            'year'      => "Año del modelo",
            'details'   => "Detalles del repuesto",
            'startdate' => "Fecha de inicio",
            'enddate'   => "Fecha final de la publicacion",
            'active'    => "Estado de la publicacion"
        ]
    ]

];