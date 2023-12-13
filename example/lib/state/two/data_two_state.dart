part of 'data_two_cubit.dart';

sealed class DataTwoState {}

class DataTwoInitial extends DataTwoState {}

class DataTwoLoading extends DataTwoState {}

class DataTwoSuccess extends DataTwoState {
  final dynamic data;

  DataTwoSuccess(this.data);
}

class DataTwoError extends DataTwoState {}