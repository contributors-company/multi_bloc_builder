library multi_bloc_builder;

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';


//THIS IS SH!T
class MultiBlocBuilder extends StatelessWidget {
  final List<BlocBase> blocs;
  final Widget Function(BuildContext, List<dynamic>) builder;


  const MultiBlocBuilder({super.key, required this.blocs, required this.builder});


  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return builder(
            context,
            blocs.map((BlocBase bloc) => bloc.state).toList()
        );
      },

    );
  }

}