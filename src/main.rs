use std::env;
use std::process;

fn main() {
    let args: Vec<String> = env::args().collect();
    
    println!("🤖 Auto Rust Developer - Active!");
    
    if args.len() < 2 {
        println!("Usage: {} <command>", args[0]);
        println!("Commands: run, test, info");
        process::exit(0);
    }
    
    match args[1].as_str() {
        "run" => {
            println!("✅ Running application...");
            run_app();
        },
        "test" => {
            println!("🧪 Running tests...");
        },
        "info" => {
            println!("📊 Project: Auto Rust Developer");
            println!("📦 Version: 0.1.0");
        },
        _ => {
            eprintln!("❌ Unknown command: {}", args[1]);
            process::exit(1);
        }
    }
}

fn run_app() {
    println!("Application is running with automated development!");
}
