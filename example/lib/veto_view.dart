import 'package:flutter/material.dart';
import 'package:veto/base_view_model.dart';

import 'veto_view_model.dart';

class VetoView extends StatelessWidget {
  const VetoView({Key? key}) : super(key: key);
  static const String route = 'veto-view';

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VetoViewModel>(
      argumentBuilder: () => 'Test',
      builder: (context, model) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(model.counter.toString()),
                ElevatedButton(
                  onPressed: model.increment,
                  child: const Text('Increment'),
                ),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => VetoViewModel(),
    );
  }
}
