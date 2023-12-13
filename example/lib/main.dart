import 'dart:developer';

import 'package:example/state/one/data_one_cubit.dart';
import 'package:example/state/two/data_two_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_bloc_builder/multi_bloc_builder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => DataOneCubit()),
        BlocProvider(create: (context) => DataTwoCubit()),

      ],
      child: const MaterialApp(
        title: 'MultiBlocBuilder Demo',
        home: MyHomePage(),
      )
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  _fetch() {
    context.read<DataOneCubit>().fetch();
    context.read<DataTwoCubit>().fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          MultiBlocConsumer(
            blocs: [
              context.watch<DataOneCubit>(),
              context.watch<DataTwoCubit>(),
            ],
            buildWhen: (next, prev) {
              log('BUILD WHEN: $next, $prev');
              return true;
            },
            listener: (context, states) {
              log('LISTENER: $states');
            },
            listenWhen: (next, prev) {
              log('LISTEN WHEN: $next, $prev');
              return true;
            },
            builder: (context, states) {
              DataOneState one = states[0];
              DataTwoState two = states[1];

              return Column(
                children: [
                  Text(one.toString()),
                  Text(two.toString()),
                ],
              );
            },
          ),

          ElevatedButton(onPressed: _fetch, child: const Text('Fetch'))
        ],
      )
    );
  }
}
