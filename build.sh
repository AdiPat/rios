#!/bin/bash


RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

BUILD_COMMAND="./mvnw clean package"

detect_jar() {
    local jar_count=$(ls -1 target/*.jar 2>/dev/null | grep -v '.original$' | wc -l)
    
    if [ "$jar_count" -eq 0 ]; then
        print_message "$RED" "❌" "No JAR file found in target directory!"
        exit 1
    elif [ "$jar_count" -gt 1 ]; then
        print_message "$YELLOW" "⚠️" "Multiple JAR files found. Using the first one..."
    fi
    
    JAR_NAME=$(ls -1 target/*.jar 2>/dev/null | grep -v '.original$' | head -1)
    JAR_NAME=$(basename "$JAR_NAME")
    print_message "$BLUE" "📦" "Detected JAR: $JAR_NAME"
}

print_message() {
    local color=$1
    local emoji=$2
    local message=$3
    echo -e "${color}${emoji} ${message}${NC}"
}

check_maven() {
    if [ ! -f "./mvnw" ]; then
        print_message "$RED" "❌" "Maven wrapper not found!"
        exit 1
    fi
}

build_app() {
    print_message "$BLUE" "🔨" "Building Spring Boot application..."
    
    if $BUILD_COMMAND; then
        print_message "$GREEN" "✅" "Build successful!"
        detect_jar
    else
        print_message "$RED" "❌" "Build failed!"
        exit 1
    fi
}

run_app() {
    if [ -f "target/$JAR_NAME" ]; then
        print_message "$BLUE" "🚀" "Starting application: $JAR_NAME"
        java -jar "target/$JAR_NAME"
    else
        print_message "$RED" "❌" "JAR file not found: $JAR_NAME"
        exit 1
    fi
}

main() {
    print_message "$YELLOW" "🚀" "______________ Welcome to RIOS build script! ______________"
    print_message "$YELLOW" "⚡️" "Author: Aditya Patange (AdiPat)"
    print_message "$YELLOW" "🔗" "GitHub: https://www.github.com/AdiPat"
    print_message "$YELLOW" "🔗" "Copyrights (c) 2025 The Hackers Playbook"
    print_message "$YELLOW" "🔍" "Starting build process..."
    check_maven
    build_app
    
    if [ "$1" == "--run" ]; then
        run_app
    else
        print_message "$GREEN" "📦" "Build completed! Use --run to start the application"
    fi
}

trap 'print_message "$RED" "⚠️" "Script interrupted!"; exit 1' SIGINT

main "$@"
