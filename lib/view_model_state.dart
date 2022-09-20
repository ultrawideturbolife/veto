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

/// Used to easily perform boolean checks on certain states.
extension ViewModelStateExtension on ViewModelState {
  /// Indicates the current [BaseViewModel.initialise] has not finished yet.
  bool get isInitialising => this == ViewModelState.isInitialising;

  /// Indicates the current [BaseViewModel.initialise] has finished.
  bool get isInitialised => this == ViewModelState.isInitialised;

  /// Indicates the current [BaseViewModel.isBusy] is true.
  bool get isBusy => this == ViewModelState.isBusy;

  /// Indicates the current [BaseViewModel.hasError] is true.
  bool get hasError => this == ViewModelState.hasError;
}
