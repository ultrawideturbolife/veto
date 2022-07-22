import 'package:flutter/material.dart';
import 'package:veto/base_view_model.dart';

class VetoViewModel extends BaseViewModel<String> {
  int counter = 0;

  @override
  Future<void> initialise({arguments}) async {
    debugPrint(
        '''[🐛] [DEBUG] [🌟] [VetoViewModel.initialise] [📞] I was initialised!''');
    super.initialise();
  }

  @override
  Future<void> dispose() async {
    debugPrint(
        '''[🐛] [DEBUG] [🌟] [VetoViewModel.dispose] [📞] I was disposed!''');
    super.dispose();
  }

  void increment() {
    counter++;
    rebuild();
  }
}
