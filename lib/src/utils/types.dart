import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

part 'extensions.dart';

/// [MultiBlocBuilderCallback] function for builder child in [MultiBlocBuilder]
typedef MultiBlocBuilderCallback = Widget Function(BuildContext, ListBlocState);

/// [MultiBlocListenWhenCallback] function for check State [Bloc] for rebuild or rebuild child in [MultiBlocConsumer]
typedef MultiBlocBuildWhenCallback = bool Function(
    ListBlocState, ListBlocState);

/// List [BlocBase] for [MultiBlocBuilder] and [MultiBlocConsumer]
typedef ListBloc = List<BlocBase>;

/// State of [ListBloc]
typedef ListBlocState = List<dynamic>;

/// [MultiBlocListenerCallback] function for listener in [MultiBlocConsumer]
typedef MultiBlocListenerCallback = void Function(BuildContext, ListBlocState);

/// [MultiBlocListenWhenCallback] function for check State [Bloc] for listen or rebuild child in [MultiBlocConsumer]
typedef MultiBlocListenWhenCallback = bool Function(
    ListBlocState, ListBlocState);
