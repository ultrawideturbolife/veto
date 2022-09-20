import 'package:example/views/second/second_veto_view.dart';
import 'package:example/views/second/second_veto_view_arguments.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:veto/base_view_model.dart';

class FirstVetoViewModel extends BaseViewModel {
  int _modelCounter = 0;
  int get modelCounter => _modelCounter;

  final ValueNotifier<int> _valueNotifierCounter = ValueNotifier(0);
  ValueListenable<int> get valueListenableCounter => _valueNotifierCounter;

  @override
  Future<void> initialise({arguments}) async {
    super.initialise();
  }

  @override
  void dispose() {
    _valueNotifierCounter.dispose();
    super.dispose();
  }

  /// Increments the [modelCounter], and then rebuilds the UI
  void incrementModelCounter() {
    _modelCounter++;
    rebuild();
  }

  /// If the [modelCounter] is greater than 0, decrement the [modelCounter] and rebuild the UI
  void decrementModelCounter() {
    if (modelCounter > 0) {
      _modelCounter--;
      rebuild();
    }
  }

  /// Increments the value of the [_valueNotifierCounter] by one
  void incrementValueNotifierCounter() => _valueNotifierCounter.value++;

  /// If the value of the [_valueNotifierCounter] is greater than 0 decrement the counter
  void decrementValueNotifierCounter() {
    if (_valueNotifierCounter.value > 0) {
      _valueNotifierCounter.value--;
    }
  }

  void reset() {
    _valueNotifierCounter.value = 0;
    _modelCounter = 0;
    rebuild();
  }

  void pushSecondView() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SecondVetoView(
          secondVetoViewArguments: SecondVetoViewArguments(
            firstCounterValue: _modelCounter,
            secondCounterValue: _valueNotifierCounter.value,
          ),
        ),
      ),
    );
    print('''[🐛] [DEBUG] [🌟] [FirstVetoViewModel.pushSecondView] [📞] I was called''');
  }

  static FirstVetoViewModel get locate => FirstVetoViewModel();
}
