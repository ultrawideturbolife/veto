import 'package:gherkin_integration_test/integration_test.dart';

import 'scenarios/arguments_are_transmitted_scenario.dart';
import 'scenarios/disposable_context_is_not_null_scenario.dart';
import 'scenarios/mounted_is_true_scenario.dart';
import 'scenarios/rebuild_is_not_null_scenario.dart';

class InitStateFeature extends IntegrationFeature {
  InitStateFeature()
      : super(
          description:
              'Tests the ViewModelBuilder\'s proper initialisation during the initState method',
          scenarios: [
            ArgumentsAreTransmittedScenario(),
            DisposableContextIsNotNullScenario(),
            MountedIsTrueScenario(),
            RebuildIsNotNullScenario(),
          ],
        );
}
