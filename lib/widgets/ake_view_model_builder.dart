part of '../data/models/ake_base_view_model.dart';

/// Used to build and provide a [AkeBaseViewModel] to the widget tree.
class AkeViewModelBuilder<T extends AkeBaseViewModel> extends StatefulWidget {
  const AkeViewModelBuilder({
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

  /// Builder method that provides the [AkeBaseViewModel].
  final T Function() _viewModelBuilder;

  /// Builder method that provides the [AkeBaseViewModel.initialise] with arguments.
  final dynamic Function()? _argumentBuilder;

  final bool _keepAlive;

  @override
  AkeViewModelBuilderState<T> createState() => AkeViewModelBuilderState<T>();
}

class AkeViewModelBuilderState<T extends AkeBaseViewModel>
    extends State<AkeViewModelBuilder<T>> with AutomaticKeepAliveClientMixin {
  /// The current [AkeBaseViewModel].
  late final T _viewModel;

  /// Initialises the [AkeBaseViewModel] and its needed methods.
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

  /// Disposes the [AkeBaseViewModel] and its given methods.
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
