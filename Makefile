.PHONY: up rm-dev dev-down

dev:
	docker-compose up -d --build

dev-logs:
	docker-compose logs -f

rm-dev:
	docker-compose rm

dev-down:
	docker-compose down