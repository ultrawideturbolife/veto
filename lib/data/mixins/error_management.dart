import 'package:flutter/foundation.dart';

/// Mixin to manage the error state of an object.
///
/// Provides utilities to handle error states with optional messages and titles.
mixin ErrorManagement {
  /// Private notifier to update the error state.
  final ValueNotifier<bool> _hasError = ValueNotifier(false);

  /// Public ValueListenable to observe the error state.
  ValueListenable<bool> get hasError => _hasError;

  /// Title to be shown when an error occurs.
  String? _errorTitle;

  /// Getter for error title.
  String? get errorTitle => _errorTitle;

  /// Message to be shown when an error occurs.
  String? _errorMessage;

  /// Getter for error message.
  String? get errorMessage => _errorMessage;

  /// Sets the error state along with optional title and message.
  ///
  /// [hasError] The new error state.
  /// [title] Optional title to be shown when error occurs.
  /// [message] Optional message to be shown when error occurs.
  void setError(
    bool hasError, {
    String? title,
    String? message,
  }) {
    _hasError.value = hasError;
    _errorTitle = title;
    _errorMessage = message;
    if (!hasError) {
      _errorTitle = null;
      _errorMessage = null;
    }
  }

  /// Dispose resources used in this mixin.
  ///
  /// This will nullify error title and message and dispose the ValueNotifier.
  void disposeErrorManagement() {
    _errorTitle = null;
    _errorMessage = null;
    _hasError.dispose();
  }
}
