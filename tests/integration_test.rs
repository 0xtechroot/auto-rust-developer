use auto_rust_developer::{App, utils};

#[test]
fn test_app_integration() {
    let app = App::new("TestApp".to_string(), "1.0.0".to_string());
    assert_eq!(app.info(), "TestApp v1.0.0");
}

#[test]
fn test_utils_validation() {
    assert!(utils::validate_input("valid input"));
    assert!(!utils::validate_input(""));
}

#[test]
fn test_app_creation_with_empty_name() {
    let app = App::new("".to_string(), "1.0.0".to_string());
    assert_eq!(app.name, "");
}
