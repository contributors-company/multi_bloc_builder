
//THIS IS SH!T
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

typedef MultiBlocBuilderCallback = Widget Function(BuildContext, List<dynamic>);

typedef MultiBlocBuildWhenCallback = bool Function(List<dynamic>, List<dynamic>);

class MultiBlocBuilder extends StatefulWidget {
  final List<BlocBase> blocs;
  final MultiBlocBuilderCallback builder;
  final MultiBlocBuildWhenCallback? buildWhen;



  const MultiBlocBuilder({super.key, required this.blocs, required this.builder, this.buildWhen});

  @override
  State<MultiBlocBuilder> createState() => _MultiBlocBuilderState();
}

class _MultiBlocBuilderState extends State<MultiBlocBuilder> {
  late List<dynamic> _previousState;

  List<dynamic> get _states => widget.blocs.map((BlocBase bloc) => bloc.state).toList();

  @override
  void initState() {
    super.initState();
    _previousState = _states;
  }

  @override
  void didUpdateWidget(covariant MultiBlocBuilder oldWidget) {
    if(widget.buildWhen?.call(_previousState, widget.blocs) ?? true) {
      _previousState = _states;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return widget.builder(
            context,
            _previousState
        );
      },
    );

  }
}