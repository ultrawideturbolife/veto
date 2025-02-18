# 🔍 Self QA Checklist

## 🔧 Methods

- [ ] Show logging with log.debug('Example') where sensible to do so for debugging / crash reporting purposes.
- [ ] Send analytics where sensible to do.
- [ ] Document methods per dart documentation best practices where sensible to do so.
- [ ] Show busy states when needed and feedback to the user when needed.
- [ ] Consider adding timeouts where needed.
- [ ] Add try catch and proper error handling where needed.
- [ ] Show user feedback in the forms of dialogs and notifications where needed.
- [ ] Add translations for Strings in user facing communication.
- [ ] Make big methods smaller where possible.
- [ ] Rename methods properly.
- [ ] Check security and privacy concerns.
- [ ] Improve performance where needed, think of 0n optimisations, using isolates and other proven methods to avoid (UI) lag.

## 🏗️ Classes
- [ ] Dispose of streams, notifiers, listeners and other states where needed.
- [ ] Implement proper file structure

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

- [ ] Double check and ensure correct usage of public / private methods, variables and classes
- [ ] Ensure proper method naming
- [ ] Sort things alphabetically where possible for quicker reference
- [ ] Remove unused variables, imports and methods
- [ ] Ensure single responsibility principles are followed as much as possible
- [ ] Abstract or centralize common code where possible

## 📝 Examples

### Logging
```dart
// Bad: No logging
Future<void> updateItem(ItemDto item) async {
  await _api.updateItem(item);
}

// Good: Proper logging
Future<void> updateItem(ItemDto item) async {
  log.debug('Updating item: ${item.id}');
  try {
    await _api.updateItem(item);
    log.debug('Item updated successfully');
  } catch (error, stackTrace) {
    log.error(
      'Error updating item',
      error: error,
      stackTrace: stackTrace,
    );
    rethrow;
  }
}
```

### User Feedback
```dart
// Bad: No feedback
Future<void> deleteItem(String id) async {
  await _api.deleteItem(id);
}

// Good: Proper feedback
Future<void> deleteItem(String id) async {
  if (gIsBusy) return;

  try {
    gSetBusy();
    final response = await _api.deleteItem(id);
    response.fold(
      ifSuccess: (_) => gShowNotification(title: gStrings.itemDeleted),
      orElse: (response) => gShowResponse(response: response),
    );
  } catch (error, stackTrace) {
    log.error(
      'Error deleting item',
      error: error,
      stackTrace: stackTrace,
    );
  } finally {
    gSetIdle();
  }
}
```

### State Management
```dart
// Bad: No cleanup
class BadViewModel extends BaseViewModel {
  final _subscription = StreamController<List<ItemDto>>();
  final _items = ValueNotifier<List<ItemDto>>([]);
}

// Good: Proper cleanup
class GoodViewModel extends BaseViewModel {
  final _subscription = StreamController<List<ItemDto>>();
  final _items = ValueNotifier<List<ItemDto>>([]);

  @override
  Future<void> dispose() async {
    await _subscription.close();
    _items.dispose();
    super.dispose();
  }
}
```

### Method Size
```dart
// Bad: Large method
Future<void> processItem(ItemDto item) async {
  // 50+ lines of code doing multiple things
}

// Good: Split into smaller methods
Future<void> processItem(ItemDto item) async {
  await validateItem(item);
  await updateItemData(item);
  await notifyItemProcessed(item);
}

Future<void> validateItem(ItemDto item) async {
  // Validation logic
}

Future<void> updateItemData(ItemDto item) async {
  // Update logic
}

Future<void> notifyItemProcessed(ItemDto item) async {
  // Notification logic
}
```

### Error Handling
```dart
// Bad: No error handling
Future<void> fetchData() async {
  final data = await _api.getData();
  _items.value = data;
}

// Good: Proper error handling with timeouts
Future<void> fetchData() async {
  try {
    final data = await _api.getData().timeout(
      const Duration(seconds: 10),
      onTimeout: () => throw TimeoutException('Fetch data timeout'),
    );
    _items.value = data;
  } on TimeoutException catch (error) {
    log.error('Fetch data timeout', error: error);
    gShowDialog(
      title: gStrings.error,
      message: gStrings.connectionTimeout,
    );
  } catch (error, stackTrace) {
    log.error(
      'Error fetching data',
      error: error,
      stackTrace: stackTrace,
    );
    gShowDialog(
      title: gStrings.error,
      message: gStrings.generalError,
    );
  }
}
```

## 🎯 Final Checklist

### Code Quality
- [ ] All methods are properly documented
- [ ] No magic numbers/strings
- [ ] Consistent naming conventions
- [ ] No commented-out code

### Error Handling
- [ ] All error sensitive operations have try/catch
- [ ] All user actions have proper feedback
- [ ] All errors are properly logged
- [ ] Timeouts are implemented where needed

### State Management
- [ ] All disposables are properly cleaned up
- [ ] No memory leaks from subscriptions
- [ ] UI updates are efficient

### Performance
- [ ] No unnecessary rebuilds
- [ ] Heavy operations are off the main thread
- [ ] Resources are properly cached

### Security
- [ ] No sensitive data in logs
- [ ] All user input is validated
- [ ] Proper access control
- [ ] No hardcoded credentials