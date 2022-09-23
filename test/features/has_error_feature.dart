import 'package:flutter_test/flutter_test.dart';
import 'package:gherkin_unit_test/unit_test.dart';
import 'package:veto/view_model_state.dart';

import '../models/base_view_model_implementation.dart';

main() {
  HasErrorFeature().test();
}

class HasErrorFeature extends UnitFeature {
  HasErrorFeature()
      : super(
    description: 'BaseViewModel.isError',
    scenarios: [
      UnitScenario<BaseViewModelImplementation, UnitExample>(
        description: 'Setting error status on the BaseViewModel',
        systemUnderTest: () => BaseViewModelImplementation(isMock: true),
        steps: [
          Given(
            'The BaseViewModel has no error',
                (systemUnderTest, log, [example, result]) {
              expect(systemUnderTest.hasError, false);
              log.success('BaseViewModel did not have an error');
              final startingState = systemUnderTest.state;
              log.info('Passing starting state as result to compare in last step.');
              return startingState;
            },
          ),
          When(
            'we call the setError method with true',
                (systemUnderTest, log, [example, result]) {
              systemUnderTest.setError(true);
              return result;
            },
          ),
          Then(
            'the BaseViewModel should have an error',
                (systemUnderTest, log, [example, result]) {
              expect(systemUnderTest.hasError, true);
              log.success('Error status was true!');
              expect(systemUnderTest.state, ViewModelState.hasError);
              log.success('ViewModelState was hasError!');
              return result;
            },
          ),
          When(
            'we call the setError method with false',
                (systemUnderTest, log, [example, result]) async {
              systemUnderTest.setError(false);
              return result;
            },
          ),
          Then(
            'the BaseViewModel should no longer have an error',
                (systemUnderTest, log, [example, result]) {
              expect(systemUnderTest.hasError, false);
              log.success('BaseViewModel did not have an error!');
              expect(systemUnderTest.state, result);
              log.success('ViewModelState was restored!');
            },
          )
        ],
      )
    ],
  );
}
