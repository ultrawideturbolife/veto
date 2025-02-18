# 🚀 How We Run Our App Locally

## 📱 Running the App

### 1. Start Firebase Emulators
From the Flutter project directory, run:
```bash
./scripts/run_emulators.sh
```
This will start the Firebase emulators and import any existing data from the exports folder if available.

### 2. Run the Flutter App
You must run the app with `env=emulators` to connect to the local emulators.

⚠️ Environment Behavior:
- With `--dart-define=env=emulators`: Connects to local Firebase emulators
- With `--dart-define=env=dev`: Connects to development Firebase environment
- With `--dart-define=env=prod` or no env: Connects to production Firebase environment

#### 🖥️ Terminal
```bash
flutter run --dart-define=env=emulators
```

#### 💻 VS Code
Add to your `launch.json`:
```json
{
    "configurations": [
        {
            "name": "App (Emulators)",
            "request": "launch",
            "type": "dart",
            "args": [
                "--dart-define=env=emulators"
            ]
        }
    ]
}
```

#### 🛠️ IntelliJ/Android Studio
1. Edit Run Configuration
2. Add to Additional Run Args:
```
--dart-define=env=emulators
``` 