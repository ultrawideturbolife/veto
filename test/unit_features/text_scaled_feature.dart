import 'package:flutter_test/flutter_test.dart';
import 'package:gherkin_unit_test/unit_test.dart';

import '../models/base_view_model_implementation.dart';

main() {
  TextScaledFeature().test();
}

class TextScaledFeature extends UnitFeature {
  TextScaledFeature()
      : super(
          description: 'BaseViewModel.textScaled',
          scenarios: [
            UnitScenario<BaseViewModelImplementation, UnitExample>(
              description: 'Text with and without scaling',
              examples: [
                _TextScaledExample(stubbedScaleFactor: 0.70),
                _TextScaledExample(stubbedScaleFactor: 1),
                _TextScaledExample(stubbedScaleFactor: 1.35),
              ],
              systemUnderTest: () => BaseViewModelImplementation(isMock: true),
              steps: [
                Given(
                  'The textScaleFactor is set',
                  (systemUnderTest, log, [example, result]) {
                    final stubbedScaleFactor = example.firstValue();
                    log.info('Setting the text scale factor stub to $stubbedScaleFactor.');
                    systemUnderTest.stubbedTextScaleFactor = stubbedScaleFactor;
                    expect(systemUnderTest.textScaleFactor, stubbedScaleFactor);
                    log.success('Text scale factor was $stubbedScaleFactor!');
                  },
                ),
                WhenThen<BaseViewModelImplementation, _TextScaledExample>(
                  'I call the BaseViewModel.textScaled method then it should return the (value * textScaleFactor)',
                  (systemUnderTest, log, [example, result]) {
                    example?.firstValue();
                    log.info(
                        'Calling BaseViewModel.textScaled with default value ${_TextScaledExample.defaultFontSize}..');
                    final actualTextScaledValue =
                        systemUnderTest.textScaled(value: _TextScaledExample.defaultFontSize);
                    log.info(
                        'Text scaled value of $actualTextScaledValue received, checking if valid..');
                    final stubbedScaleFactor = example.firstValue();
                    final expectedTextScaledValue =
                        _TextScaledExample.defaultFontSize * stubbedScaleFactor;
                    expect(actualTextScaledValue, expectedTextScaledValue);
                    log.success('Text scaled value was $expectedTextScaledValue!');
                  },
                )
              ],
            )
          ],
        );
}

class _TextScaledExample extends UnitExample {
  _TextScaledExample({
    required double stubbedScaleFactor,
  }) : super(values: [stubbedScaleFactor]);

  static const defaultFontSize = 14.0;
}
