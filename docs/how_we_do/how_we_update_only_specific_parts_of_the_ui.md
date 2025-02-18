# 🎯 How We Update Only Specific Parts of the UI

## 🔄 ValueNotifier & ValueListenableBuilder

Flutter provides `ValueNotifier` and `ValueListenableBuilder` for granular UI updates. Instead of rebuilding an entire widget tree when data changes, we can wrap specific parts of our UI in a `ValueListenableBuilder` to only rebuild what's necessary.

```dart
// Basic example of ValueNotifier
final counter = ValueNotifier<int>(0);

// Using ValueListenableBuilder for granular updates
ValueListenableBuilder<int>(
  valueListenable: counter,
  builder: (context, value, child) {
    return Text('Count: $value');
  },
)
```

While this works well for simple use cases, it has limitations when dealing with more complex state management needs.

## 💡 Informer

The `Informer` class extends `ValueNotifier` with additional features for state management and UI updates.

### Key Features

1. **Update Methods**
   - `update`: Replace the current value
   - `updateCurrent`: Modify the current value in-place
   - `silentUpdate`: Update without notifying listeners
   - `rebuild`: Force notify listeners without value change

2. **Collection Support**
   - `forceUpdate` option for reliable collection updates
   - Handles lists, maps, and sets efficiently

### Encapsulation Through ValueListenable

We never expose the `Informer` directly to the UI. Instead, we expose it as a `ValueListenable`:

```dart
class InvitesService {
  // Private Informer
  final _invites = Informer<List<InviteModel>>(
    [],
    forceUpdate: true,
  );

  // Public ValueListenable
  ValueListenable<List<InviteModel>> get invites => _invites;
}
```

### Real-World Example: Team Invites

```dart
class InvitesService {
  final _sentInvites = Informer<List<InviteModel>>(
    [],
    forceUpdate: true,
  );
  final _receivedInvites = Informer<List<InviteModel>>(
    [],
    forceUpdate: true,
  );

  ValueListenable<List<InviteModel>> get sentInvites => _sentInvites;
  ValueListenable<List<InviteModel>> get receivedInvites => _receivedInvites;

  @override
  Future<void> afterSyncNotifyUpdate(List<InviteDto> docs) async {
    final inviteModels = <InviteModel>[];
    // Process docs...

    final currentUserId = gUserId;
    final sent = <InviteModel>[];
    final received = <InviteModel>[];

    for (final invite in inviteModels) {
      if (invite.dto.createdBy == currentUserId) {
        sent.add(invite);
      }
      if (invite.dto.recipientId == currentUserId) {
        received.add(invite);
      }
    }

    _sentInvites.update(sent);
    _receivedInvites.update(received);
  }
}
```

### Benefits

1. **Update Control**: Different update methods for different needs
2. **Collection Support**: Reliable updates for collections
3. **Encapsulation**: Clean separation between data and UI layers

### Best Practices

1. Keep Informers private and expose as ValueListenable
2. Enable forceUpdate for collections
3. Place ValueListenableBuilder as deep in the widget tree as possible
