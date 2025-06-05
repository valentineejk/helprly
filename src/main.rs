mod routes;
mod handler;
mod config;
mod auth;
mod models;

use actix_cors::Cors;
use actix_web::{http, App, HttpServer};
use actix_web::middleware::Logger;
// use dotenv::dotenv;
use sqlx::{Pool, Postgres};
use crate::routes::server_routes::server_routes;
use crate::config::config::init_db_pool;


struct AppState {
    db: Pool<Postgres>
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    println!("🟡 Starting Helprly server...");


    if std::env::var_os("RUST_LOG").is_none() {
        unsafe {
            std::env::set_var("RUST_LOG", "actix_web=info");
        }
    }

    // dotenv().ok();
    env_logger::init();

    //postgres setup
    let pool = init_db_pool().await;
    log::info!("✅ Connected to PostgresSQL");

    // 📌 Start HTTP server
    log::info!("🚀 Starting server on http://127.0.0.1:8080");

    HttpServer::new(move|| {

        let cors = Cors::default()
            .allowed_origin("http://localhost:3000")
            .allowed_methods(vec!["GET", "POST", "PUT", "DELETE"])
            .allowed_headers(vec! [
                http::header::AUTHORIZATION,
                http::header::ACCEPT,
                http::header::CONTENT_TYPE
            ]).supports_credentials()
            .max_age(3600);
            


        App::new()
            .app_data(actix_web::web::Data::new(AppState {
                db: pool.clone(),
            }))
            .configure(server_routes)
            .wrap(cors)
            .wrap(Logger::default())
    })
        .bind(("0.0.0.0", 8000))?
        .run()
        .await
}