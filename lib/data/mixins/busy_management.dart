import 'package:flutter/foundation.dart';

/// Mixin to manage the busy state of an object.
///
/// This mixin provides utilities to handle busy states with optional messages and titles.
mixin BusyManagement {
  /// Private notifier to update the busy state.
  final ValueNotifier<bool> _isBusy = ValueNotifier(false);

  /// Public ValueListenable to observe the busy state.
  ValueListenable<bool> get isBusy => _isBusy;

  /// Title to be shown when busy.
  String? _busyTitle;

  /// Getter for `_busyTitle`.
  String? get busyTitle => _busyTitle;

  /// Message to be shown when busy.
  String? _busyMessage;

  /// Getter for `_busyMessage`.
  String? get busyMessage => _busyMessage;

  /// Sets the busy state along with optional title and message.
  ///
  /// [isBusy] New busy state.
  /// [title] Optional title to be shown when busy.
  /// [message] Optional message to be shown when busy.
  void setBusy(
    bool isBusy, {
    String? title,
    String? message,
  }) {
    _isBusy.value = isBusy;
    _busyTitle = title;
    _busyMessage = message;
    if (!isBusy) {
      _busyTitle = null;
      _busyMessage = null;
    }
  }

  /// Dispose resources used in this mixin.
  ///
  /// This will nullify busy title and message and dispose the ValueNotifier.
  void disposeBusyManagement() {
    _busyTitle = null;
    _busyMessage = null;
    _isBusy.dispose();
  }
}
