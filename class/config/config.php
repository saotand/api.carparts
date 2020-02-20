<?php
 /* Archivo de Constantes y Funciones Nativas en ApiCore */
// Valores de constantes Definidas por el usuario

//Ajuste de configuracion inicial del servidor
ini_set("default_charset", 'utf-8');
ini_set('memory_limit', '256M');
date_default_timezone_set('America/Caracas');

$config = [
    // Contraseñas
    'MKEY'=>'Cpvz13A1otc',    // String SALT Contraseña para JWT
    'KEY_HASH'=>'$1$'.'E2vv_wea'.'$',         // Build completo de Salt Contraseñas Cript [Cambiar en Cont HASH]

    // Estos Valores no se puede cambiar
    //Constantes Basicas
    'APP'=>'Carparts',                   // Nombre de nucleo
    'WEBMASTER'=>'David Salinas',       // Programador
    'DEVELOPER'=>'www.turepuesto.com',  // Sitio de Desarrollador
    'VER'=>'0.1.1b',                // Version de plataforma
    'REV'=>'23.06.2019',                // Ultimas modificaciones
    'MODE'=>'debug',                    // debug or production
    'BASEURL'=>'http://'."{$_SERVER['HTTP_HOST']}/",                // Base URL completa
    'IP'=>"{$_SERVER['REMOTE_ADDR']}",  // IP de Cliente

    // Valores de fechas Usados en Estadisticas

    "AHORA"=>time(),                                // Tiempo Unix Fecha Hoy
    "DIAP"=>((1 * 24 * 60 * 60 )*30),                     // Tiempo Unix 1 dia

    "D"=>date("d"), "M"=>date("m"), "Y"=>date("Y"),                                                 //Dia Mes Año
    "HOY"=>date("Y-m-d"),                                                                           // Fecha Hoy
    "AYER"=>date('Y-m-d',strtotime("-1 day",strtotime(date("Y-m-d")))),                             // Fecha Ayer
    "MES"=>date('Y-m-d',strtotime("0 month",strtotime(date(date("Y").'-'.date("m").'-01')))),       // Fecha primer dia Mes
    "MES_EX"=>date('Y-m-d',strtotime("-1 month",strtotime(date("Y-m-d")))),                         // Fecha Mes Anterior
    "MES_EX2"=>date('Y-m-d',strtotime("-2 month",strtotime(date("Y-m-d")))),                        // Fecha 2 mes Anterior
    "ANO"=>date('Y-m-d',strtotime("0 year",strtotime(date(date("Y").'-01-01')))),                   // Fecha primer dia año
    "ANO_EX"=>date('Y-m-d',strtotime("-1 year",strtotime(date("Y-m-d")))),                          // fecha año anterior
    "ANO_EX2"=>date('Y-m-d',strtotime("-2 year",strtotime(date("Y-m-d")))),                         // fecha año anterior
    "NOW" => date('H:i:s')                                                                          // Hora Actual
    ,
    //Configuracion de Correo Electronico
    'BASEMAIL'=>'',
    'BASEMAILPASS'=>'',
    //Config STMP
    'BASESMTP'=>'',
    'SMTPORT'=>'',
    //Config POP3
    'BASEPOP3'=>'',
    'POP3PORT'=>'',

];

// Declaración de contantes array Config
foreach($config as $key => $val){
    define($key,$val);
}

// Configuracion de base de Datos
// MySQL
$MySQL0 = [
    // required
    'database_type' => 'mysql',
    'database_name' => 'turepuesto',
    'server'        => 'localhost',
    'username'      => 'root',
    'password'      => 'mysql',

    // [optional]
    'charset'       => 'utf8',
    'port'          => 3306,

    // [optional] Table prefix
    'prefix'        => '',

    // [optional] Enable logging (Logging is disabled by default for better performance)
    'logging'       => true,

    // [optional] MySQL socket (shouldn't be used with server and port)
    //'socket' => '/tmp/mysql.sock',

    // [optional] driver_option for connection, read more from http://www.php.net/manual/en/pdo.setattribute.php
    'option'        => [PDO::ATTR_CASE => PDO::CASE_NATURAL],

    // [optional] Medoo will execute those commands after connected to the database for initialization
    'command'       => ['SET SQL_MODE=ANSI_QUOTES']
];

