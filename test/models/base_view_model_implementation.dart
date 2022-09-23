import 'package:veto/base_view_model.dart';

class BaseViewModelImplementation<T> extends BaseViewModel<T> {
  BaseViewModelImplementation({
    required bool isMock,
  }) : _isMock = isMock;

  final bool _isMock;
  late double stubbedTextScaleFactor;
  late double stubbedCurrentWidth;
  late double stubbedCurrentHeight;

  @override
  void rebuild() {
    if (!_isMock) {
      super.rebuild();
    }
  }

  @override
  double get textScaleFactor {
    if (_isMock) return stubbedTextScaleFactor;
    return super.textScaleFactor;
  }

  @override
  double get width {
    if (_isMock) return stubbedCurrentWidth;
    return super.width;
  }

  @override
  double get height {
    if (_isMock) return stubbedCurrentHeight;
    return super.height;
  }
}
