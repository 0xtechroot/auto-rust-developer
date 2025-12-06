/// Utility functions for the application
use std::fs;
use std::io::Result;

/// Read configuration from a file
pub fn read_config(path: &str) -> Result<String> {
    fs::read_to_string(path)
}

/// Validate input string
pub fn validate_input(input: &str) -> bool {
    !input.is_empty() && input.len() < 1000
}

/// Format timestamp
pub fn format_timestamp(timestamp: u64) -> String {
    format!("Timestamp: {}", timestamp)
}

#[cfg(test)]
mod tests {
    use super::*;
    
    #[test]
    fn test_validate_input() {
        assert!(validate_input("valid input"));
        assert!(!validate_input(""));
        assert!(validate_input("a"));
    }
    
    #[test]
    fn test_format_timestamp() {
        let result = format_timestamp(1234567890);
        assert!(result.contains("1234567890"));
    }
}
