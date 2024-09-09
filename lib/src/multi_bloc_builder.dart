import 'package:bloc/bloc.dart';

import 'package:flutter/cupertino.dart';

import 'utils/export.dart';

/// Signature for the `builder` function which takes the [BuildContext] and current ListBlocState
/// and is responsible for returning a widget which is to be rendered.
/// This is analogous to the `builder` function in [BlocBuilder].
class MultiBlocBuilder extends StatefulWidget {
  /// The [ListBloc] that the [MultiBlocBuilder] will interact with.
  final ListBloc blocs;

  /// The [MultiBlocBuilderCallback] function which will be invoked
  /// to build the widget based on the current state of the Blocs.
  /// The [MultiBlocBuilderCallback] function takes two parameters:
  /// - the [BuildContext] of the widget
  /// - the current state of the Blocs
  /// The [MultiBlocBuilderCallback] function should return a widget.
  /// The widget returned by the [MultiBlocBuilderCallback] function will be rendered on the screen.
  final MultiBlocBuilderCallback builder;

  /// The [MultiBlocBuildWhenCallback] function that will be invoked
  /// to determine whether the widget should be rebuilt.
  /// The [MultiBlocBuildWhenCallback] function takes two parameters:
  /// - the previous state of the Blocs
  /// - the current state of the Blocs
  /// The [MultiBlocBuildWhenCallback] function should return a boolean value.
  /// If it returns true, the widget will be rebuilt.
  /// If it returns false, the widget will not be rebuilt.
  final MultiBlocBuildWhenCallback? buildWhen;

  const MultiBlocBuilder({
    super.key,
    required this.blocs,
    required this.builder,
    this.buildWhen,
  });

  @override
  State<MultiBlocBuilder> createState() => _MultiBlocBuilderState();
}

class _MultiBlocBuilderState extends State<MultiBlocBuilder> {
  late ListBlocState _previousState;

  ListBlocState get _states =>
      widget.blocs.map((BlocBase bloc) => bloc.state).toList();

  @override
  void initState() {
    super.initState();
    _previousState = _states;
  }

  @override
  void didUpdateWidget(covariant MultiBlocBuilder oldWidget) {
    if (widget.buildWhen?.call(_previousState, widget.blocs) ?? true) {
      _previousState = _states;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) =>
          widget.builder(context, _previousState),
    );
  }
}
