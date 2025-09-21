# Server Configuration Guide

The Experience Marketplace app can connect to different server environments. By default, it connects to the **online production server**.

## 🌐 Default Behavior

**The app now uses the online server by default:**
```
https://serverpod-poc-1013500213689.us-central1.run.app/
```

## 🔧 Configuration Options

### 0. Mock Data Mode (Offline Demo)
Run fully offline with local mocked data and no server calls:
```bash
flutter run --dart-define=USE_MOCK_DATA=true
```
Shows a demo of categories, experiences, and user flows without any backend.

### 1. **Default (Online Server)**
Simply run the app normally - it will connect to the online server:
```bash
flutter run
```

### 2. **Use Localhost (Development)**
To connect to a local development server:
```bash
flutter run --dart-define=USE_LOCALHOST=true
```

### 3. **Custom Server URL**
To connect to a specific server:
```bash
flutter run --dart-define=SERVER_URL=https://your-custom-server.com/
```

### 4. **Environment Variables**
You can also set environment variables:
```bash
export USE_LOCALHOST=true
flutter run
```
or
```bash
export SERVER_URL=https://your-custom-server.com/
flutter run
```

## 📱 Build Configurations

### Debug Build (Default Online)
```bash
flutter build apk --debug
```

### Debug Build with Localhost
```bash
flutter build apk --debug --dart-define=USE_LOCALHOST=true
```

### Release Build for Production
```bash
flutter build apk --release
```

### Release Build with Custom Server
```bash
flutter build apk --release --dart-define=SERVER_URL=https://your-production-server.com/
```

## 🔍 Configuration Priority

The app determines which server to use in this order:

0. **Mock Data Mode** (if USE_MOCK_DATA=true)
1. **Custom SERVER_URL** (if provided via --dart-define or environment variable)
2. **Localhost** (if USE_LOCALHOST=true)  
3. **Online Server** (default)

## 🐛 Debugging

When the app starts, it will log the server configuration:
```
🌐 Experience Marketplace Server Config:
   - URL: https://serverpod-poc-1013500213689.us-central1.run.app/
   - Using localhost: false
   - Mock mode: false
   - Custom URL: none
   - Environment: Production
```

## 🔄 Quick Switch Examples

**For Development:**
```bash
# Connect to local server
flutter run --dart-define=USE_LOCALHOST=true

# Connect to staging server
flutter run --dart-define=SERVER_URL=https://staging-server.com/
```

**For Production:**
```bash
# Connect to production server (default)
flutter run

# Or explicitly set production URL
flutter run --dart-define=SERVER_URL=https://serverpod-poc-1013500213689.us-central1.run.app/
```

## 📝 Notes

- The online server is now the **default** for all builds
- Localhost is only used when explicitly requested with `USE_LOCALHOST=true`
- Configuration is logged at app startup for easy debugging
- Changes take effect immediately - no need to clean or rebuild for configuration changes
