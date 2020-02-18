<?php
	include_once('./class/autoloader.php');
	$server = new \Jacwright\RestServer\RestServer(MODE);
	$server->refreshCache(); // uncomment momentarily to clear the cache if classes change in production mode
	$server->addClass('Apicore\ApiCore');
	$server->useCors = true;
	$server->allowedOrigin = '*';
	$server->handle();
?>
