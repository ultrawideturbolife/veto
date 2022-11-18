import 'package:example/views/second/second_veto_view.dart';

/// Holds arguments for the [SecondVetoView] to demonstrate the [BaseViewModel.arguments] functionality.
class SecondVetoViewArguments {
  const SecondVetoViewArguments({
    required this.firstCounterValue,
    required this.secondCounterValue,
  });

  final int firstCounterValue;
  final int secondCounterValue;
}
