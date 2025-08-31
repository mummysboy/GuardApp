#!/bin/bash

# GuardApp Monitoring Script
# This script helps monitor your iOS app while it's running

echo "🚀 GuardApp Monitoring Script"
echo "=============================="

# Get the device ID for iPhone 16 Pro
DEVICE_ID="D8E53101-2D8E-4070-B8D9-32FADF1DB677"
APP_BUNDLE="com.mummysboy.GuardApp.debug"

echo "📱 Monitoring device: iPhone 16 Pro ($DEVICE_ID)"
echo "📦 App bundle: $APP_BUNDLE"
echo ""

# Function to check if simulator is running
check_simulator() {
    if xcrun simctl list devices | grep -q "$DEVICE_ID.*Booted"; then
        return 0
    else
        return 1
    fi
}

# Function to start simulator if not running
start_simulator() {
    if ! check_simulator; then
        echo "🔧 Starting iOS Simulator..."
        xcrun simctl boot $DEVICE_ID
        open -a Simulator
        sleep 3
    fi
}

# Function to monitor app logs
monitor_logs() {
    echo "📊 Starting log monitoring..."
    echo "Press Ctrl+C to stop monitoring"
    echo ""
    
    xcrun simctl spawn $DEVICE_ID log stream --predicate 'process == "GuardApp" OR process == "com.mummysboy.GuardApp.debug"' --style compact
}

# Function to show app status
show_status() {
    echo "📋 App Status:"
    echo "=============="
    
    if xcrun simctl listapps $DEVICE_ID | grep -q "$APP_BUNDLE"; then
        echo "✅ App is installed"
    else
        echo "❌ App is not installed"
    fi
    
    if xcrun simctl listapps $DEVICE_ID | grep -q "$APP_BUNDLE.*Running"; then
        echo "🟢 App is running"
    else
        echo "🔴 App is not running"
    fi
    
    echo ""
}

# Function to show device info
show_device_info() {
    echo "📱 Device Information:"
    echo "======================"
    xcrun simctl list devices | grep "$DEVICE_ID"
    echo ""
}

# Main script logic
case "$1" in
    "start")
        start_simulator
        show_device_info
        show_status
        ;;
    "logs")
        start_simulator
        monitor_logs
        ;;
    "status")
        show_device_info
        show_status
        ;;
    "install")
        echo "📦 Installing app..."
        # You'll need to build first with xcodebuild
        echo "Run: xcodebuild -project GuardApp.xcodeproj -scheme GuardApp -destination 'platform=iOS Simulator,id=$DEVICE_ID' build"
        ;;
    *)
        echo "Usage: $0 {start|logs|status|install}"
        echo ""
        echo "Commands:"
        echo "  start   - Start simulator and show status"
        echo "  logs    - Monitor app logs in real-time"
        echo "  status  - Show device and app status"
        echo "  install - Install the app (requires build first)"
        echo ""
        echo "Example workflow:"
        echo "1. $0 start     # Start simulator"
        echo "2. Build app in Xcode (Cmd+R)"
        echo "3. $0 logs      # Monitor logs"
        ;;
esac
