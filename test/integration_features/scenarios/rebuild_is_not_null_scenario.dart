import 'package:flutter/material.dart';
import 'package:gherkin_integration_test/integration_test.dart';
import 'package:veto/base_view_model.dart';

import '../../models/base_view_model_implementation.dart';

class RebuildIsNotNullScenario extends IntegrationScenario {
  RebuildIsNotNullScenario()
      : super(
          description:
              'Testing the rebuild method initialisation of the ViewModelBuilder',
          steps: [
            Given(
              'The BaseViewModel is built',
              (tester, log, [example, binding, result]) async {
                log.info('Building the BaseViewModel..');
                final baseViewModel =
                    BaseViewModelImplementation(isMock: false);
                log.success('BaseViewModel built!');
                log.info('Returning BaseViewModel as a result..');
                return baseViewModel;
              },
            ),
            When(
              'the ViewModelBuilder is initialised',
              (tester, log, [example, binding, result]) async {
                final BaseViewModelImplementation baseViewModel =
                    result.asType();
                await tester.pumpWidget(
                  ViewModelBuilder<BaseViewModelImplementation>(
                    builder: (context, model) => const SizedBox(),
                    viewModelBuilder: () => baseViewModel,
                  ),
                );
                await tester.pumpAndSettle();
                return baseViewModel;
              },
            ),
            Then(
              'The BaseViewModel.rebuild should be initialised and not be null',
              (tester, log, [example, binding, result]) {
                final BaseViewModelImplementation baseViewModel =
                    result.asType();
                baseViewModel.rebuild();
                log.success('Method did not throw!');
              },
            ),
          ],
        );
}
