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
	sqlx migrate add -r create_users_table
	sqlx migrate add -r create_user_skills_table
	sqlx migrate add -r create_projects_table
	sqlx migrate add -r create_proposals_table
	sqlx migrate add -r create_contracts_table
	sqlx migrate add -r create_payments_table
	sqlx migrate add -r create_reviews_table
	sqlx migrate add -r create_messages_table
	sqlx migrate add -r create_notifications_table

migrate-up:
	sqlx migrate run

migrate-down:
	sqlx migrate revert

up:
	docker-compose up --build

down:
	docker-compose down

restart:
	docker-compose down -v && docker-compose up --build

logs:
	docker-compose logs -f app

start:
	cargo run

