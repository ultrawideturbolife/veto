import 'package:flutter_test/flutter_test.dart';
import 'package:gherkin_unit_test/unit_test.dart';
import 'package:veto/view_model_state.dart';

import '../models/base_view_model_implementation.dart';

class IsBusyFeature extends UnitFeature {
  IsBusyFeature()
      : super(
          description: 'BaseViewModel.isInitialised',
          scenarios: [
            UnitScenario<BaseViewModelImplementation>(
              description: 'Setting busy status on the BaseViewModel',
              systemUnderTest: () => BaseViewModelImplementation(isMock: true),
              steps: [
                Given(
                  'The BaseViewModel is not busy',
                  (systemUnderTest, log, [example, result]) {
                    expect(systemUnderTest.isBusy, false);
                    log.success('BaseViewModel was not busy');
                    final startingState = systemUnderTest.state;
                    log.info('Passing starting state as result to compare in last step.');
                    return startingState;
                  },
                ),
                When(
                  'we call the setBusy method with true',
                  (systemUnderTest, log, [example, result]) {
                    systemUnderTest.setBusy(true);
                    return result;
                  },
                ),
                Then(
                  'the BaseViewModel should be busy',
                  (systemUnderTest, log, [example, result]) {
                    expect(systemUnderTest.isBusy, true);
                    log.success('Boolean status was busy!');
                    expect(systemUnderTest.state, ViewModelState.isBusy);
                    log.success('ViewModelState was busy!');
                    return result;
                  },
                ),
                When(
                  'we call the setBusy method with false',
                  (systemUnderTest, log, [example, result]) async {
                    systemUnderTest.setBusy(false);
                    return result;
                  },
                ),
                Then(
                  'the BaseViewModel should no longer be busy',
                  (systemUnderTest, log, [example, result]) {
                    expect(systemUnderTest.isBusy, false);
                    log.success('BaseViewModel was not busy!');
                    expect(systemUnderTest.state, result);
                    log.success('ViewModelState was restored!');
                  },
                )
              ],
            )
          ],
        );
}
