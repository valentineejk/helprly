use serde::{Deserialize, Serialize};

pub const REFRESH_EXP: i64 = 60 * 60 * 24 * 30; 

#[derive(Deserialize, Serialize, Debug, Clone, Default)]
pub struct  Claims {
    
}