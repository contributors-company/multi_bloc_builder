
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import 'multi_bloc_builder.dart';

typedef MultiBlocListenerCallback = void Function(BuildContext, List<dynamic>);

typedef MultiBlocListenWhenCallback = bool Function(List<dynamic>, List<dynamic>);

class MultiBlocConsumer extends StatelessWidget {
  final List<BlocBase> blocs;
  final MultiBlocBuilderCallback builder;
  final MultiBlocBuildWhenCallback? buildWhen;

  final MultiBlocListenerCallback? listener;
  final MultiBlocListenWhenCallback? listenWhen;

  const MultiBlocConsumer({super.key, required this.blocs, required this.builder, this.listener, this.listenWhen, required this.buildWhen});

  @override
  Widget build(BuildContext context) {
    return MultiBlocBuilder(
        buildWhen: (prev, next) {
          final states = blocs.map((BlocBase bloc) => bloc.state).toList();
          if (listenWhen?.call(prev, next) ?? true) {
            listener?.call(context, states);
          }
          return buildWhen?.call(prev, next) ?? true;
        },
        blocs: blocs,
        builder: builder
    );
  }

}
