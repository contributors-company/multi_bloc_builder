## Getting started

```shell
flutter pub add multi_bloc_builder
```

## Usage

```dart
import 'package:multi_bloc_builder/multi_bloc_builder.dart';

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
```

