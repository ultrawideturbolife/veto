import 'package:gherkin_integration_test/integration_test.dart';

import 'integration_features/init_state_feature.dart';

void main() {
  VetoWidgetTest().test();
}

class VetoWidgetTest extends IntegrationTest {
  VetoWidgetTest()
      : super(
          description: 'Tests the ViewModelBuilder functionality',
          features: [
            InitStateFeature(),
          ],
        );
}
