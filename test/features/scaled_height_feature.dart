import 'package:flutter_test/flutter_test.dart';
import 'package:gherkin_unit_test/unit_test.dart';

import '../models/base_view_model_implementation.dart';

main() {
  ScaledHeightFeature().test();
}

class ScaledHeightFeature extends UnitFeature {
  ScaledHeightFeature()
      : super(
          description: 'BaseViewModel.scaledHeight',
          scenarios: [
            UnitScenario<BaseViewModelImplementation, UnitExample>(
              description: 'Responsive sizing based on using the BaseViewModel.scaledHeight method',
              examples: [
                _ScaledHeightExample(
                    value: 64, originalDesignHeight: 600, stubbedCurrentHeight: 400),
                _ScaledHeightExample(
                    value: 150, originalDesignHeight: 600, stubbedCurrentHeight: 400),
                _ScaledHeightExample(
                    value: 320, originalDesignHeight: 600, stubbedCurrentHeight: 400),
                _ScaledHeightExample(
                    value: 64, originalDesignHeight: 360, stubbedCurrentHeight: 400),
                _ScaledHeightExample(
                    value: 150, originalDesignHeight: 360, stubbedCurrentHeight: 400),
                _ScaledHeightExample(
                    value: 320, originalDesignHeight: 360, stubbedCurrentHeight: 400),
                _ScaledHeightExample(
                    value: 64, originalDesignHeight: 200, stubbedCurrentHeight: 400),
                _ScaledHeightExample(
                    value: 150, originalDesignHeight: 200, stubbedCurrentHeight: 400),
                _ScaledHeightExample(
                    value: 320, originalDesignHeight: 200, stubbedCurrentHeight: 400),
                _ScaledHeightExample(
                    value: 64, originalDesignHeight: 600, stubbedCurrentHeight: 890),
                _ScaledHeightExample(
                    value: 150, originalDesignHeight: 600, stubbedCurrentHeight: 890),
                _ScaledHeightExample(
                    value: 320, originalDesignHeight: 600, stubbedCurrentHeight: 890),
                _ScaledHeightExample(
                    value: 64, originalDesignHeight: 360, stubbedCurrentHeight: 890),
                _ScaledHeightExample(
                    value: 150, originalDesignHeight: 360, stubbedCurrentHeight: 890),
                _ScaledHeightExample(
                    value: 320, originalDesignHeight: 360, stubbedCurrentHeight: 890),
                _ScaledHeightExample(
                    value: 64, originalDesignHeight: 200, stubbedCurrentHeight: 890),
                _ScaledHeightExample(
                    value: 150, originalDesignHeight: 200, stubbedCurrentHeight: 890),
                _ScaledHeightExample(
                    value: 320, originalDesignHeight: 200, stubbedCurrentHeight: 890),
              ],
              systemUnderTest: () => BaseViewModelImplementation(isMock: true),
              steps: [
                WhenThen(
                  'I call the BaseViewModel.scaledHeight method then it should return the (value * (height / originalDesignHeight))',
                  (systemUnderTest, log, [example, result]) {
                    final value = example.firstValue();
                    final originalDesignHeight = example.secondValue();
                    final stubbedCurrentHeight = example.thirdValue();
                    systemUnderTest.stubbedCurrentHeight = stubbedCurrentHeight;
                    log.info(
                        'Calling BaseViewModel.scaledHeight with value: $value and originalDesignHeight: $originalDesignHeight..');
                    final actualScaledHeightValue = systemUnderTest.scaledHeight(
                        value: value, originalDesignHeight: originalDesignHeight);
                    log.info(
                        'Scaled height value of $actualScaledHeightValue received, checking if valid..');
                    final expectedTextScaledValue =
                        value * (stubbedCurrentHeight / originalDesignHeight);
                    expect(actualScaledHeightValue, expectedTextScaledValue);
                    log.success('Design scaled value was $expectedTextScaledValue!');
                  },
                )
              ],
            )
          ],
        );
}

class _ScaledHeightExample extends UnitExample {
  _ScaledHeightExample({
    required double value,
    required double originalDesignHeight,
    required double stubbedCurrentHeight,
  }) : super(
          values: [
            value,
            originalDesignHeight,
            stubbedCurrentHeight,
          ],
        );
}
