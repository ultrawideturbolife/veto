import 'package:gherkin_unit_test/unit_test.dart';

import 'features/has_error_feature.dart';
import 'features/is_busy_feature.dart';
import 'features/is_initialised_feature.dart';
import 'features/scaled_height_feature.dart';
import 'features/scaled_width_feature.dart';
import 'features/text_scaled_feature.dart';

void main() {
  VetoUnitTest().test();
}

class VetoUnitTest extends UnitTest {
  VetoUnitTest()
      : super(
          description: 'Tests all features of the veto package',
          features: [
            HasErrorFeature(),
            IsBusyFeature(),
            IsInitialisedFeature(),
            ScaledHeightFeature(),
            ScaledWidthFeature(),
            TextScaledFeature(),
          ],
        );
}
