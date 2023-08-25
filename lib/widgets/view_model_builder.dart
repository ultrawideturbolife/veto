part of '../data/models/base_view_model.dart';

/// Used to build and provide a [BaseViewModel] to the widget tree.
class ViewModelBuilder<T extends BaseViewModel> extends StatefulWidget {
  const ViewModelBuilder({
    required Widget Function(BuildContext context, T model) builder,
    required T Function() viewModelBuilder,
    Object? Function()? argumentBuilder,
    Key? key,
    final bool keepAlive = true,
  })  : _builder = builder,
        _viewModelBuilder = viewModelBuilder,
        _argumentBuilder = argumentBuilder,
        _keepAlive = keepAlive,
        super(key: key);

  /// Builder method that builds the widget tree.
  final Widget Function(BuildContext context, T model) _builder;

  /// Builder method that provides the [BaseViewModel].
  final T Function() _viewModelBuilder;

  /// Builder method that provides the [BaseViewModel.initialise] with arguments.
  final dynamic Function()? _argumentBuilder;

  final bool _keepAlive;

  @override
  ViewModelBuilderState<T> createState() => ViewModelBuilderState<T>();
}

class ViewModelBuilderState<T extends BaseViewModel>
    extends State<ViewModelBuilder<T>> with AutomaticKeepAliveClientMixin {
  /// The current [BaseViewModel].
  late final T _viewModel;

  /// Initialises the [BaseViewModel] and its needed methods.
  @override
  void initState() {
    _viewModel = widget._viewModelBuilder()
      .._disposableBuildContext = DisposableBuildContext(this)
      .._mounted = (() => mounted)
      .._rebuild = setState
      ..arguments = widget._argumentBuilder?.call();
    _viewModel.initialise();
    super.initState();
  }

  /// Disposes the [BaseViewModel] and its given methods.
  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget._builder(context, _viewModel);
  }

  @override
  bool get wantKeepAlive => widget._keepAlive;
}
