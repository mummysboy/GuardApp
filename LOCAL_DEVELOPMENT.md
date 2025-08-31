# 🚀 GuardApp Local Development Guide

This guide shows you how to run your iOS app locally while maintaining terminal access for debugging and monitoring.

## 📋 Prerequisites

- Xcode 15+ installed
- iOS Simulator available
- Terminal access

## 🎯 Quick Start

### Option 1: Xcode + Terminal Monitoring (Recommended)

1. **Open Xcode**:
   ```bash
   open GuardApp.xcodeproj
   ```

2. **Run the app**:
   - Select iPhone 16 Pro simulator
   - Press `Cmd + R` to build and run
   - The app will launch in iOS Simulator

3. **Monitor logs in terminal**:
   ```bash
   ./monitor_app.sh logs
   ```

### Option 2: Automated Workflow

Run the complete development workflow:
```bash
./dev_workflow.sh full
```

This will:
- Start the simulator
- Clean and build the app
- Install and run the app
- Start log monitoring

## 🛠️ Available Scripts

### `monitor_app.sh` - App Monitoring

```bash
# Show device and app status
./monitor_app.sh status

# Start simulator
./monitor_app.sh start

# Monitor app logs in real-time
./monitor_app.sh logs

# Show installation instructions
./monitor_app.sh install
```

### `dev_workflow.sh` - Development Workflow

```bash
# Clean and build the app
./dev_workflow.sh build

# Install and run the app
./dev_workflow.sh run

# Monitor app logs
./dev_workflow.sh monitor

# Complete workflow (build + run + monitor)
./dev_workflow.sh full

# Show help
./dev_workflow.sh help
```

## 📊 Monitoring Your App

### Real-time Log Monitoring

Monitor your app's console output:
```bash
# Monitor all GuardApp logs
xcrun simctl spawn D8E53101-2D8E-4070-B8D9-32FADF1DB677 log stream --predicate 'process == "GuardApp"' --style compact

# Monitor with more detail
xcrun simctl spawn D8E53101-2D8E-4070-B8D9-32FADF1DB677 log stream --predicate 'process == "GuardApp"' --style syslog
```

### Amplify Debugging

Since your app uses AWS Amplify, you can monitor:
- Authentication events
- API calls
- DataStore operations
- Network requests

### Performance Monitoring

Monitor app performance:
```bash
# Monitor memory usage
xcrun simctl spawn D8E53101-2D8E-4070-B8D9-32FADF1DB677 log stream --predicate 'eventMessage CONTAINS "memory"' --style compact

# Monitor network activity
xcrun simctl spawn D8E53101-2D8E-4070-B8D9-32FADF1DB677 log stream --predicate 'eventMessage CONTAINS "network"' --style compact
```

## 🔧 Troubleshooting

### Build Issues

If you encounter build errors:

1. **Clean the project**:
   ```bash
   xcodebuild clean -project GuardApp.xcodeproj -scheme GuardApp
   ```

2. **Reset simulator**:
   ```bash
   xcrun simctl erase D8E53101-2D8E-4070-B8D9-32FADF1DB677
   ```

3. **Check Amplify configuration**:
   - Ensure `amplifyconfiguration.json` is up to date
   - Verify AWS credentials are configured

### Simulator Issues

If simulator won't start:
```bash
# Kill all simulator processes
killall Simulator

# Start fresh
xcrun simctl boot D8E53101-2D8E-4070-B8D9-32FADF1DB677
open -a Simulator
```

### Log Monitoring Issues

If logs aren't showing:
```bash
# Check if app is running
xcrun simctl listapps D8E53101-2D8E-4070-B8D9-32FADF1DB677 | grep GuardApp

# Restart log monitoring
./monitor_app.sh logs
```

## 📱 Device Configuration

### Available Simulators

- **iPhone 16 Pro** (Recommended): `D8E53101-2D8E-4070-B8D9-32FADF1DB677`
- iPhone 16 Pro Max: `7E55E2B3-F1A0-44D9-B7F2-13991CC2193F`
- iPhone 16: `B6A52771-FC19-4B7A-8A73-C82A4219E58E`
- iPhone 16 Plus: `B7F8019D-F5C5-477C-81B2-7A910BB05752`
- iPhone SE: `45C6B863-D4DA-41AB-BEAE-EEABFA436B0C`

### Change Target Device

To use a different simulator, update the `DEVICE_ID` in both scripts:
```bash
# Edit monitor_app.sh and dev_workflow.sh
# Change DEVICE_ID to your preferred simulator
```

## 🎯 Development Workflow

### Daily Development

1. **Start your day**:
   ```bash
   ./monitor_app.sh start
   ```

2. **Open Xcode and run app**:
   - Press `Cmd + R` in Xcode

3. **Monitor in terminal**:
   ```bash
   ./monitor_app.sh logs
   ```

4. **Make changes and rebuild**:
   - Edit code in Xcode
   - Press `Cmd + R` to rebuild
   - Watch logs in terminal

### Debugging Session

1. **Set breakpoints** in Xcode
2. **Run in debug mode** (`Cmd + R`)
3. **Monitor logs** in terminal:
   ```bash
   ./monitor_app.sh logs
   ```
4. **Step through code** in Xcode
5. **Watch console output** in terminal

## 🔍 Advanced Monitoring

### Custom Log Filters

Monitor specific events:
```bash
# Monitor only authentication events
xcrun simctl spawn D8E53101-2D8E-4070-B8D9-32FADF1DB677 log stream --predicate 'eventMessage CONTAINS "auth"' --style compact

# Monitor only API calls
xcrun simctl spawn D8E53101-2D8E-4070-B8D9-32FADF1DB677 log stream --predicate 'eventMessage CONTAINS "API"' --style compact

# Monitor errors only
xcrun simctl spawn D8E53101-2D8E-4070-B8D9-32FADF1DB677 log stream --predicate 'eventMessage CONTAINS "error"' --style compact
```

### Multiple Terminal Windows

For comprehensive monitoring, use multiple terminal windows:

**Terminal 1 - General logs**:
```bash
./monitor_app.sh logs
```

**Terminal 2 - Errors only**:
```bash
xcrun simctl spawn D8E53101-2D8E-4070-B8D9-32FADF1DB677 log stream --predicate 'eventMessage CONTAINS "error"' --style compact
```

**Terminal 3 - Network activity**:
```bash
xcrun simctl spawn D8E53101-2D8E-4070-B8D9-32FADF1DB677 log stream --predicate 'eventMessage CONTAINS "network"' --style compact
```

## 🎉 Success!

You now have a complete local development setup that allows you to:
- ✅ Run your iOS app locally
- ✅ Monitor console output in real-time
- ✅ Debug with full terminal access
- ✅ Track Amplify operations
- ✅ Monitor performance and errors

Happy coding! 🚀
