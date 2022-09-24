import 'package:flutter_test/flutter_test.dart';
import 'package:gherkin_unit_test/unit_test.dart';
import 'package:veto/view_model_state.dart';

import '../models/base_view_model_implementation.dart';

class IsInitialisedFeature extends UnitFeature {
  IsInitialisedFeature()
      : super(
          description: 'BaseViewModel.isInitialised',
          scenarios: [
            UnitScenario<BaseViewModelImplementation, UnitExample>(
              description: 'Initialising the BaseViewModel',
              systemUnderTest: () => BaseViewModelImplementation(isMock: true),
              steps: [
                Given(
                  'The BaseViewModel is not initialised yet',
                  (systemUnderTest, log, [example, result]) {
                    expect(systemUnderTest.isInitialised, false);
                    log.success('BaseViewModel was not initialised!');
                  },
                ),
                When(
                  'we call the initialise method',
                  (systemUnderTest, log, [example, result]) async {
                    await systemUnderTest.initialise();
                  },
                ),
                Then(
                  'the BaseViewModel should be initialised',
                  (systemUnderTest, log, [example, result]) {
                    expect(systemUnderTest.isInitialised, true);
                    log.success('BaseViewModel was initialised!');
                    expect(systemUnderTest.state, ViewModelState.isInitialised);
                    log.success('ViewModelState was isInitialised!');
                  },
                )
              ],
            )
          ],
        );
}
