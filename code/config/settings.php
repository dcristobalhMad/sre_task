<?php

declare(strict_types=1);

use GR\DevEnvBoilerplate\Infrastructure\Slim\Setting\Settings;
use GR\DevEnvBoilerplate\Infrastructure\Slim\Setting\SettingsInterface;
use DI\ContainerBuilder;
use Monolog\Logger;

return static function (ContainerBuilder $containerBuilder) {
    // Global Settings Object
    $containerBuilder->addDefinitions([
        SettingsInterface::class => function () {
            return new Settings([
                'displayErrorDetails' => true, // Should be set to false in production
                'logError'            => false,
                'logErrorDetails'     => false,
                'logger' => [
                    'name' => 'slim-app',
                    'path' => isset($_ENV['docker']) ? 'php://stdout' : __DIR__ . '/../logs/app.log',
                    'level' => Logger::DEBUG,
                ],
                'database' => [
                    'host' => $_ENV['DB_HOST'] ?? 'mysql',
                    'port' => $_ENV['DB_PORT'] ?? '3306',
                    'name' => $_ENV['DB_NAME'] ?? 'minipokedex',
                    'user' => $_ENV['DB_USER'] ?? 'pokemonuser',
                    'password' => $_ENV['DB_PASSWORD'] ?? 'pokemonpassword',
                    'charset' => $_ENV['DB_CHARSET'] ?? 'utf8mb4',
                ],
                'redis' => [
                    'schema' => 'tcp',
                    'host' => $_ENV['REDIS_HOST'] ?? 'redis',
                    'port' => $_ENV['REDIS_PORT'] ?? '6379',
                ],
                'memcached' => [
                    'host' => $_ENV['MEMCACHED_HOST'] ?? 'memcached',
                    'port' => $_ENV['MEMCACHED_PORT'] ?? 11211,
                ],
            ]);
        }
    ]);
};

