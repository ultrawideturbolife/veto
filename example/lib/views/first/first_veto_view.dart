import 'package:example/data/constants/const_durations.dart';
import 'package:example/data/enums/mounted_status.dart';
import 'package:example/views/first/first_veto_view_model.dart';
import 'package:flutter/material.dart';
import 'package:veto/base_view_model.dart';
import 'package:veto/view_model_state.dart';

class FirstVetoView extends StatelessWidget {
  const FirstVetoView({Key? key}) : super(key: key);
  static const String route = 'first-veto-view';

  /// Original width of the fictional design file that we got from our designer.
  ///
  /// Play around with this value to demonstrate the [BaseViewModel.scaledWidth] property.
  static const _originalDesignWidth = 390.0;

  /// Original height of the fictional design file that we got from our designer.
  ///
  /// Play around with this value to demonstrate the [BaseViewModel.scaledHeight] property.
  static const _originalDesignHeight = 844.0;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FirstVetoViewModel>(
      builder: (context, model) => MediaQuery(
        data: model.media.copyWith(
          textScaleFactor: model.textScaleFactor.clamp(1, 1.35),
        ),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Veto Test App'),
          ),
          body: GestureDetector(
            onTap: model.focusNode.unfocus,
            child: Stack(
              children: [
                Positioned.fill(
                  child: ValueListenableBuilder<bool>(
                    valueListenable: model.isInitialisedListenable,
                    builder: (context, isInitialised, child) => LayoutBuilder(
                      builder: (context, constraints) => AnimatedSwitcher(
                        duration: ConstDurations.defaultAnimationDuration,
                        child: isInitialised
                            ? ValueListenableBuilder<bool>(
                                valueListenable: model.isBusyListenable,
                                builder: (context, isBusy, child) => AnimatedSwitcher(
                                  duration: ConstDurations.defaultAnimationDuration,
                                  child: isBusy
                                      ? Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            ValueListenableBuilder<int>(
                                              valueListenable: model.busySeconds,
                                              builder: (context, busySeconds, child) => Text(
                                                'This model is busy for another $busySeconds seconds...',
                                                style: model.textTheme.titleMedium!
                                                    .copyWith(fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            const SizedBox(height: 16),
                                            const CircularProgressIndicator(),
                                          ],
                                        )
                                      : ValueListenableBuilder<bool>(
                                          valueListenable: model.hasErrorListenable,
                                          builder: (context, hasError, child) => AnimatedContainer(
                                            height: constraints.maxHeight,
                                            curve: Curves.decelerate,
                                            duration: ConstDurations.defaultAnimationDuration,
                                            decoration: BoxDecoration(
                                              color: hasError ? Colors.red : Colors.transparent,
                                            ),
                                            child: Container(
                                              margin: const EdgeInsets.all(16),
                                              decoration: BoxDecoration(
                                                color: model.theme.canvasColor,
                                                borderRadius: BorderRadius.circular(32),
                                              ),
                                              child: SingleChildScrollView(
                                                physics: const BouncingScrollPhysics(),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    SizedBox(
                                                      height: model.textScaled(
                                                        value: 40,
                                                        context: context,
                                                      ),
                                                    ),
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
                                                    SizedBox(
                                                      height: model.textScaled(
                                                        value: 16,
                                                        context: context,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.symmetric(
                                                        horizontal: 16,
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment.spaceEvenly,
                                                        children: [
                                                          Flexible(
                                                            child: Column(
                                                              children: [
                                                                Text(
                                                                  'ViewModel',
                                                                  maxLines: 1,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: Theme.of(context)
                                                                      .textTheme
                                                                      .bodyText1!
                                                                      .copyWith(
                                                                        fontWeight: FontWeight.bold,
                                                                      ),
                                                                ),
                                                                Text(
                                                                  '${model.modelCounter}',
                                                                  style: Theme.of(context)
                                                                      .textTheme
                                                                      .headline4,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          ValueListenableBuilder<int>(
                                                            valueListenable:
                                                                model.valueListenableCounter,
                                                            builder: (
                                                              context,
                                                              valueListenableCounter,
                                                              child,
                                                            ) =>
                                                                Flexible(
                                                              child: Column(
                                                                children: [
                                                                  Text(
                                                                    'ValueNotifier',
                                                                    maxLines: 1,
                                                                    overflow: TextOverflow.ellipsis,
                                                                    style: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyText1!
                                                                        .copyWith(
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                  ),
                                                                  Text(
                                                                    valueListenableCounter
                                                                        .toString(),
                                                                    style: Theme.of(context)
                                                                        .textTheme
                                                                        .headline4,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: model.textScaled(
                                                        value: 16,
                                                        context: context,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.symmetric(
                                                          horizontal: 16),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          FloatingActionButton(
                                                            onPressed: model.incrementModelCounter,
                                                            backgroundColor: Colors.red,
                                                            heroTag: '1',
                                                            child: const Icon(Icons.add),
                                                          ),
                                                          FloatingActionButton(
                                                            onPressed:
                                                                model.incrementValueNotifierCounter,
                                                            backgroundColor: Colors.blue,
                                                            heroTag: '2',
                                                            child: const Icon(Icons.add),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.symmetric(vertical: 16),
                                                      child: ElevatedButton(
                                                        onPressed: model.reset,
                                                        child: const Text('Reset'),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.symmetric(
                                                        horizontal: 16,
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          FloatingActionButton(
                                                            onPressed: model.decrementModelCounter,
                                                            backgroundColor: Colors.red,
                                                            heroTag: '3',
                                                            child: const Icon(Icons.remove),
                                                          ),
                                                          FloatingActionButton(
                                                            onPressed:
                                                                model.decrementValueNotifierCounter,
                                                            backgroundColor: Colors.blue,
                                                            heroTag: '4',
                                                            child: const Icon(Icons.remove),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(height: 16),
                                                    ElevatedButton(
                                                      style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty.all(
                                                                  Colors.pink)),
                                                      onPressed: model.pushSecondView,
                                                      child: const Text('Push Arguments'),
                                                    ),
                                                    const SizedBox(height: 16),
                                                    Padding(
                                                      padding: const EdgeInsets.symmetric(
                                                          horizontal: 16),
                                                      child: Row(
                                                        children: [
                                                          ValueListenableBuilder<MountedStatus>(
                                                            valueListenable: model.mountedStatus,
                                                            builder:
                                                                (context, mountedStatus, child) =>
                                                                    Expanded(
                                                              child: Text(
                                                                'Mounted: ${mountedStatus.name.capitalizeFirstLetter}',
                                                              ),
                                                            ),
                                                          ),
                                                          ElevatedButton(
                                                            style: ButtonStyle(
                                                                backgroundColor:
                                                                    MaterialStateProperty.all(
                                                                        Colors.orange)),
                                                            onPressed: model.updateMountedStatus,
                                                            child: const Text('Check status'),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(height: 16),
                                                    ElevatedButton(
                                                      style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty.all(
                                                                  Colors.yellow)),
                                                      onPressed: model.triggerBusy,
                                                      child: Text(
                                                        'Trigger Busy',
                                                        style: model.textTheme.bodyText1!
                                                            .copyWith(color: Colors.black),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 16),
                                                    Padding(
                                                      padding: const EdgeInsets.symmetric(
                                                          horizontal: 16),
                                                      child: ValueListenableBuilder<bool>(
                                                        valueListenable: model.hasErrorListenable,
                                                        builder: (context, hasError, child) => Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            AnimatedOpacity(
                                                              duration: ConstDurations
                                                                  .defaultAnimationDuration,
                                                              opacity: hasError ? 0.3 : 1,
                                                              child: IgnorePointer(
                                                                ignoring: hasError,
                                                                child: ElevatedButton(
                                                                  style: ButtonStyle(
                                                                    backgroundColor:
                                                                        MaterialStateProperty.all(
                                                                      Colors.black,
                                                                    ),
                                                                  ),
                                                                  onPressed: model.triggerError,
                                                                  child:
                                                                      const Text('Trigger Error'),
                                                                ),
                                                              ),
                                                            ),
                                                            AnimatedOpacity(
                                                              duration: ConstDurations
                                                                  .defaultAnimationDuration,
                                                              opacity: !hasError ? 0.3 : 1,
                                                              child: IgnorePointer(
                                                                ignoring: !hasError,
                                                                child: ElevatedButton(
                                                                  style: ButtonStyle(
                                                                    backgroundColor:
                                                                        MaterialStateProperty.all(
                                                                      Colors.black,
                                                                    ),
                                                                  ),
                                                                  onPressed: model.removeError,
                                                                  child: const Text('Remove Error'),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    AnimatedContainer(
                                                      duration:
                                                          ConstDurations.defaultAnimationDuration,
                                                      margin: const EdgeInsets.only(top: 16),
                                                      decoration: BoxDecoration(
                                                        color: Colors.blueAccent,
                                                        borderRadius: BorderRadius.circular(32),
                                                      ),
                                                      width: model.scaledWidth(
                                                        value: 200,
                                                        originalDesignWidth: _originalDesignWidth,
                                                      ),
                                                      height: model.scaledHeight(
                                                        value: 20,
                                                        originalDesignHeight: _originalDesignHeight,
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              'Scaled Container',
                                                              textAlign: TextAlign.center,
                                                              style: model.textTheme.subtitle2!
                                                                  .copyWith(color: Colors.white),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                ),
                              )
                            : const Center(child: CircularProgressIndicator()),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: ValueListenableBuilder<ViewModelState>(
                    valueListenable: model.stateListenable,
                    builder: (context, state, child) => Padding(
                      padding: EdgeInsets.only(
                        top: model.textScaled(value: 16, context: context),
                      ),
                      child: Text(
                        'Current State: ${state.name}\nWidth: ${model.width} | Height: ${model.height}',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => FirstVetoViewModel.locate,
    );
  }
}

extension on String {
  String get capitalizeFirstLetter => '${this[0].toUpperCase()}${substring(1)}';
}
