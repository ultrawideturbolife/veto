import 'package:veto/base_view_model.dart';

class BaseViewModelImplementation<T> extends BaseViewModel<T> {
  BaseViewModelImplementation({
    required bool doRebuild,
  }) : _doRebuild = doRebuild;

  final bool _doRebuild;

  @override
  void rebuild() {
    if (_doRebuild) {
      super.rebuild();
    }
  }
}
