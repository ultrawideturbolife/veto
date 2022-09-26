part of 'base_view_model.dart';

/// Used to build and provide a [BaseViewModel] to the widget tree.
class ViewModelBuilder<T extends BaseViewModel> extends StatefulWidget {
  const ViewModelBuilder({
    required Widget Function(BuildContext context, T model) builder,
    required T Function() viewModelBuilder,
    Object? Function()? argumentBuilder,
    bool disposeViewModel = true,
    bool initialiseViewModel = true,
    bool rebuild = true,
    Key? key,
  })  : _builder = builder,
        _viewModelBuilder = viewModelBuilder,
        _argumentBuilder = argumentBuilder,
        _disposeViewModel = disposeViewModel,
        _initialiseViewModel = initialiseViewModel,
        _rebuild = rebuild,
        super(key: key);

  /// Builder method that builds the widget tree.
  final Widget Function(BuildContext context, T model) _builder;

  /// Builder method that provides the [BaseViewModel].
  final T Function() _viewModelBuilder;

  /// Builder method that provides the [BaseViewModel.initialise] with arguments.
  final dynamic Function()? _argumentBuilder;

  /// Whether to dispose the view model.
  final bool _disposeViewModel;

  /// Whether to initialise the view model.
  final bool _initialiseViewModel;

  /// Whether to rebuild the view when [BaseViewModel.rebuild] is called.
  final bool _rebuild;

  @override
  ViewModelBuilderState<T> createState() => ViewModelBuilderState<T>();
}

class ViewModelBuilderState<T extends BaseViewModel> extends State<ViewModelBuilder<T>> {
  /// The current [BaseViewModel].
  late final T _viewModel;

  /// Initialises the [BaseViewModel] and its needed methods.
  @override
  void initState() {
    if (widget._initialiseViewModel) {
      _viewModel = widget._viewModelBuilder()
        .._disposableBuildContext = DisposableBuildContext(this)
        .._mounted = (() => mounted)
        .._rebuild = widget._rebuild ? setState : null
        ..arguments = widget._argumentBuilder?.call();
      _viewModel.initialise();
    } else {
      _viewModel = widget._viewModelBuilder();
    }
    super.initState();
  }

  /// Disposes the [BaseViewModel] and its given methods.
  @override
  void dispose() {
    if (widget._disposeViewModel) _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget._builder(context, _viewModel);
}
