# 🔧 How We Configure Firebase Emulators

## 📝 Introduction
This guide explains how to configure Firebase emulators for local development in a mono repo structure. The emulators allow us to develop and test Firebase functionality without connecting to production services.

## 🎯 Suggested Approach
- [ ] Set up Firebase project structure
- [ ] Configure Firebase emulator ports
- [ ] Create emulator scripts
- [ ] Configure Flutter environment setup
- [ ] Set up emulator configuration class
- [ ] Test emulator configuration

## 👨‍🏫 Tutorial

### 1. Set up Firebase project structure
Create the following structure in your mono repo:
```
project_mono/
  ├── project_firebase/        # Firebase project
  │   ├── firebase.json            # Firebase configuration
  │   ├── firestore.rules          # Firestore security rules
  │   ├── storage.rules            # Storage security rules
  │   ├── functions/               # Cloud Functions
  │   └── scripts/                 # Emulator scripts
  │       ├── run_emulators.sh
  │       └── export_emulators_firebase_data.sh
  │
  └── project_flutter/        # Flutter project
      ├── lib/
      │   └── core/
      │       ├── config/
      │       │   └── emulator_config.dart
      │       └── utils/
      │           ├── app_setup.dart
      │           └── environment.dart
      └── scripts/
          └── run_emulators.sh
```

### 2. Configure Firebase emulator ports
In `project_firebase/firebase.json`, configure the emulator ports:
```json
{
  "functions": [
    {
      "source": "functions",
      "codebase": "default",
      "ignore": [
        "node_modules",
        ".git",
        "firebase-debug.log",
        "firebase-debug.*.log"
      ],
      "predeploy": [
        "npm --prefix \"$RESOURCE_DIR\" run lint",
        "npm --prefix \"$RESOURCE_DIR\" run build"
      ]
    }
  ],
  "firestore": {
    "rules": "firestore.rules"
  },
  "storage": {
    "rules": "storage.rules"
  },
  "emulators": {
    "auth": {
      "port": 9099
    },
    "functions": {
      "port": 5001
    },
    "firestore": {
      "port": 8080
    },
    "storage": {
      "port": 9199
    },
    "ui": {
      "enabled": true,
      "port": 4000
    }
  }
}
```

### 3. Create emulator scripts
1. In the Firebase project, create `project_firebase/scripts/run_emulators.sh`:
```bash
#!/bin/bash

# Kill any running firebase emulators
echo "Killing any running firebase emulators..."
lsof -t -i:9099 -i:5001 -i:8080 -i:9199 -i:4000 | while read -r pid; do
    if ps -p $pid -o command | grep -q "firebase"; then
        kill -9 $pid 2>/dev/null || true
    fi
done

# Navigate to functions directory and do a clean build
cd ../functions || exit
rm -rf lib/
npm run build

cd ../ || exit

if [ -d "exports/firestore_export" ] || [ -f "exports/auth_export.json" ]; then
    echo "Starting emulators with data import..."
    firebase emulators:start --import=exports
else
    echo "No exports found, starting clean emulators..."
    firebase emulators:start
fi
```

2. In the Firebase project, create `project_firebase/scripts/export_emulators_firebase_data.sh`:
```bash
#!/bin/bash

cd ../ || exit

echo "Exporting emulator data..."
firebase emulators:export exports
```

3. In the Flutter project, create `project_flutter/scripts/run_emulators.sh`:
```bash
#!/bin/bash

# Navigate to firebase scripts directory and run emulators
cd ../../project_firebase/scripts && ./run_emulators.sh
```

Make the scripts executable:
```bash
chmod +x scripts/run_emulators.sh
cd ../../project_firebase/scripts
chmod +x run_emulators.sh
chmod +x export_emulators_firebase_data.sh
```

### 4. Configure Flutter environment setup
Create `project_flutter/lib/core/utils/environment.dart`:
```dart
abstract class Environment {
  static String? currentVersion;

  static const String _emulators = 'emulators';
  static const String _dev = 'dev';
  static const String _prod = 'prod';

  static const argumentKey = 'env';

  static EnvironmentType get current {
    switch (const String.fromEnvironment(
      Environment.argumentKey,
      defaultValue: _prod,
    )) {
      case _emulators:
        return EnvironmentType.emulators;
      case _dev:
        return EnvironmentType.dev;
      case _prod:
      default:
        return EnvironmentType.prod;
    }
  }

  static bool get isEmulators => current == EnvironmentType.emulators;
  static bool get isDev => current == EnvironmentType.dev;
  static bool get isProd => current == EnvironmentType.prod;
}

enum EnvironmentType {
  emulators,
  dev,
  prod;
}
```

### 5. Set up emulator configuration class
Create `project_flutter/lib/core/config/emulator_config.dart`:
```dart
class EmulatorConfig {
  static const _localhost = 'localhost';
  static const _host = '127.0.0.1';

  static const _portAuth = 9099;
  static const _portFirestore = 8080;
  static const _portFunctions = 5001;
  static const _portStorage = 9199;

  static void configureEmulators() {
    if (kDebugMode && Environment.isEmulators) {
      final host = kIsWeb ? _localhost : _host;
      log.debug('Configuring Firebase emulators on $host');

      FirebaseAuth.instance.useAuthEmulator(host, _portAuth);
      FirebaseFirestore.instance.useFirestoreEmulator(host, _portFirestore);
      FirebaseFunctions.instance.useFunctionsEmulator(host, _portFunctions);
      FirebaseStorage.instance.useStorageEmulator(host, _portStorage);

      log.debug('Firebase emulators configured successfully');
    }
  }
}
```

In `project_flutter/lib/core/utils/app_setup.dart`, initialize Firebase with emulators:
```dart
static Future<void> initialise() async {
  log.debug('Initializing Firebase with environment: ${Environment.current}');

  await Firebase.initializeApp(
    options: Environment.current.firebaseOptions,
  );

  EmulatorConfig.configureEmulators();

  log.debug('Firebase initialization complete');
}
```

### 6. Test emulator configuration
1. Start the emulators:
```bash
cd project_mono/project_flutter/scripts
./run_emulators.sh
```

2. Run the Flutter app with emulators environment:
```bash
flutter run --dart-define=env=emulators
```

3. Verify in the logs:
   - "Configuring Firebase emulators" message appears
   - App connects to emulators instead of production
   - Emulator UI is accessible at `localhost:4000`
   - Test operations work in the emulator environment

## ✅ Checklist
- [ ] Firebase project structure is correctly set up
- [ ] Emulator ports are configured in `firebase.json`
- [ ] Emulator scripts are created and executable
- [ ] Environment class is implemented with all necessary types
- [ ] EmulatorConfig class is implemented with proper port constants
- [ ] Firebase initialization includes emulator configuration
- [ ] All necessary Firebase services are configured for emulators
- [ ] Proper logging is implemented for debugging
- [ ] Web and native platforms are properly handled
- [ ] Port conflicts are handled in the startup script