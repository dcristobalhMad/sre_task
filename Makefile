.PHONY: up rm-dev dev-down

dev:
	docker-compose up -d --build

dev-logs:
	docker-compose logs -f

dev-rm:
	docker-compose rm

dev-stop:
	docker-compose down

dev-tests: dev
	docker exec $$(docker-compose ps -q php) sh -c "php vendor/bin/phpunit test"
