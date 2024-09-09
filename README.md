# multi_bloc_builder

`multi_bloc_builder` is a Flutter package that provides widgets to manage multiple `Bloc` or `Cubit` state streams simultaneously. It simplifies the process of building UI or reacting to state changes when multiple state management objects are involved.

## Table of Contents

1. [Features](#features)
2. [Getting Started](#getting-started)
3. [MultiBlocBuilder](#multiblocbuilder)
    - [Example](#multiblocbuilder-example)
    - [Parameters](#multiblocbuilder-parameters)
    - [Key Points](#multiblocbuilder-key-points)
4. [MultiBlocConsumer](#multiblocconsumer)
    - [Example](#multiblocconsumer-example)
    - [Parameters](#multiblocconsumer-parameters)
    - [Key Points](#multiblocconsumer-key-points)
5. [Best Practices](#best-practices)
6. [Conclusion](#conclusion)

---

This will help users navigate through different sections of the documentation more easily!

## Features

- **MultiBlocBuilder**: Combine and rebuild UI based on multiple `Bloc` or `Cubit` states.
- **MultiBlocConsumer**: Listen to multiple `Bloc` or `Cubit` state changes and react with side effects while rebuilding UI.

## Getting Started

To start using `multi_bloc_builder`, add it to your `pubspec.yaml`:

```yaml
dependencies:
  multi_bloc_builder: version
```

Then, run:

```shell
flutter pub get
```


## `MultiBlocBuilder`

`MultiBlocBuilder` rebuilds the UI whenever any of the provided blocs or cubits emit new states. It takes a list of blocs and a builder that can use multiple states to construct the widget.

### Example:

```dart
import 'package:multi_bloc_builder/multi_bloc_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data_one_cubit.dart';
import 'data_two_cubit.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('MultiBlocBuilder Example')),
      body: MultiBlocBuilder(
        blocs: [
          context.watch<DataOneCubit>(),
          context.watch<DataTwoCubit>(),
        ],
        buildWhen: (nextStates, prevStates) {
          // Optional: control when to rebuild based on state changes
          return true;
        },
        builder: (context, states) {
          // Access each state by type
          final dataOneState = states.get<DataOneState>();
          final dataTwoState = states.get<DataTwoState>();

          return Column(
            children: [
              Text('Data One: $dataOneState'),
              Text('Data Two: $dataTwoState'),
            ],
          );
        },
      ),
    );
  }
}
```

### Parameters:

- **`blocs`**: A list of `BlocBase` instances (Blocs or Cubits) whose states will be listened to.
- **`buildWhen`** (optional): A callback that compares previous and current states to determine whether the widget should rebuild. It defaults to rebuilding whenever there is a new state.
- **`builder`**: A function that builds the widget based on the states of the provided blocs.

### Key Points:

- The `states.get<T>()` method lets you retrieve a specific bloc’s state by its type.
- `buildWhen` allows you to fine-tune when the UI rebuilds, avoiding unnecessary rebuilds for performance optimization.

## `MultiBlocConsumer`

`MultiBlocConsumer` extends `MultiBlocBuilder` by also allowing you to listen for state changes and execute side effects, such as showing alerts or logging.

### Example:

```dart
import 'package:multi_bloc_builder/multi_bloc_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data_one_cubit.dart';
import 'data_two_cubit.dart';
import 'dart:developer';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('MultiBlocConsumer Example')),
      body: MultiBlocConsumer(
        blocs: [
          context.watch<DataOneCubit>(),
          context.watch<DataTwoCubit>(),
        ],
        buildWhen: (nextStates, prevStates) {
          // Control when to rebuild based on state changes
          log('BuildWhen: Next: $nextStates, Prev: $prevStates');
          return true;
        },
        listenWhen: (nextStates, prevStates) {
          // Control when the listener gets triggered
          log('ListenWhen: Next: $nextStates, Prev: $prevStates');
          return true;
        },
        listener: (context, states) {
          // Execute side effects here based on state changes
          final dataOneState = states.get<DataOneState>();
          final dataTwoState = states.get<DataTwoState>();

          if (dataOneState is DataOneErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Data One Error: ${dataOneState.error}')),
            );
          }

          if (dataTwoState is DataTwoErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Data Two Error: ${dataTwoState.error}')),
            );
          }

          log('Listener: Current States: $states');
        },
        builder: (context, states) {
          final dataOneState = states.get<DataOneState>();
          final dataTwoState = states.get<DataTwoState>();

          return Column(
            children: [
              Text('Data One: $dataOneState'),
              Text('Data Two: $dataTwoState'),
            ],
          );
        },
      ),
    );
  }
}
```

### Parameters:

- **`blocs`**: A list of `BlocBase` instances whose states are listened to.
- **`buildWhen`** (optional): Controls when the widget should rebuild.
- **`listenWhen`** (optional): Controls when the `listener` should be triggered.
- **`listener`**: A callback to perform side effects when the bloc states change.
- **`builder`**: Builds the UI based on the current states of the provided blocs.

### Key Points:

- Use `listener` to handle side effects like showing error messages or triggering actions without affecting the widget rebuild logic.
- `listenWhen` lets you specify when the `listener` should be executed, allowing more fine-grained control over side effects.

## Best Practices

- **Performance Optimization**: Use `buildWhen` and `listenWhen` to prevent unnecessary widget rebuilds or listener executions.
- **State Access**: Use `states.get<T>()` to access bloc states by their type. This makes the code more readable and avoids manual type casting.

## Conclusion

`MultiBlocBuilder` and `MultiBlocConsumer` simplify handling multiple `Bloc` or `Cubit` state streams in Flutter. Whether you're building UI based on multiple states or reacting to state changes with side effects, these widgets provide a clean and efficient way to manage complex state dependencies.
