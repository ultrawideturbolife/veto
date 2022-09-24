# Veto

# 📚 Veto

> *A lightweight MVVM state management solution originally inspired by the [FilledStacks](https://www.filledstacks.com/) [stacked](https://pub.dev/packages/stacked) package.*
>

![veto_example_project.png](veto_example_project.png)

<aside>
💡 The example project demonstrates every functionality of this package.

</aside>

# 🛠 How to use it?

1. Create a view model.

```dart
import 'package:flutter/material.dart';
import 'package:veto/base_view_model.dart';

class VetoViewModel extends BaseViewModel<String> {

  int counter = 0;

  @override
  Future<void> initialise() async {
    debugPrint('''[🐛] [DEBUG] [🌟] [VetoViewModel.initialise] [📞] I was initialised!''');
    super.initialise();
  }

  @override
  Future<void> dispose() async {
    debugPrint('''[🐛] [DEBUG] [🌟] [VetoViewModel.dispose] [📞] I was disposed!''');
    super.dispose();
  }

  void increment() {
    counter++;
    rebuild();
  }
}
```

1. Create a view with the view model.

```dart
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
```

1. Enjoy MVVM! 😍

---

The entire package has extensive documentation. Reading the `BaseViewModel` class from top to bottom will give you a good idea of the benefits of this package. Also, a good example project, proper unit tests and some widget tests have been to illustrate and test the most important features of this package. If you have any questions feel free to contact me through [codaveto.com](https://www.codaveto.com).
