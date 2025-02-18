# 🔄 How We Update Settings

## Introduction
We use a structured approach for updating settings to ensure consistency, reliability, and proper feedback to users. This pattern is designed to handle both local state updates and remote data persistence while providing clear feedback about the success or failure of each operation.

## Why This Pattern
We chose this pattern because it:
- Maintains a single source of truth
- Provides immediate local updates for responsive UI
- Ensures data consistency with the backend
- Gives clear feedback to users
- Makes debugging easier through consistent error handling
- Allows for easy extension of settings

## 🔍 Process In Steps

### 1. View Layer
- User interacts with a settings item in `settings_view.dart`
- The view calls a method on `settings_view_model.dart`

### 2. ViewModel Layer
- ViewModel receives the update request
- Handles any UI specific logic (dialogs, pickers, etc.)
- Calls the appropriate update method on `settings_service.dart`

### 3. Service Layer
Each setting has its own update method in `settings_service.dart` that:
1. Updates local state using `updateSetting`
2. Sends update to backend via `_settingsApi.updateSettings`
3. Returns a `FeedbackResponse` with success/error message

### 4. Feedback Flow
- Service returns `FeedbackResponse` to ViewModel
- ViewModel shows feedback to user using `response.show(context: context)`
- User sees a notification about the success/failure of their action

## 📝 Example
```dart
// In settings_service.dart
Future<FeedbackResponse> updateThemeMode({required ThemeMode value}) async {
  try {
    updateSetting((settingsDto) => settingsDto..themeMode = value);
    final response = await _settingsApi.updateSettings(
      updateSettingsRequest: UpdateSettingsRequest(
        themeMode: value,
      ),
    );
    return response.copyWith(
      ifSuccessTitle: gStrings.themeModeUpdated,
      ifErrorTitle: gStrings.themeModeUpdateFailed,
    );
  } catch (error, stackTrace) {
    log.error(
      'Error updating theme mode',
      error: error,
      stackTrace: stackTrace,
    );
    return FeedbackResponse.error(
      title: gStrings.themeModeUpdateFailed,
    );
  }
}

// In settings_view_model.dart
Future<void> onThemeModeChanged(ThemeMode value) async {
  if (gIsBusy) return;

  try {
    gSetBusy();
    final response = await _settingsService.updateThemeMode(value: value);
    response.fold(
      ifSuccess: (_) => gShowNotification(title: gStrings.themeModeUpdated),
      orElse: (response) => gShowResponse(response: response),
    );
  } catch (error, stackTrace) {
    log.error(
      'Error handling theme mode change',
      error: error,
      stackTrace: stackTrace,
    );
  } finally {
    gSetIdle();
  }
}

// In settings_view.dart
ListTile(
  title: Text(gStrings.themeMode),
  subtitle: Text(model.currentThemeMode.toString()),
  onTap: () => model.onThemeModeChanged(ThemeMode.system),
),
```

## 🎯 Summary
This pattern ensures that:
1. Settings updates are consistent and reliable
2. Users get immediate feedback
3. Data stays in sync between local and remote
4. Errors are properly handled and logged
5. Code remains maintainable and extendable
6. UI remains responsive during updates
7. All strings are properly localized 