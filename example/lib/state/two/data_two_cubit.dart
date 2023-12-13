import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'data_two_state.dart';

class DataTwoCubit extends Cubit<DataTwoState> {
  DataTwoCubit() : super(DataTwoInitial()) {
    fetch();
  }

  fetch() {
    emit(DataTwoLoading());
    Future.delayed(const Duration(seconds: 5)).then((value) {
      emit(DataTwoSuccess('Data Two Success'));
    }).catchError((error) {
      emit(DataTwoError());
    });
  }
}
