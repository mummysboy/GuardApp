# 🚀 Quick Start - GuardApp Local Development

## 🎯 Right Now - Start Your App

### Step 1: Open Xcode
```bash
open GuardApp.xcodeproj
```

### Step 2: Run the App
- In Xcode, select **iPhone 16 Pro** simulator
- Press **Cmd + R** to build and run
- Your app will launch in the iOS Simulator

### Step 3: Monitor in Terminal
```bash
./monitor_app.sh logs
```

**That's it!** You now have your app running locally with full terminal access for monitoring and debugging.

---

## 🛠️ Available Commands

### Monitor Your App
```bash
# Show app status
./monitor_app.sh status

# Monitor logs in real-time
./monitor_app.sh logs

# Start simulator
./monitor_app.sh start
```

### Development Workflow
```bash
# Complete workflow (build + run + monitor)
./dev_workflow.sh full

# Just build the app
./dev_workflow.sh build

# Just run the app
./dev_workflow.sh run

# Just monitor logs
./dev_workflow.sh monitor
```

---

## 📊 What You Can Monitor

- **Console logs** from your Swift code
- **Amplify operations** (auth, API calls, DataStore)
- **Network requests** and responses
- **Error messages** and debugging info
- **Performance metrics**

---

## 🔧 Troubleshooting

### If the app won't build:
```bash
# Clean the project
xcodebuild clean -project GuardApp.xcodeproj -scheme GuardApp
```

### If simulator won't start:
```bash
# Kill and restart simulator
killall Simulator
./monitor_app.sh start
```

### If logs aren't showing:
```bash
# Check if app is running
./monitor_app.sh status

# Restart monitoring
./monitor_app.sh logs
```

---

## 🎉 You're All Set!

Your development environment is now configured for:
- ✅ **Local iOS app deployment**
- ✅ **Real-time terminal monitoring**
- ✅ **Full debugging capabilities**
- ✅ **Amplify integration tracking**

**Next steps**: Open Xcode, run your app, and start monitoring in the terminal!

Happy coding! 🚀
