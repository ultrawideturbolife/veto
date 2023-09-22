import 'dart:async';
import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:veto/data/enums/busy_type.dart';
import 'package:veto/data/models/busy_model.dart';

/// A service to manage the busy state of the application.
/// Utilizes a ValueNotifier to notify subscribers when the busy state changes.
class BusyService {
  BusyService._();
  static BusyService? _instance;

  /// Returns an instance of [BusyService] and sets the default [BusyType] if provided.
  static BusyService instance({BusyType? defaultBusyType}) {
    if (defaultBusyType != null) {
      _defaultBusyType = defaultBusyType;
    }
    return _instance ??= BusyService._();
  }

  static BusyType _defaultBusyType = BusyType.indicator;
  final _isBusy = ValueNotifier<BusyModel>(
    BusyModel(
      isBusy: false,
      busyType: _defaultBusyType,
      busyTitle: null,
      busyMessage: null,
    ),
  );

  ValueListenable<BusyModel> get isBusy => _isBusy;
  Timer? _allowUpdateTimer;
  int _isBusies = 0;
  int _isNotBusies = 0;
  final _mutex = _Mutex();

  /// Disposes resources held by [BusyService].
  void dispose() {
    _allowUpdateTimer?.cancel();
    _isBusy.dispose();
    _mutex.dispose();
    _instance = null;
  }

  /// Sets the busy state of the application.
  void setBusy(
    bool isBusy, {
    Duration minBusyDuration = Duration.zero,
    String? busyMessage,
    String? busyTitle,
    BusyType? busyType,
  }) {
    if (_allowUpdateTimer == null) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => _setBusy(
          isBusy: isBusy,
          busyMessage: busyMessage,
          busyTitle: busyTitle,
          busyType: busyType ?? _defaultBusyType,
        ),
      );
      if (isBusy) {
        _allowUpdateTimer = Timer(
          minBusyDuration,
          () {
            if ((_isBusies - _isNotBusies) != 0) {
              final isReallyBusy = _isBusies > _isNotBusies;
              WidgetsBinding.instance.addPostFrameCallback(
                (_) => _setBusy(
                  isBusy: isReallyBusy,
                  busyMessage: busyMessage,
                  busyType: busyType ?? _defaultBusyType,
                  busyTitle: busyTitle,
                ),
              );
              _mutex.lockAndRun(
                run: (unlock) {
                  _isBusies = 0;
                  _isNotBusies = 0;
                  unlock();
                },
              );
            }
            _allowUpdateTimer = null;
          },
        );
      }
    } else {
      _mutex.lockAndRun(
        run: (unlock) {
          if (isBusy) {
            _isBusies++;
          } else {
            _isNotBusies++;
          }
          unlock();
        },
      );
    }
  }

  /// Sets the busy state in the ValueNotifier
  void _setBusy({
    required bool isBusy,
    required String? busyMessage,
    required String? busyTitle,
    required BusyType busyType,
  }) =>
      _isBusy.value = BusyModel(
        isBusy: isBusy,
        busyTitle: isBusy ? busyTitle : null,
        busyMessage: isBusy ? busyMessage : null,
        busyType: busyType,
      );
}

/// A private class to implement a mutex.
/// Mutex is implemented to avoid race conditions when setting busy states.
class _Mutex {
  final _completerQueue = Queue<Completer>();

  /// Locks the busy state and runs the provided function
  FutureOr<T> lockAndRun<T>({
    required FutureOr<T> Function(VoidCallback unlock) run,
  }) async {
    final completer = Completer();
    _completerQueue.add(completer);
    if (_completerQueue.first != completer) {
      await _completerQueue.removeFirst().future;
    }
    final value = await run(() => completer.complete());
    return value;
  }

  /// Disposes resources held by [_Mutex].
  void dispose() {
    _completerQueue.clear();
  }
}
