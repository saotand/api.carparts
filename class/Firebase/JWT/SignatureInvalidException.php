<?php

namespace Firebase\JWT;

class SignatureInvalidException extends \UnexpectedValueException{
    function __construct(){
        header('Content-type: application/JSON');
        http_response_code(406);
        $response = [
            "data"=>false,
            "message" => false,
            "error"=> "Token Signature Invalid",
            "code"=> 406
        ];
        return json_encode($response);
    }
}

?>