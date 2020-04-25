.PHONY: infra-setup
infra-setup:
	docker-compose build
	docker-compose run --rm app bash -c 'mix deps.get && mix ecto.setup'
	docker-compose run --rm app bash -c 'cd assets && npm install && npm audit fix'

.PHONY: infra-up
infra-up:
	docker-compose up

.PHONY: infra-up-d
infra-up-d:
	docker-compose up -d

.PHONY: infra-down
infra-down:
	docker-compose down

.PHONY: infra-restart-app
infra-restart-app:
	# docker-compose stop app && docker-compose start app
	docker-compose restart app

.PHONY: infra-logs
infra-logs:
	docker-compose logs -f

.PHONY: app-shell
app-shell:
	docker-compose exec app bash
	# docker-compose run --rm app bash

.PHONY: phoenix-server
phoenix-server:
	docker-compose exec app mix phx.server

.PHONY: phoenix-migrate
phoenix-migrate:
	docker-compose exec app mix ecto.migrate

.PHONY: phoenix-seeds
phoenix-seeds:
	docker-compose exec app mix run priv/repo/seeds.exs

.PHONY: phoenix-routes
phoenix-routes:
	docker-compose exec app mix phx.routes

.PHONY: phoenix-swagger-generate
phoenix-swagger-generate:
	docker-compose exec app mix phx.swagger.generate

.PHONY: phoenix-install
phoenix-install:
	docker-compose run --rm app mix deps.get

.PHONY: phoenix-test
phoenix-test:
	docker-compose run --rm -e MIX_ENV=test app mix test

.PHONY: phoenix-console
phoenix-console:
	docker-compose exec app iex -S mix

.PHONY: phoenix-credo
phoenix-credo:
	docker-compose exec app mix credo -a

.PHONY: db-console
db-console:
	docker-compose exec db mysql -uroot -ppassword
