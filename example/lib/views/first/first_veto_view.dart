import 'package:example/views/first/first_veto_view_model.dart';
import 'package:flutter/material.dart';
import 'package:veto/base_view_model.dart';

class FirstVetoView extends StatelessWidget {
  const FirstVetoView({Key? key}) : super(key: key);
  static const String route = 'first-veto-view';

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FirstVetoViewModel>(
      builder: (context, model) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Veto Test App'),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 32),
                Text(
                  'First Veto View',
                  style: model.textTheme.headline5!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Made by Yyhwach_ and me',
                  style: model.textTheme.subtitle2!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // const SizedBox(height: 32), // TODO(codaveto): Enable assets | 20/09/2022
                // const Image(
                //   image: AssetImage(
                //     'assets/images/2022092002.png'
                //   ),
                // ),
                const SizedBox(height: 32),
                const Text(
                    'You have pushed the button this many times\n(this does not test anything):',
                    textAlign: TextAlign.center),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        '${model.modelCounter}',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      ValueListenableBuilder<int>(
                        valueListenable: model.valueListenableCounter,
                        builder: (context, valueListenableCounter, child) => Text(
                          valueListenableCounter.toString(),
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FloatingActionButton(
                        onPressed: model.incrementModelCounter,
                        backgroundColor: Colors.red,
                        heroTag: '1',
                        child: const Icon(Icons.add),
                      ),
                      FloatingActionButton(
                        onPressed: model.incrementValueNotifierCounter,
                        backgroundColor: Colors.blue,
                        heroTag: '2',
                        child: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: ElevatedButton(
                    onPressed: model.reset,
                    child: const Text('Reset'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FloatingActionButton(
                        onPressed: model.decrementModelCounter,
                        backgroundColor: Colors.red,
                        heroTag: '3',
                        child: const Icon(Icons.remove),
                      ),
                      FloatingActionButton(
                        onPressed: model.decrementValueNotifierCounter,
                        backgroundColor: Colors.blue,
                        heroTag: '4',
                        child: const Icon(Icons.remove),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.pink)
                  ),
                  onPressed: model.pushSecondView,
                  child: const Text('Push Second View'),
                ),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => FirstVetoViewModel.locate,
    );
  }
}
