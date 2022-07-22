import 'package:veto/base_view_model.dart';

/// Used to indicate the current state of a [BaseViewModel].
enum ViewModelState {
  /// Indicates the current [BaseViewModel.initialise] has not finished yet.
  isInitialising,

  /// Indicates the current [BaseViewModel.initialise] has finished.
  isInitialised,

  /// Indicates the current [BaseViewModel.isBusy] is true.
  isBusy,

  /// Indicates the current [BaseViewModel.hasError] is true.
  hasError,
}
