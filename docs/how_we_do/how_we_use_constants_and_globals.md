# How We Use Constants and Globals

This guide explains how we organize and use constants and globals. It's meant to help maintain consistency and make it easier for developers to find and use the right constants.

## Constants (`k_` prefix)

All constant files are prefixed with `k_` and live in the `constants` folders. We have two main locations:
- `/lib/core/constants/` for app-wide constants
- `/features/*/constants/` for feature-specific constants

### Key Constants (`k_keys.dart`)

`k_keys.dart` contains string keys used for:
- JSON serialization
- Map keys
- Database field names
- Route parameters

Example usage:
```dart
// Bad
map['parentId'] = value;

// Good
map[kKeysParentId] = value;
```

This ensures consistency across the app and makes refactoring easier.

### Value Constants (`k_values.dart`)

`k_values.dart` contains default values and commonly used values like:
- Default durations
- Currency symbols
- Special characters
- URLs
- Business logic defaults

Example usage:
```dart
// Bad
final defaultDuration = 60;

// Good
final defaultDuration = kValuesDefaultDurationInMinutes;
```

### Asset Constants
- `k_svgs.dart`: SVG asset paths (e.g., `kSvgLogo`)
- `k_pngs.dart`: PNG asset paths
- `k_lottie.dart`: Lottie animation paths (e.g., `kLottieSuccess`)
- `k_mds.dart`: Markdown file paths (e.g., `kMdChangelog`)

### UI Constants
- `k_sizes.dart`: UI-related sizes and dimensions
- `k_colors.dart`: Color constants
- `k_durations.dart`: Animation and timing durations

### Platform Constants
- `k_platform.dart`: Platform-specific constants
- `k_rate_limits.dart`: API rate limiting constants

## Globals (`g_` prefix)

Globals are prefixed with `g_` and provide app-wide accessible functionality. They're different from constants as they can be mutable and often provide functionality rather than just values.

### Core Globals

#### `g_strings.dart`
Provides access to localized strings:
```dart
// Bad
Text('Hello');

// Good
Text(gStrings.hello);
```

#### `g_print.dart`
Centralized logging functionality:
```dart
// Bad
print('Debug info');

// Good
log.debug('Debug info');
```

#### `g_feedback.dart`
User feedback utilities:
```dart
// Bad
ScaffoldMessenger.of(context).showSnackBar(...);

// Good
gFeedback.showSnackBar(...);
```

#### Other Core Globals
- `g_getters.dart`: Common getter functions
- `g_input.dart`: Input handling utilities
- `g_busy.dart`: Loading state management
- `g_date_times.dart`: Date/time utilities
- `g_router.dart`: Navigation utilities

### Feature-Specific Globals

Features can have their own globals for feature-specific functionality. For example:

#### `features/settings/globals/g_settings.dart`
```dart
// Access time and date format settings
TimeFormat get gTimeFormat => SettingsService.locate.timeFormat;
DateFormat get gDateFormat => SettingsService.locate.dateFormat;
```

## Best Practices

1. **Naming Convention**
   - Constants: `kCategory[Subject]` (e.g., `kKeysUserId`)
   - Globals: `gCategory[Subject]` (e.g., `gStrings`)

2. **When to Create New Constants**
   - Create a constant when a value is used in multiple places
   - Create a constant for configuration values that might change
   - Create a constant for magic numbers/strings

3. **Where to Put Constants**
   - App-wide constants go in `/lib/core/constants/`
   - Feature-specific constants go in the feature's constants folder
   - If a constant is used across multiple features move it to core

4. **When to Create Globals**
   - For functionality that needs to be accessed throughout the app
   - For managing app-wide state or utilities
   - For abstracting complex operations that are used in multiple places

## File Organization

```
lib/
├── core/
│   ├── constants/
│   │   ├── k_keys.dart      # Map/JSON keys
│   │   ├── k_values.dart    # Default values
│   │   ├── k_sizes.dart     # UI sizes
│   │   ├── k_colors.dart    # Colors
│   │   ├── k_svgs.dart      # SVG assets
│   │   └── k_lottie.dart    # Lottie animations
│   └── globals/
│       ├── g_strings.dart   # Localization
│       ├── g_print.dart     # Logging
│       └── g_feedback.dart  # User feedback
└── features/
    └── feature_name/
        ├── constants/
        │   └── k_feature_specific.dart
        └── globals/
            └── g_feature_specific.dart
```

## Tips

1. Always search existing constant files before creating new constants
2. Keep constants organized by category (keys, values, sizes, etc.)
3. Use descriptive names that indicate the purpose
4. Document any non-obvious constants
5. Keep feature-specific constants in their feature folder until they need to be shared
6. When creating a new feature, follow the established pattern (use the `create_feature.sh` script)

Remember: The goal is to make the codebase more maintainable and reduce errors from typos or inconsistent values. When in doubt create a constant rather than using magic values. 