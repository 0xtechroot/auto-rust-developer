//! Rust Developer Toolkit
//! 
//! A comprehensive library for building high-performance CLI applications
//! with async capabilities, robust error handling, and extensive testing.

pub mod utils;

/// Core application structure
pub struct App {
    pub name: String,
    pub version: String,
}

impl App {
    /// Create a new App instance
    pub fn new(name: String, version: String) -> Self {
        Self { name, version }
    }
    
    /// Get application information
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
