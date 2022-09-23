import 'package:veto/base_view_model.dart';

class BaseViewModelImplementation<T> extends BaseViewModel<T> {
  BaseViewModelImplementation({
    required bool isMock,
  }) : _isMock = isMock;

  final bool _isMock;
  double stubbedTextScaleFactor = 1;

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
}
