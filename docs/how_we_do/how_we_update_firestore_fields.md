# 🔄 How We Update Firestore Fields

## 🎯 Introduction
Updating Firestore fields requires careful consideration to maintain data integrity and optimize performance. Our approach ensures atomic updates while providing real-time local updates for a seamless user experience. Special attention is needed when dealing with nullable fields to ensure they can be properly set to null when needed.

## 🚀 Process In Steps

### 1️⃣ User Input Collection
User input can come from various sources like `FormFieldConfig` text fields date pickers dropdowns or any other input method that fits your needs.

### 2️⃣ Update Request Objects
Create dedicated request objects for field updates. When dealing with nullable fields, you might need separate request objects:

#### Regular Update Request
```dart
@JsonSerializable(includeIfNull: false, explicitToJson: true)
class UpdateItemDtoRequest extends Writeable {
  UpdateItemDtoRequest({
    required this.name,
  });

  final String name;
}
```

#### Nullable Fields Update Request
For fields that need to be explicitly set to null:
```dart
@JsonSerializable(includeIfNull: true, explicitToJson: true)
class UpdateCompletedAtRequest extends Writeable {
  UpdateCompletedAtRequest({
    required this.completedAt,
    required this.completedBy,
  });

  @TimestampConverter()
  final DateTime? completedAt;
  final String? completedBy;
}
```

Key points:
- Use `includeIfNull: false` for regular updates to only send fields that are actually updated
- Use `includeIfNull: true` for requests that need to explicitly set fields to null
- Field names must match the DTO (`ItemDto`) for Firestore merge to work
- Extend `Writeable` for JSON serialization support
- Use separate request objects for nullable fields to avoid conflicts with the default update behavior

### 3️⃣ Service Layer Update
Using `CollectionService` or `DocumentService` for updates:

#### Regular Update
```dart
Future<FeedbackResponse<DocumentReference>> updateItemName({
  required String itemId,
  required String name,
}) async {
  final item = findById(itemId);
  final updatedItem = item.copyWith(name: name);
  
  return updateDoc(
    doc: updatedItem,
    remoteUpdateRequestBuilder: (doc) => UpdateItemDtoRequest(
      name: name,
    ),
  );
}
```

#### Nullable Fields Update
```dart
Future<FeedbackResponse<DocumentReference>> updateCompletionStatus({
  required String itemId,
  required DateTime? completedAt,
  required String? completedBy,
}) async {
  final item = findById(itemId);
  final updatedItem = item.copyWith(
    completedAt: completedAt,
    completedBy: completedBy,
    forceNull: true, // Important for nullable fields
  );
  
  return updateDoc(
    doc: updatedItem,
    remoteUpdateRequestBuilder: (doc) => UpdateCompletedAtRequest(
      completedAt: completedAt,
      completedBy: completedBy,
    ),
  );
}
```

Benefits:
- Immediate local state update through `updateDoc`
- Optimistic UI updates while waiting for server response
- Specific field updates using `remoteUpdateRequestBuilder`
- Proper handling of nullable fields through dedicated request objects
- Automatic error handling and response management

### 4️⃣ DTO Implementation
Your DTO should support nullable fields in its `copyWith` method:

```dart
YourDto copyWith({
  String? name,
  DateTime? completedAt,
  String? completedBy,
  bool forceNull = false, // Add this parameter
}) =>
    YourDto(
      // Regular fields
      name: name ?? this.name,
      // Nullable fields
      completedAt: forceNull ? completedAt : completedAt ?? this.completedAt,
      completedBy: forceNull ? completedBy : completedBy ?? this.completedBy,
    );
```

Key points:
- Add a `forceNull` parameter to allow explicit null setting
- Use the ternary operator with `forceNull` for nullable fields
- Regular fields can use the null coalescing operator as usual

### 5️⃣ Response Handling
```dart
final response = await updateCompletionStatus(
  itemId: 'id',
  completedAt: null,
  completedBy: null,
);

if (response.isSuccess) {
  // Show success feedback
} else {
  // Show error feedback
}
``` 