import 'dart:async';

import 'package:example/data/enums/mounted_status.dart';
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

  final ValueNotifier<MountedStatus> _mountedStatus = ValueNotifier(MountedStatus.unknown);
  ValueListenable<MountedStatus> get mountedStatus => _mountedStatus;

  final ValueNotifier<int> _busySeconds = ValueNotifier(0);
  ValueListenable<int> get busySeconds => _busySeconds;

  Timer? _busyTimer;

  @override
  Future<void> initialise() async {
    _log('Initialising..');
    _log('Calling addPostFrameCallback with dummy log to showcase usage!');
    await wait(1000);
    addPostFrameCallback((timeStamp) {
      _log('addPostFrameCallback dummy log!');
    });
    _log('Logging the media value to showcase it\'s usage:');
    _log('model.media: $media');
    super.initialise();
    _log('Initialised!');
  }

  @override
  void dispose() {
    _valueNotifierCounter.dispose();
    super.dispose();
  }

  /// Increments the [modelCounter], and then rebuilds the UI.
  void incrementModelCounter() {
    _modelCounter++;
    rebuild();
  }

  /// If the [modelCounter] is greater than 0, decrement the [modelCounter] and rebuild the UI.
  void decrementModelCounter() {
    if (modelCounter > 0) {
      _modelCounter--;
      rebuild();
    }
  }

  /// Increments the value of the [_valueNotifierCounter] by one.
  void incrementValueNotifierCounter() => _valueNotifierCounter.value++;

  /// If the value of the [_valueNotifierCounter] is greater than 0 decrement the counter.
  void decrementValueNotifierCounter() {
    if (_valueNotifierCounter.value > 0) {
      _valueNotifierCounter.value--;
    }
  }

  /// Resets both counters and mounted status to zero.
  void reset() {
    _valueNotifierCounter.value = 0;
    _modelCounter = 0;
    _mountedStatus.value = MountedStatus.unknown;
    setError(false);
    rebuild();
  }

  /// Pushes the second view with counter arguments.
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
  }

  /// Updates the current mounted status to [_mountedStatus] for demonstration purposes.
  void updateMountedStatus() => isMounted(
        (mounted) {
          _mountedStatus.value = mounted ? MountedStatus.mounted : MountedStatus.unmounted;
        },
      );

  /// Triggers the busy state for demonstration purposes.
  void triggerBusy() {
    _busySeconds.value = 3;
    setBusy(true);
    _busyTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        _busySeconds.value--;
        if (busySeconds.value == 0) {
          _busyTimer!.cancel();
          _busyTimer = null;
          setBusy(false);
        }
      },
    );
  }

  /// Triggers the error state for demonstration purposes.
  void triggerError() => setError(true);

  /// Removes the busy state for demonstration purposes.
  void removeError() => setError(false);

  void _log(Object message) => debugPrint('💡 [INFO] $message');

  static FirstVetoViewModel get locate => FirstVetoViewModel();
}
