<?php
// Cargador de clases y configuraación
define('_DSP',DIRECTORY_SEPARATOR);
// Configuracion de Archivo
include_once(__DIR__._DSP.'config'._DSP.'config.php');
function loadClass($className) {
    $fileName = '';
    $namespace = '';
    // Sets the include path as the "src" directory
    $includePath = dirname(__FILE__);
    if (false !== ($lastNsPos = strripos($className, '\\'))) {
        $namespace = substr($className, 0, $lastNsPos);
        $className = substr($className, $lastNsPos + 1);
        $fileName = str_replace("\\", _DSP, $namespace) . _DSP;
    }
    $fileName .= str_replace('_', _DSP, $className) . '.php';
    $fullFileName = $includePath . _DSP . $fileName;
    if (file_exists($fullFileName)) { require $fullFileName; } else { echo 'Class "'.$className.'" no existe.'; }
}
spl_autoload_register('loadClass'); // Registers the autoloader
?>
