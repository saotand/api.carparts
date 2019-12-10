<?php

namespace Firebase\JWT;

class BeforeValidException extends \UnexpectedValueException{
    function __construct(){
        header('Content-type: application/JSON');
        http_response_code(406);
        $response = [
            "data"      => false,
            "message"   => false,
            "error"     => "Token created before valid",
            "code"      => 406
        ];
        echo json_encode($response);
    }
}

?>
