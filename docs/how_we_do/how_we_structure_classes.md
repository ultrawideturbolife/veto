# 🏗️ How We Structure Classes

## 📖 Overview
We use a consistent class structure with clearly marked sections to make our code more maintainable and navigable. Each section is marked with a distinct emoji and ASCII art divider, making it easy to quickly jump to specific parts of a class.

## 🔍 Section Structure

```dart
// 📍 LOCATOR ------------------------------------------------------------------------------- \\
// For dependency injection and service location
- Static getters/methods for dependency injection
- Factory registration methods

// 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\
// For injected dependencies and services
- Final service instances
- API instances
- Other dependencies

// 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\
// For initialization and cleanup
- initState/dispose overrides
- Custom initialization methods
- Cleanup methods

// 👂 LISTENERS ----------------------------------------------------------------------------- \\
// For event listeners and subscriptions
- Stream subscriptions
- Event handlers
- Callback methods

// ⚡️ OVERRIDES ----------------------------------------------------------------------------- \\
// For method overrides from parent classes
- Required overrides
- Optional overrides
- Interface implementations

// 🎩 STATE --------------------------------------------------------------------------------- \\
// For state management
- ValueNotifiers
- StateNotifiers
- Form controllers
- Local state variables

// 🛠 UTIL ---------------------------------------------------------------------------------- \\
// For technical utilities
- Mutexes
- Debouncers
- Technical helpers

// 🧲 FETCHERS ------------------------------------------------------------------------------ \\
// For data retrieval
- Getters
- Data fetching methods

// 🏗️ HELPERS ------------------------------------------------------------------------------- \\
// For complex operations and business logic
- Business logic methods
- Complex calculations
- Data transformations
- Helper functions
- Formatters

// 🪄 MUTATORS ------------------------------------------------------------------------------ \\
// For state mutations and updates
- Methods that change state
- Update operations
- API calls
```

## 📋 Examples

### Service Class Example
```dart
class DataService extends BaseService {
  // 📍 LOCATOR
  static DataService get locate => GetIt.I.get();
  static void registerLazySingleton() => GetIt.I.registerLazySingleton(DataService.new);

  // 🧩 DEPENDENCIES
  final _parentService = ParentService.locate;
  final _api = DataApi.locate;

  // 🎬 INIT & DISPOSE
  @override
  Future<void> dispose() async {
    _items.dispose();
    await super.dispose();
  }

  // 🎩 STATE
  final _items = Informer<List<ItemDto>>([]);
  final _isProcessing = ValueNotifier<bool>(false);

  // 🧲 FETCHERS
  ValueListenable<List<ItemDto>> get items => _items;
  ValueListenable<bool> get isProcessing => _isProcessing;
  String get genId => _api.genId;

  // 🏗️ HELPERS
  List<ItemDto> _processItems(List<ItemDto> items) {
    return items..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  // 🪄 MUTATORS
  Future<FeedbackResponse<DocumentReference>> createItem({
    required String name,
    String? parentId,
  }) async {
    try {
      _isProcessing.value = true;
      
      final item = ItemDto(
        id: genId,
        name: name,
        parentId: parentId,
        createdAt: gNow,
        updatedAt: gNow,
        createdBy: currentUser.id,
      );
      
      return createDoc(doc: item);
    } finally {
      _isProcessing.value = false;
    }
  }
}
```

### ViewModel Example
```dart
class ItemViewModel extends BaseViewModel {
  // 📍 LOCATOR
  static ItemViewModel get locate => GetIt.I.get();
  static void registerFactory() => GetIt.I.registerFactory(ItemViewModel.new);

  // 🧩 DEPENDENCIES
  final _service = DataService.locate;
  final _dialogService = DialogService.locate;

  // 🎩 STATE
  late final _form = ItemForm();
  final _isSaving = ValueNotifier<bool>(false);

  // 🧲 FETCHERS
  ValueListenable<List<ItemDto>> get items => _service.items;
  ValueListenable<bool> get isSaving => _isSaving;
  bool get isValid => _form.isValid;

  // 🪄 MUTATORS
  Future<void> onSavePressed() async {
    if (gIsBusy || !isValid) return;

    try {
      gSetBusy();
      _isSaving.value = true;

      final response = await _service.createItem(
        name: _form.nameField.value!,
        parentId: currentParent?.id,
      );

      response.fold(
        ifSuccess: (_) => gShowNotification(title: gStrings.itemCreated),
        orElse: (response) => gShowResponse(response: response),
      );
    } catch (error, stackTrace) {
      log.error(
        'Error creating item',
        error: error,
        stackTrace: stackTrace,
      );
    } finally {
      _isSaving.value = false;
      gSetIdle();
    }
  }
}
```

## ✨ Benefits

1. 🎯 **Quick Navigation**
   - Visual markers make it easy to find specific sections
   - Consistent structure across all files
   - Quick jumping using search (e.g., "MUTATORS")

2. 🧭 **Clear Organization**
   - Each piece of code has its designated place
   - Reduces decision fatigue about where to put new code
   - Makes code reviews easier

3. 📚 **Maintainability**
   - Clear separation of concerns
   - Easy to find related functionality
   - Consistent across the codebase

4. 🤝 **Team Collaboration**
   - Everyone knows where to find things
   - Consistent structure makes more predictable code
   - Easier onboarding for new team members

## 💡 Pro Tip

Save the following as a snippet named `allheaders` to quickly scaffold new classes with all sections:

```dart
// 📍 LOCATOR ------------------------------------------------------------------------------- \\
// 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\
// 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\
// 👂 LISTENERS ----------------------------------------------------------------------------- \\
// ⚡️ OVERRIDES ----------------------------------------------------------------------------- \\
// 🎩 STATE --------------------------------------------------------------------------------- \\
// 🛠 UTIL ---------------------------------------------------------------------------------- \\
// 🧲 FETCHERS ------------------------------------------------------------------------------ \\
// 🏗️ HELPERS ------------------------------------------------------------------------------- \\
// 🪄 MUTATORS ------------------------------------------------------------------------------ \\
```

Type `allheaders` and use your IDE's snippet expansion to insert all section headers with proper formatting. 