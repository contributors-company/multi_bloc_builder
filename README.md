## Features

TODO: List what your package can do. Maybe include images, gifs, or videos.

## Getting started

```shell
flutter pub add multi_bloc_builder
```

## Usage

```dart
import 'package:multi_bloc_builder/multi_bloc_builder.dart';

MultiBlocBuilder(
    blocs: [
        context.watch<DataOneCubit>(),
        context.watch<DataTwoCubit>(),
    ],
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
)
```

