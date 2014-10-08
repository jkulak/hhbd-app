<?php
try {
    $payload = json_decode($_REQUEST['payload']);
} catch(Exception $e) {
    exit(0);
}

//log the request
file_put_contents('logs/github.txt', print_r($payload, TRUE), FILE_APPEND);

if ($payload->ref === 'refs/heads/master') {
    $cmd = './deploy.sh ' . $payload['head_commit']['id'] . ' > script.log';
    $result = exec($cmd);
    file_put_contents('logs/script.txt', print_r($payload, TRUE), FILE_APPEND);
}
