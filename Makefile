DB_DOCKER_CONTAINER=helprly

install:
	cargo add actix-web
	cargo add actix-cors
	cargo add serde_json
	cargo add serde --features derive
	cargo add chrono --features serde
	cargo add env_logger
	cargo add dotenv
	cargo add uuid --features "serde v4"
	cargo add sqlx --features "runtime-async-std-native-tls postgres chrono uuid"

# SQLX-CLI
	cargo install sqlx-cli


create_migrations:
	sqlx migrate add -r init

migrate-up:
	sqlx migrate run

migrate-down:
	sqlx migrate revert

stop_containers:
	@echo "Stopping all docker containers..."
	if [ $$(docker ps -q) ]; then \
		echo "found and stopped containers..."; \
		docker stop $$(docker ps -q); \
	else \
		echo "no active containers found..."; \
	fi


start:
	cargo run

