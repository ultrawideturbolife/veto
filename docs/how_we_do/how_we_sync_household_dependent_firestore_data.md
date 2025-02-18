# 📝 How We Sync Parent-Dependent Firestore Data

# 📝 Introduction
Parent-dependent Firestore data refers to data that is associated with a specific parent entity and should only be accessible to members of that parent group. This document explains how we handle syncing this data efficiently and securely using our custom sync services.

# 🎯 Suggested Approach
- [ ] Create a DTO that includes parentId field
- [ ] Extend BeforeParentSyncService, ParentSyncService, or AfterParentSyncService based on data processing needs
- [ ] Implement parentStream method to filter data by parentId
- [ ] Add security rules to verify parent membership
- [ ] Clean up data when parent changes

# 👨‍🏫 Tutorial

### 1. 📋 Create DTO with Parent ID
```dart
@JsonSerializable(includeIfNull: true, explicitToJson: true)
class ItemDto extends WriteableId<String> {
  ItemDto({
    required this.id,
    required this.parentId,
    // ... other fields
  });

  final String parentId;
  // ... other fields
}
```

### 2. 🔄 Choose Sync Service Base
```dart
// Use BeforeParentSyncService when you need to process data before notifying listeners
class ItemsService extends BeforeParentSyncService<ItemDto, ItemsApi> {
  // ...
}

// Use ParentSyncService when no preprocessing is needed
class SubItemsService extends ParentSyncService<SubItemDto, SubItemsApi> {
  // ...
}

// Use AfterParentSyncService when you need to process data after notifying listeners
class InvitesService extends AfterParentSyncService<InviteDto, InvitesApi> {
  // ...
}
```

### 3. 🌊 Implement Parent Stream
```dart
@override
FutureOr<Stream<List<ItemDto?>>> parentStream(User user, String? parentId) {
  if (parentId == null) return Stream.value(null);
  return api.findStreamByQueryWithConverter(
    whereDescription: 'parentId is $parentId',
    collectionReferenceQuery: (collectionReference) => 
      collectionReference.where(kKeysParentId, isEqualTo: parentId),
  );
}
```

### 4. 🔒 Add Security Rules
```
match /items/{documentId} {
  allow create: if hasAuth() && 
    request.auth.uid == request.resource.data.createdBy && 
    isParentMember(request.resource.data.parentId);
  allow read, update, delete: if hasAuth() && 
    isParentMember(resource.data.parentId);
}
```

### 5. 📦 Handle Parent Changes
The base service automatically handles:
- Cleaning up old subscriptions
- Resetting data when parent changes
- Resubscribing to new parent data

# ✅ Checklist
- [ ] DTO includes parentId field
- [ ] Service extends correct base class (BeforeParentSyncService, ParentSyncService, or AfterParentSyncService)
- [ ] parentStream method implemented with proper filtering
- [ ] Security rules include parent membership checks
- [ ] No memory leaks (base service handles cleanup)
- [ ] Proper error handling in place
