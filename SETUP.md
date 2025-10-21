# 🚀 Setup Guide

Complete guide to setting up the Como Ecommerce UI Kit for development.

## Table of Contents
- [System Requirements](#system-requirements)
- [Installation](#installation)
- [Running the App](#running-the-app)
- [IDE Setup](#ide-setup)
- [Troubleshooting](#troubleshooting)

---

## System Requirements

### Required
- **Flutter SDK**: 3.9.0 or higher
- **Dart SDK**: 3.0.0 or higher (comes with Flutter)
- **iOS Development** (Mac only):
  - Xcode 14.0 or higher
  - CocoaPods 1.11.0 or higher
- **Android Development**:
  - Android Studio or Android SDK
  - Android SDK 21 or higher
  - Java Development Kit (JDK) 11 or higher

### Recommended
- **RAM**: 8GB minimum, 16GB recommended
- **Storage**: 10GB free space
- **IDE**: VS Code or Android Studio

---

## Installation

### 1. Install Flutter

#### macOS
```bash
# Using Homebrew
brew install flutter

# Or download from official website
# https://docs.flutter.dev/get-started/install/macos
```

#### Windows
Download Flutter SDK from: https://docs.flutter.dev/get-started/install/windows

#### Linux
```bash
# Download Flutter
git clone https://github.com/flutter/flutter.git -b stable

# Add to PATH
export PATH="$PATH:`pwd`/flutter/bin"
```

### 2. Verify Flutter Installation

```bash
flutter doctor
```

Fix any issues reported by `flutter doctor` before proceeding.

### 3. Clone the Repository

```bash
git clone https://github.com/theflutterlover/como.git
cd como
```

### 4. Install Dependencies

```bash
flutter pub get
```

### 5. iOS Setup (Mac only)

```bash
cd ios
pod install
cd ..
```

---

## Running the App

### Run on Connected Device
```bash
flutter run
```

### Run on Specific Device
```bash
# List available devices
flutter devices

# Run on specific device
flutter run -d <device-id>
```

### Run in Debug Mode
```bash
flutter run --debug
```

### Run in Release Mode
```bash
flutter run --release
```

### Run on iOS Simulator
```bash
open -a Simulator
flutter run
```

### Run on Android Emulator
```bash
# Start emulator from Android Studio or
flutter emulators --launch <emulator-id>
flutter run
```

---

## IDE Setup

### Visual Studio Code

1. **Install Extensions**:
   - Flutter
   - Dart
   - Flutter Widget Snippets (optional)
   - Error Lens (optional)

2. **Open Project**:
   ```bash
   code .
   ```

3. **Configure Launch**:
   Create `.vscode/launch.json`:
   ```json
   {
     "version": "0.2.0",
     "configurations": [
       {
         "name": "Flutter",
         "request": "launch",
         "type": "dart"
       }
     ]
   }
   ```

### Android Studio

1. **Install Plugins**:
   - Flutter
   - Dart

2. **Open Project**:
   - File → Open → Select project folder

3. **Configure SDK**:
   - File → Settings → Languages & Frameworks → Flutter
   - Set Flutter SDK path

---

## Project Configuration

### App Name
Edit in `pubspec.yaml`:
```yaml
name: como
```

### App Icon
Replace icons in:
- `ios/Runner/Assets.xcassets/AppIcon.appiconset/`
- `android/app/src/main/res/mipmap-*/`

### Package Name

**Android**: Edit `android/app/build.gradle`:
```gradle
applicationId "com.example.como"
```

**iOS**: Open `ios/Runner.xcworkspace` in Xcode and change Bundle Identifier.

---

## Useful Commands

### Clean Build
```bash
flutter clean
flutter pub get
```

### Format Code
```bash
flutter format .
```

### Analyze Code
```bash
flutter analyze
```

### Run Tests
```bash
flutter test
```

### Build APK (Android)
```bash
flutter build apk --release
```

### Build IPA (iOS)
```bash
flutter build ios --release
```

### Check Outdated Packages
```bash
flutter pub outdated
```

### Update Packages
```bash
flutter pub upgrade
```

---

## Troubleshooting

### Common Issues

#### 1. CocoaPods Issues (iOS)
```bash
cd ios
rm -rf Pods Podfile.lock
pod install --repo-update
cd ..
```

#### 2. Gradle Issues (Android)
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
```

#### 3. Flutter Doctor Issues
```bash
flutter doctor -v
# Follow the instructions for each issue
```

#### 4. Package Conflicts
```bash
flutter pub upgrade --major-versions
```

#### 5. Build Failures
```bash
flutter clean
rm -rf .dart_tool/
flutter pub get
flutter run
```

### Getting Help

- **Flutter Documentation**: https://docs.flutter.dev
- **Stack Overflow**: Tag your question with `flutter`
- **Flutter Community**: https://flutter.dev/community
- **Project Issues**: https://github.com/theflutterlover/como/issues

---

## Development Tips

1. **Hot Reload**: Press `r` in terminal while app is running
2. **Hot Restart**: Press `R` in terminal
3. **Quit App**: Press `q` in terminal
4. **Enable Performance Overlay**: Press `P` in terminal
5. **Debug Paint**: Press `p` in terminal

---

## Next Steps

1. Read the [README.md](README.md) for project overview
2. Check [CONTRIBUTING.md](CONTRIBUTING.md) for contribution guidelines
3. Review the codebase structure
4. Start building your ecommerce app!

---

## Support

If you encounter any issues during setup, please:
1. Check the [Troubleshooting](#troubleshooting) section
2. Search existing [GitHub Issues](https://github.com/theflutterlover/como/issues)
3. Create a new issue if needed

Happy coding! 🎉

