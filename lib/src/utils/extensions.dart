part of 'types.dart';

/// Extension on [ListMultiBlocState] to get the first state of type [T].
extension ListMultiBlocStateExtension on ListBlocState {
  T get<T>() {
    return whereType<T>() as T;
  }
}
