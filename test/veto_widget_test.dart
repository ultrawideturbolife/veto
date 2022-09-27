import 'package:gherkin_integration_test/integration_test.dart';

import 'integration_features/init_state_feature.dart';

void main() {
  VetoWidgetTest().test();
}

// TODO(codaveto): Test ViewModelBuilder.disposeViewModel argument | 27/09/2022
// TODO(codaveto): Test ViewModelBuilder.initialiseViewModel argument | 27/09/2022
// TODO(codaveto): Test ViewModelBuilder.rebuild argument | 27/09/2022

class VetoWidgetTest extends IntegrationTest {
  VetoWidgetTest()
      : super(
          description: 'Tests the ViewModelBuilder functionality',
          features: [
            InitStateFeature(),
          ],
        );
}
