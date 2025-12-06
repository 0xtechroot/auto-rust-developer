//! Auto Rust Developer Library
//! 
//! This library is automatically maintained by an AI developer bot
//! that commits code every hour and creates issues autonomously.

pub mod utils;

/// Core application logic
pub struct App {
    pub name: String,
    pub version: String,
}

impl App {
    pub fn new(name: String, version: String) -> Self {
        Self { name, version }
    }
    
    pub fn info(&self) -> String {
        format!("{} v{}", self.name, self.version)
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    
    #[test]
    fn test_app_creation() {
        let app = App::new("TestApp".to_string(), "1.0.0".to_string());
        assert_eq!(app.name, "TestApp");
        assert_eq!(app.version, "1.0.0");
    }
    
    #[test]
    fn test_app_info() {
        let app = App::new("TestApp".to_string(), "1.0.0".to_string());
        assert_eq!(app.info(), "TestApp v1.0.0");
    }
}
