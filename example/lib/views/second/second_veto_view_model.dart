import 'package:example/views/second/second_veto_view_arguments.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:veto/data/models/base_view_model.dart';

class SecondVetoViewModel extends BaseViewModel<SecondVetoViewArguments> {
  SecondVetoViewModel();

  final ValueNotifier<int> _firstValue = ValueNotifier(0);
  ValueListenable<int> get firstValue => _firstValue;

  final ValueNotifier<int> _secondValue = ValueNotifier(0);
  ValueListenable<int> get secondValue => _secondValue;

  @override
  Future<void> initialise() async {
    _log('Initialising..');
    final secondVetoViewArguments = arguments;
    _firstValue.value = secondVetoViewArguments.firstCounterValue;
    _secondValue.value = secondVetoViewArguments.secondCounterValue;
    super.initialise();
    _log('Initialised!');
  }

  /// Returns to [FirstVetoView].
  void goBack() {
    if (context != null) {
      Navigator.of(context!).pop();
    }
  }

  void _log(Object message) => debugPrint('💡 [INFO] $message');

  static SecondVetoViewModel get locate => SecondVetoViewModel();
}
