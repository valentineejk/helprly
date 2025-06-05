use dotenv::dotenv;
use sqlx::PgPool;
use sqlx::postgres::PgPoolOptions;

pub async fn init_db_pool() -> PgPool {

    dotenv().ok();

    
    let database_url = std::env::var("DATABASE_URL").expect("DATABASE_URL must be set");
    
    
    match PgPoolOptions::new()
        .max_connections(5)
        .connect(&database_url)
        .await

    {
        Ok(pool) => {
            println!("Successfully connected to database ");
            pool
        },
        Err(_pool) => {
            println!("Failed to connect to database ");
            std::process::exit(1);
        }
    }
}