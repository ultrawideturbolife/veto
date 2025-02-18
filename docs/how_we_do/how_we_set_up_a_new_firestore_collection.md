# 🔥 How We Set Up A New Firestore Collection

## 📝 Introduction
We use a structured approach to communicate with Firestore through a layered architecture (API, Service) as demonstrated in this generic example.

## 🎯 Why This Approach?
- Type-safe data handling through DTOs (e.g., `ItemDto`)
- Clear separation between data access (`ItemsApi`) and business logic (`ItemsService`)
- Consistent dependency injection using GetIt
- Proper sub-collection handling within parent collections

## 🔄 Exact Process In Steps

### 1. Create Collection and DTOs
Example from `item_dto.dart` and `firestore_collection.dart`:
```dart
// First add to FirestoreCollection enum
enum FirestoreCollection {
  users,
  items, // New collection
  ;
}

// Then create the DTO
@JsonSerializable(includeIfNull: true, explicitToJson: true)
class ItemDto extends WriteableId<String> {
  ItemDto({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.name,
    this.parentId,
  });

  @override
  final String id;
  @TimestampConverter()
  final DateTime createdAt;
  @TimestampConverter()
  final DateTime updatedAt;
  final String createdBy;
  final String name;
  final String? parentId; // Optional, for hierarchical data
}
```

### 2. Update Security Rules
Example from `firestore.rules`:
```
match /items/{documentId} {
  allow create: if hasAuth() && 
    request.auth.uid == request.resource.data.createdBy && 
    isParentMember(request.resource.data.parentId);
  allow read: if hasAuth() && 
    isParentMember(resource.data.parentId);
  allow update: if hasAuth() && 
    isParentMember(resource.data.parentId);
  allow delete: if hasAuth() && 
    isParentMember(resource.data.parentId);
}
```

### 3. Implement Collection Service
Example from `items_service.dart`:
```dart
class ItemsService extends CollectionService<ItemDto, ItemsApi> {
  ItemsService() : super(api: ItemsApi.locate);

  @override
  Stream<List<ItemDto>> Function(User user) get stream =>
      (user) => api.findStreamWithConverter();
}
```

### 4. Add to Locator
Example from `locator.dart`:
```dart
class Locator {
  static void _registerFactories() {
    ItemsApi.registerFactory();
  }

  static void _registerLazySingletons() {
    ItemsService.registerLazySingleton();
  }
}
```

## 📌 Usage Example
Example from `item_view_model.dart`:
```dart
class ItemViewModel extends BaseViewModel {
  // Access the service through the locator
  final _itemsService = ItemsService.locate;
}
```

## 📌 Summary
Our implementation follows a strict chronological order: starting with collection and DTO setup, securing access through rules, implementing the service layer, and registering dependencies. This structured approach ensures proper data handling and access control at every level. 
