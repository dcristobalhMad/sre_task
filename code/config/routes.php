<?php

declare(strict_types=1);

use GR\DevEnvBoilerplate\Infrastructure\Slim\Action\Pokemon\ViewAction;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Slim\App;

return static function (App $app) {
    $app->options('/{routes:.*}', function (Request $request, Response $response) {
        // CORS Pre-Flight OPTIONS Request Handler
        return $response;
    });

    $app->get('/healthz', function (Request $request, Response $response) {
        // Endpoint to check health
        $data = ['status' => 'Up and running!'];
        $payload = json_encode($data, JSON_PRETTY_PRINT);
        
        $response->getBody()->write($payload);
        return $response
            ->withHeader('Content-Type', 'application/json')
            ->withStatus(200);
    });

    $app->get('/{pokemon}', ViewAction::class);
};
