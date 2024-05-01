# Solution

## Summary

- Upgrade predis/predis to the latest version
- Install php-memcached packaged and enable it in php.ini
- Set in settings.php dinamic values for Redis, MySQL and Memcached with environment variables
- Execute database migrations in the application and grant permissions to the application user
- Dockerize the application
- Use docker-compose to run the application and its dependencies
- Add a Makefile to simplify the execution of the application in local
- Deploy a kubernetes cluster in Terraform
- Deploy core apps in the cluster with FluxCD
- Create secrets in each environment (Staging and production) with the values of the environment variables
- Deploy the application in the cluster with Helm in two environments (Staging and Production)
