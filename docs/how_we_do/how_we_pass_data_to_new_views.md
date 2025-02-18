# How We Pass Data to New Views

This guide explains how we handle passing data between views using `ViewArguments` and the routing system.

## Core Concepts

### ViewArguments (`view_arguments.dart`)

The `ViewArguments` system is our standardized way to pass data to views. It consists of:

1. **Base Abstract Class**
```dart
abstract class ViewArguments {
  Map<String, dynamic> toMap();
}
```

2. **Main Implementation (`ViewArgumentsImpl`)**
- Central class containing all possible arguments
- Used by the router to pass data between views
- All fields are nullable to make it flexible

Example:
```dart
class ViewArgumentsImpl extends ViewArguments {
  ViewArgumentsImpl({
    this.itemId,
    this.isEditing,
    this.displayMode,
    // ... other arguments
  });

  final String? itemId;
  final bool? isEditing;
  final DisplayMode? displayMode;
}
```

3. **Feature-Specific Arguments**
Each view can have its own arguments class that extends `ViewArguments`:
```dart
class ItemDetailsViewArguments extends ViewArguments {
  ItemDetailsViewArguments({
    required this.isEditing,
    this.initialDate,
    this.displayMode = DisplayMode.defaultValue,
  });

  final bool isEditing;
  final DateTime? initialDate;
  final DisplayMode displayMode;
}
```

## Routing System (`base_router.dart`)

### 1. Route Definition

Routes are defined as static getters in `BaseRouter`:
```dart
static GoRoute get itemDetailsView => GoRoute(
  path: ItemDetailsView.path.asRootPath,
  pageBuilder: (context, state) => CustomTransitionPage(
    child: ItemDetailsView(
      arguments: ItemDetailsViewArguments(
        isEditing: state.isEditing,
        displayMode: state.displayMode,
        initialDate: state.initialDate,
      ),
    ),
  ),
);
```

### 2. State Extension

The `GoRouterState` extension provides easy access to arguments:
```dart
extension on GoRouterState {
  ViewArgumentsImpl? arguments() => extra?.asType<ViewArgumentsImpl>();
  
  // Getters with default values
  bool get isEditing => arguments()?.isEditing ?? false;
  DisplayMode get displayMode => 
    arguments()?.displayMode ?? DisplayMode.defaultValue;
  
  // Nullable getters
  DateTime? get initialDate => arguments()?.initialDate;
}
```

## How to Use

### 1. Creating a New View with Arguments

1. Create view-specific arguments class:
```dart
class MyViewArguments extends ViewArguments {
  MyViewArguments({
    required this.requiredField,
    this.optionalField,
  });

  final String requiredField;
  final String? optionalField;

  @override
  Map<String, dynamic> toMap() => {
    'requiredField': requiredField,
    'optionalField': optionalField,
  };
}
```

2. Add fields to `ViewArgumentsImpl`:
```dart
class ViewArgumentsImpl extends ViewArguments {
  ViewArgumentsImpl({
    // ... existing fields
    this.requiredField,
    this.optionalField,
  });

  final String? requiredField;
  final String? optionalField;
}
```

3. Add getters to `GoRouterState` extension:
```dart
extension on GoRouterState {
  String get requiredField => arguments()?.requiredField ?? '';
  String? get optionalField => arguments()?.optionalField;
}
```

### 2. Adding a New Route

1. Create the route in `BaseRouter`:
```dart
static GoRoute get myView => GoRoute(
  path: MyView.path.asRootPath,
  pageBuilder: (context, state) => CustomTransitionPage(
    child: MyView(
      arguments: MyViewArguments(
        requiredField: state.requiredField,
        optionalField: state.optionalField,
      ),
    ),
  ),
);
```

2. Add to router's routes list:
```dart
final coreRouter = GoRouter(
  routes: [
    // ... existing routes
    myView,
  ],
);
```

## Best Practices

1. **Argument Types**
   - Make arguments nullable in `ViewArgumentsImpl`
   - Use non-nullable types in view-specific argument classes when required
   - Provide default values in the state extension getters

2. **Route Parameters**
   - Use URL parameters for IDs and simple values
   - Use arguments for complex objects and state

3. **Default Values**
   - Define defaults in the state extension, not in `ViewArgumentsImpl`
   - Keep `ViewArgumentsImpl` fields nullable for flexibility

4. **Naming**
   - View arguments class: `[ViewName]Arguments`
   - Route getter: `get [viewName]`
   - Path constant: `static const path = '[view-name]'`

## Common Patterns

### Required vs Optional Arguments
```dart
// Required in view arguments
class SpecificViewArguments extends ViewArguments {
  SpecificViewArguments({required this.id}); // Required
  final String id;
}

// Optional in ViewArgumentsImpl
class ViewArgumentsImpl extends ViewArguments {
  ViewArgumentsImpl({this.id}); // Optional
  final String? id;
}

// Default in state extension
extension on GoRouterState {
  String get id => arguments()?.id ?? ''; // Default value
}
```

### URL Parameters vs Arguments
```dart
// URL parameter
String? get itemId => 
    pathParameters[kKeysItemId] ?? 
    uri.queryParameters[kKeysItemId] ?? 
    arguments()?.itemId;

// Pure argument
bool get isEditing => arguments()?.isEditing ?? false;
```

Remember: The goal is to make navigation and data passing type-safe, maintainable, and consistent across the app. 
