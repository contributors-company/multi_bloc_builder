part of 'data_one_cubit.dart';

sealed class DataOneState {}

class DataOneInitial extends DataOneState {}

class DataOneLoading extends DataOneState {}

class DataOneSuccess extends DataOneState {
  final dynamic data;

  DataOneSuccess(this.data);
}

class DataOneError extends DataOneState {}
