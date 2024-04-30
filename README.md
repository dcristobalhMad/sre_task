# SRE task

Prueba técnica de SRE para . El objetivo de esta prueba es evaluar las habilidades de un candidato para trabajar en el equipo de SRE

## Criterios de aceptación

- Poder realizar una petición http a un endpoint de la aplicación y obtener una respuesta válida. (statusCode 200)
- Se debe poder ejecutar los tests de integración de la aplicación.


### Dependencias de la aplicación

- Redis
- MySQL
- Memcached
- PHP

Para poder configurar la aplicación de forma correcta se entrega un fichero SQL con los datos mínimos para la creación de la DB y sus datos.

### Misc:

#### Para poder obtener datos de la API podremos realizar una petición a la siguiente URL:

```
http://{server_name}/charmander
```

El resultado de la petición será un JSON con los datos de la API:

```
{
    "statusCode": 200,
    "data": {
        "name": "charmander",
        "type": "fuego",
        "count": 1
    }
}
```

#### Para poder ejecutar los tests de integración de la aplicación podremos ejecutar el siguiente comando:

```
php vendor/bin/phpunit test
```
