import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import 'multi_bloc_builder.dart';

import 'utils/export.dart';

/// A widget that combines the functionality of [MultiBlocBuilder] and a listener.
///
/// [MultiBlocConsumer] allows you to build a widget based on the state of multiple Blocs
/// and also listen for state changes in those Blocs.
///
/// The [blocs] parameter is a list of Blocs that the [MultiBlocConsumer] will interact with.
///
/// The [builder] parameter is a function that will be invoked to build the widget
/// based on the current state of the Blocs.
///
/// The [listener] parameter is an optional function that will be invoked when the state
/// of any of the Blocs changes.
///
/// The [buildWhen] parameter is an optional function that determines whether the widget
/// should be rebuilt based on the previous and current state of the Blocs.
///
/// The [listenWhen] parameter is an optional function that determines whether the listener
/// should be invoked based on the previous and current state of the Blocs.
class MultiBlocConsumer extends StatelessWidget {
  /// The [ListBloc] that the [MultiBlocConsumer] will interact with.
  /// The [ListBloc] is a list of Blocs that the [MultiBlocConsumer] will interact with.
  /// The [MultiBlocConsumer] will listen to the state changes of the Blocs in the list.
  /// The [MultiBlocConsumer] will also build the widget based on the current state of the Blocs.
  /// The [ListBloc] is a list of [BlocBase] objects.
  final ListBloc blocs;

  /// The [MultiBlocBuilderCallback] function which will be invoked
  /// to build the widget based on the current state of the Blocs.
  /// The [MultiBlocBuilderCallback] function takes two parameters:
  /// - the [BuildContext] of the widget
  /// - the current state of the Blocs
  /// The [MultiBlocBuilderCallback] function should return a widget.
  /// The widget returned by the [MultiBlocBuilderCallback] function will be rendered on the screen.
  /// This is analogous to the `builder` function in [BlocBuilder].
  final MultiBlocBuilderCallback builder;

  /// The [MultiBlocBuildWhenCallback] function that will be invoked
  /// to determine whether the widget should be rebuilt.
  /// The [MultiBlocBuildWhenCallback] function takes two parameters:
  /// - the previous state of the Blocs
  /// - the current state of the Blocs
  final MultiBlocListenerCallback? listener;

  /// The [MultiBlocListenWhenCallback] function that will be invoked
  /// to determine whether the listener should be invoked.
  /// The [MultiBlocListenWhenCallback] function takes two parameters:
  /// - the previous state of the Blocs
  /// - the current state of the Blocs
  /// The [MultiBlocListenWhenCallback] function should return a boolean value.
  ///  If it returns true, the listener will be invoked.
  ///  If it returns false, the listener will not be invoked.
  final MultiBlocBuildWhenCallback? buildWhen;

  /// The [MultiBlocBuildWhenCallback] function that will be invoked
  /// to determine whether the widget should be rebuilt.
  /// The [MultiBlocBuildWhenCallback] function takes two parameters:
  /// - the previous state of the Blocs
  /// - the current state of the Blocs
  /// The [MultiBlocBuildWhenCallback] function should return a boolean value.
  /// If it returns true, the widget will be rebuilt.
  /// If it returns false, the widget will not be rebuilt.
  final MultiBlocListenWhenCallback? listenWhen;

  const MultiBlocConsumer({
    super.key,
    required this.blocs,
    required this.builder,
    this.listener,
    this.listenWhen,
    required this.buildWhen,
  });

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
      builder: builder,
    );
  }
}
