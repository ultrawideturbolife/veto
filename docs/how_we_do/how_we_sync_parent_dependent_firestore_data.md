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
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
  });

  final String parentId;
  final String name;
  @TimestampConverter()
  final DateTime createdAt;
  @TimestampConverter()
  final DateTime updatedAt;
  final String createdBy;
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

# 📚 Base Service Implementation

Here's the implementation of our parent sync service base classes:

```dart
abstract class ParentSyncService<T extends WriteableId<String>, API extends BaseApi<T>>
    extends CollectionService<T, API> {
  ParentSyncService({required super.api}) {
    _parentService.listenable.addListener(_onParentChanged);
  }

  // 📍 LOCATOR ------------------------------------------------------------------------------- \\
  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\

  final _parentService = ParentService.locate;

  // 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\

  @override
  @mustCallSuper
  Future<void> dispose() async {
    _parentService.listenable.removeListener(_onParentChanged);
    await super.dispose();
  }

  // 👂 LISTENERS ----------------------------------------------------------------------------- \\

  void _onParentChanged() {
    final currentId = parentId;
    if (_lastParentId != currentId) {
      _lastParentId = currentId;
      resetAndTryInitialiseStream();
    }
  }

  // ⚡️ OVERRIDES ----------------------------------------------------------------------------- \\

  @override
  FutureOr<Stream<List<T>?>> Function(User user) get stream => (user) async {
        await _parentService.isReady;
        return parentStream(user, parentId);
      };

  FutureOr<Stream<List<T>?>> parentStream(User user, String? parentId);

  // 🎩 STATE --------------------------------------------------------------------------------- \\

  String? _lastParentId;
  String? get parentId => _parentService.parentId;
}

abstract class AfterParentSyncService<T extends WriteableId<String>, API extends BaseApi<T>>
    extends AfterCollectionService<T, API> {
  AfterParentSyncService({required super.api}) {
    _parentService.listenable.addListener(_onParentChanged);
  }

  // 📍 LOCATOR ------------------------------------------------------------------------------- \\
  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\

  final _parentService = ParentService.locate;

  // 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\

  @override
  @mustCallSuper
  Future<void> dispose() async {
    _parentService.listenable.removeListener(_onParentChanged);
    await super.dispose();
  }

  // 👂 LISTENERS ----------------------------------------------------------------------------- \\

  void _onParentChanged() {
    final currentId = _parentService.parentId;
    if (_lastParentId != currentId) {
      _lastParentId = currentId;
      resetAndTryInitialiseStream();
    }
  }

  // ⚡️ OVERRIDES ----------------------------------------------------------------------------- \\

  @override
  FutureOr<Stream<List<T>?>> Function(User user) get stream => (user) async {
        await _parentService.isReady;
        return parentStream(user, _parentService.parentId);
      };

  FutureOr<Stream<List<T>?>> parentStream(User user, String? parentId);

  // 🎩 STATE --------------------------------------------------------------------------------- \\

  String? _lastParentId;
}

abstract class BeforeParentSyncService<T extends WriteableId<String>, API extends BaseApi<T>>
    extends BeforeCollectionService<T, API> {
  BeforeParentSyncService({required super.api}) {
    parentService.listenable.addListener(_onParentChanged);
  }

  // 📍 LOCATOR ------------------------------------------------------------------------------- \\
  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\

  @protected
  final parentService = ParentService.locate;

  // 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\

  @override
  @mustCallSuper
  Future<void> dispose() async {
    parentService.listenable.removeListener(_onParentChanged);
    await super.dispose();
  }

  // 👂 LISTENERS ----------------------------------------------------------------------------- \\

  void _onParentChanged() {
    final currentId = parentService.parentId;
    if (_lastParentId != currentId) {
      _lastParentId = currentId;
      resetAndTryInitialiseStream();
    }
  }

  // ⚡️ OVERRIDES ----------------------------------------------------------------------------- \\

  @override
  FutureOr<Stream<List<T>?>> Function(User user) get stream => (user) async {
        await parentService.isReady;
        return parentStream(user, parentService.parentId);
      };

  FutureOr<Stream<List<T>?>> parentStream(User user, String? parentId);

  // 🎩 STATE --------------------------------------------------------------------------------- \\

  String? _lastParentId;
}
```

These base classes provide:
- Automatic subscription management when parent changes
- Proper cleanup in dispose
- Stream initialization after parent is ready
- Abstract `parentStream` method for filtering by parent ID