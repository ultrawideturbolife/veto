# 📝 How We Set Up Firebase

## Introduction
This guide explains how to set up Firebase in our project, including both the Firebase project configuration and Flutter app integration. Firebase provides essential backend services for our Flutter applications, and proper setup is crucial for both development and production environments.

## 🤖 GPT Agent Instructions
### Initial Confirmation
Before proceeding, I will:
1. **Confirm Implementation Goals**
   - Verify the exact Firebase services needed (Firestore, Auth, Storage, etc.)
   - Confirm target platforms (iOS, Android, Web)
   - Verify development environment requirements

2. **State Key Assumptions**
   - We will use a mono repo structure with separate Firebase and Flutter projects
   - We will use Firebase CLI and FlutterFire CLI for setup
   - We want to configure Firebase emulators for local development
   - We need environment switching between production and emulators
   - We will follow the standard project structure:
     ```
     project_mono/
       ├── project_firebase/
       └── project_flutter/
     ```

3. **Request Clarification**
   - Confirm if any assumptions don't match the project needs
   - Ask about any project-specific requirements
   - Verify if any services should be excluded or added
   - Confirm if any additional configuration is needed

### Execution Guidelines
1. **Progress Tracking**
   - Create a checklist of all tasks before starting
   - Mark each step as one of: 🔄 In Progress | ✅ Completed | ❌ Failed
   - If a step fails, immediately report the error and wait for user input
   - After each major section, request user confirmation before proceeding

2. **Validation Steps**
   - After each configuration change, verify the file contents
   - For any file modifications, show the changes made
   - Confirm all required dependencies are at compatible versions
   - Test configurations in both emulator and production environments

3. **Error Handling**
   - Document any errors encountered
   - Provide the exact error message and context
   - Suggest possible solutions based on the error
   - Wait for user confirmation before applying fixes

### Execution Checklist
Firebase Setup:
[ ] Install Firebase CLI and FlutterFire CLI
[ ] Create Firebase project in console
[ ] Initialize Firebase project with CLI
[ ] Configure FlutterFire in Flutter app
[ ] Set up environment configuration

Flutter Configuration:
[ ] Add Firebase dependencies
[ ] Initialize Firebase in app
[ ] Configure development environment
[ ] Set up emulator connection

Verification:
[ ] Test Firebase connection
[ ] Verify emulator setup
[ ] Check all required services

### Important Notes
- DO NOT proceed to the next section until current section is verified
- Always show the exact commands being run
- For any file changes, show before and after states
- Request explicit user approval for any non-documented steps
- If encountering an undocumented scenario, pause and ask for guidance

## 🎯 Suggested Approach
- [ ] Install required CLIs (Firebase, FlutterFire)
- [ ] Create and initialize Firebase project
- [ ] Configure Flutter app with FlutterFire
- [ ] Set up environment configuration
- [ ] Verify setup and connections

## 👨‍🏫 Tutorial

### 1. 🛠️ Installing Prerequisites
First, we need to install the required CLIs:

```bash
# Install Firebase CLI
npm install -g firebase-tools

# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Log in to Firebase
firebase login
```

### 2. 🎯 Firebase Project Setup
1. Create a new project in the [Firebase Console](https://console.firebase.google.com)

2. Initialize Firebase in your project:
```bash
# Navigate to Firebase directory
cd your_project_firebase

# Initialize Firebase
firebase init

# Select required features:
# - Firestore
# - Authentication
# - Storage
# - Emulators
```

### 3. 📱 Flutter Configuration
1. Configure FlutterFire:
```bash
# Navigate to Flutter directory
cd your_project_flutter

# Run FlutterFire configure
flutterfire configure --project=your-firebase-project
```

2. Add environment configuration (`lib/core/config/environment.dart`):
```dart
enum Environment {
  production,
  emulators;

  static Environment get current => 
    const String.fromEnvironment('env') == 'emulators' 
      ? Environment.emulators 
      : Environment.production;
}
```

3. Initialize Firebase in your app (`lib/main.dart`):
```dart
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  if (Environment.isEmulators) {
    await connectToEmulators();
  }
  
  runApp(const MyApp());
}
```

### 4. 🧪 Testing the Setup

1. Run the app with emulators:
```bash
flutter run --dart-define=env=emulators
```

2. Verify Firebase connection in logs

## ✅ Checklist
- [ ] Firebase CLI and FlutterFire CLI are installed
- [ ] Firebase project is created and initialized
- [ ] FlutterFire is configured in Flutter app
- [ ] Environment configuration is set up
- [ ] Firebase initialization is working
- [ ] App can connect to Firebase services
- [ ] Emulator configuration is working 