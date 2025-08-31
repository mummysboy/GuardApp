#!/bin/bash

# GuardApp Development Workflow
# This script automates the build and run process for development

echo "🛠️  GuardApp Development Workflow"
echo "=================================="

# Configuration
DEVICE_ID="D8E53101-2D8E-4070-B8D9-32FADF1DB677"
SCHEME="GuardApp"
PROJECT="GuardApp.xcodeproj"
DESTINATION="platform=iOS Simulator,id=$DEVICE_ID"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check if Xcode is running
check_xcode() {
    if pgrep -x "Xcode" > /dev/null; then
        return 0
    else
        return 1
    fi
}

# Function to start simulator
start_simulator() {
    print_status "Starting iOS Simulator..."
    xcrun simctl boot $DEVICE_ID
    open -a Simulator
    sleep 3
    print_success "Simulator started"
}

# Function to clean build
clean_build() {
    print_status "Cleaning build..."
    xcodebuild clean -project $PROJECT -scheme $SCHEME
    print_success "Build cleaned"
}

# Function to build app
build_app() {
    print_status "Building app..."
    xcodebuild -project $PROJECT -scheme $SCHEME -destination "$DESTINATION" build
    
    if [ $? -eq 0 ]; then
        print_success "Build completed successfully"
        return 0
    else
        print_error "Build failed"
        return 1
    fi
}

# Function to install and run app
install_run_app() {
    print_status "Installing and running app..."
    
    # Get the app path from build
    APP_PATH=$(find ~/Library/Developer/Xcode/DerivedData -name "GuardApp.app" -type d | head -1)
    
    if [ -z "$APP_PATH" ]; then
        print_error "Could not find built app. Make sure build was successful."
        return 1
    fi
    
    print_status "Found app at: $APP_PATH"
    
    # Install app
    xcrun simctl install $DEVICE_ID "$APP_PATH"
    
    # Launch app
    xcrun simctl launch $DEVICE_ID com.mummysboy.GuardApp.debug
    
    print_success "App installed and launched"
}

# Function to monitor logs
monitor_logs() {
    print_status "Starting log monitoring..."
    print_warning "Press Ctrl+C to stop monitoring"
    echo ""
    
    xcrun simctl spawn $DEVICE_ID log stream --predicate 'process == "GuardApp" OR process == "com.mummysboy.GuardApp.debug"' --style compact
}

# Function to show help
show_help() {
    echo "Usage: $0 {build|run|monitor|full|help}"
    echo ""
    echo "Commands:"
    echo "  build    - Clean and build the app"
    echo "  run      - Install and run the app"
    echo "  monitor  - Monitor app logs"
    echo "  full     - Complete workflow: build + run + monitor"
    echo "  help     - Show this help message"
    echo ""
    echo "Example:"
    echo "  $0 full  # Complete development workflow"
}

# Main script logic
case "$1" in
    "build")
        clean_build
        build_app
        ;;
    "run")
        start_simulator
        install_run_app
        ;;
    "monitor")
        monitor_logs
        ;;
    "full")
        print_status "Starting full development workflow..."
        start_simulator
        clean_build
        if build_app; then
            install_run_app
            echo ""
            print_status "Starting log monitoring in 3 seconds..."
            sleep 3
            monitor_logs
        else
            print_error "Build failed, stopping workflow"
            exit 1
        fi
        ;;
    "help"|*)
        show_help
        ;;
esac
