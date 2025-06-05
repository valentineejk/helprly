

use actix_web::web;
use crate::handler::handler;

pub fn server_routes(cfg: &mut web::ServiceConfig) {
    let sr = web::scope("/api/v1")
        .service(handler::health);

    cfg.service(sr);
}