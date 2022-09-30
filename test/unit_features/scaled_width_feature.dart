import 'package:flutter_test/flutter_test.dart';
import 'package:gherkin_unit_test/unit_test.dart';

import '../models/base_view_model_implementation.dart';

class ScaledWidthFeature extends UnitFeature {
  ScaledWidthFeature()
      : super(
          description: 'BaseViewModel.scaledWidth',
          scenarios: [
            UnitScenario<BaseViewModelImplementation, _ScaledWidthExample>(
              description:
                  'Responsive sizing based on using the BaseViewModel.scaledWidth method',
              examples: [
                _ScaledWidthExample(
                    width: 200,
                    originalDesignWidth: 340,
                    stubbedCurrentWidth: 390),
                _ScaledWidthExample(
                    width: 200,
                    originalDesignWidth: 480,
                    stubbedCurrentWidth: 390),
                _ScaledWidthExample(
                    width: 150,
                    originalDesignWidth: 340,
                    stubbedCurrentWidth: 390),
                _ScaledWidthExample(
                    width: 150,
                    originalDesignWidth: 480,
                    stubbedCurrentWidth: 390),
                _ScaledWidthExample(
                    width: 200,
                    originalDesignWidth: 340,
                    stubbedCurrentWidth: 460),
                _ScaledWidthExample(
                    width: 200,
                    originalDesignWidth: 480,
                    stubbedCurrentWidth: 460),
                _ScaledWidthExample(
                    width: 150,
                    originalDesignWidth: 340,
                    stubbedCurrentWidth: 460),
                _ScaledWidthExample(
                    width: 150,
                    originalDesignWidth: 480,
                    stubbedCurrentWidth: 460),
              ],
              systemUnderTest: (mocks) =>
                  BaseViewModelImplementation(isMock: true),
              steps: [
                WhenThen(
                  'I call the BaseViewModel.scaledWidth method then it should return the (value * (width / originalDesignWidth))',
                  (systemUnderTest, log, box, mocks, [example]) {
                    final value = example!.width;
                    final originalDesignWidth = example.originalDesignWidth;
                    final stubbedCurrentWidth = example.stubbedCurrentWidth;
                    systemUnderTest.stubbedCurrentWidth = stubbedCurrentWidth;
                    log.info(
                        'Calling BaseViewModel.scaledWidth with value: $value and originalDesignWidth: $originalDesignWidth..');
                    final actualScaledWidthValue = systemUnderTest.scaledWidth(
                        value: value, originalDesignWidth: originalDesignWidth);
                    log.info(
                        'Scaled width value of $actualScaledWidthValue received, checking if valid..');
                    final expectedTextScaledValue =
                        value * (stubbedCurrentWidth / originalDesignWidth);
                    expect(actualScaledWidthValue, expectedTextScaledValue);
                    log.success(
                        'Design scaled value was $expectedTextScaledValue!');
                  },
                )
              ],
            )
          ],
        );
}

class _ScaledWidthExample extends UnitExample {
  _ScaledWidthExample({
    required this.width,
    required this.originalDesignWidth,
    required this.stubbedCurrentWidth,
  });

  final double width;
  final double originalDesignWidth;
  final double stubbedCurrentWidth;
}