// Configuracion de base de Datos
// MySQL
$MySQL1 = [
    // required
    'database_type' => 'mysql',
    'database_name' => 'grupo77_turepuesto',
    'server'        => 'localhost',
    'username'      => 'grupo77_repuesto',
    'password'      => 'd0708aca',

    // [optional]
    'charset'       => 'utf8',
    'port'          => 3306,

    // [optional] Table prefix
    'prefix'        => '',

    // [optional] Enable logging (Logging is disabled by default for better performance)
    'logging'       => true,

    // [optional] MySQL socket (shouldn't be used with server and port)
    //'socket' => '/tmp/mysql.sock',

    // [optional] driver_option for connection, read more from http://www.php.net/manual/en/pdo.setattribute.php
    'option'        => [PDO::ATTR_CASE => PDO::CASE_NATURAL],

    // [optional] Medoo will execute those commands after connected to the database for initialization
    'command'       => ['SET SQL_MODE=ANSI_QUOTES']
];

// MSSQL
$MSSQL = [
    'database_type' => 'mssql',
    'database_name' => '',
    'server' => 'localhost',
    'username' => '',
    'password' => '',
    // [optional] If you want to force Medoo to use dblib driver for connecting MSSQL database
    'driver' => 'dblib'
];

// SQLite
$SQLite = [
    'database_type' => 'sqlite',
    'database_file' => __DIR__.DIRECTORY_SEPARATOR.'db'.DIRECTORY_SEPARATOR.'database.db'
];

// Memory database
$memory = [
    'database_type' => 'sqlite',
    'database_file' => ':memory:'
];

//$conexion = $SQLite;
$conexion = $MySQL1;
//$conexion = $memory;

$JWT_DATA = [
    "token_base" => array(
        "iss"       => BASEURL,
        "aud"       => BASEURL,
        "auth_time" => AHORA,
        "iat"       => AHORA,
        "exp"       => AHORA + DIAP
    ),
    "algorithms" => array('HS256')
];

/*
  determine which language out of an available set the user prefers most
  $available_languages        array with language-tag-strings (must be lowercase) that are available
  $http_accept_language    a HTTP_ACCEPT_LANGUAGE string (read from $_SERVER['HTTP_ACCEPT_LANGUAGE'] if left out)
*/
function prefered_language ($available_languages,$http_accept_language="auto") {
    // if $http_accept_language was left out, read it from the HTTP-Header
    if ($http_accept_language == "auto") $http_accept_language = isset($_SERVER['HTTP_ACCEPT_LANGUAGE']) ? $_SERVER['HTTP_ACCEPT_LANGUAGE'] : '';

    // standard  for HTTP_ACCEPT_LANGUAGE is defined under
    // http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.4
    // pattern to find is therefore something like this:
    //    1#( language-range [ ";" "q" "=" qvalue ] )
    // where:
    //    language-range  = ( ( 1*8ALPHA *( "-" 1*8ALPHA ) ) | "*" )
    //    qvalue         = ( "0" [ "." 0*3DIGIT ] )
    //            | ( "1" [ "." 0*3("0") ] )
    preg_match_all("/([[:alpha:]]{1,8})(-([[:alpha:]|-]{1,8}))?" .
                   "(\s*;\s*q\s*=\s*(1\.0{0,3}|0\.\d{0,3}))?\s*(,|$)/i",
                   $http_accept_language, $hits, PREG_SET_ORDER);

    // default language (in case of no hits) is the first in the array
    $bestlang = $available_languages[0];
    $bestqval = 0;

    foreach ($hits as $arr) {
        // read data from the array of this hit
        $langprefix = strtolower ($arr[1]);
        if (!empty($arr[3])) {
            $langrange = strtolower ($arr[3]);
            $language = $langprefix . "-" . $langrange;
        }
        else $language = $langprefix;
        $qvalue = 1.0;
        if (!empty($arr[5])) $qvalue = floatval($arr[5]);

        // find q-maximal language
        if (in_array($language,$available_languages) && ($qvalue > $bestqval)) {
            $bestlang = $language;
            $bestqval = $qvalue;
        }
        // if no direct hit, try the prefix only but decrease q-value by 10% (as http_negotiate_language does)
        else if (in_array($langprefix,$available_languages) && (($qvalue*0.9) > $bestqval)) {
            $bestlang = $langprefix;
            $bestqval = $qvalue*0.9;
        }
    }
    return $bestlang;
}


$langs = [
    'es' => 'esES',
    'la' => 'esLA',
    'en' => 'enUS'
];

$pref_lang = prefered_language(array_keys($langs));

$_lng = $langs[$pref_lang];

$lngpath = __DIR__.DIRECTORY_SEPARATOR.'lang'.DIRECTORY_SEPARATOR.$_lng.'.php';
if(file_exists($lngpath)){
    require_once($lngpath);
}else{
    $_lgn = $langs['es'];
    $lngpath = __DIR__.DIRECTORY_SEPARATOR.'lang'.DIRECTORY_SEPARATOR.$_lgn.'.php';
    require_once($lngpath);
}
?>
