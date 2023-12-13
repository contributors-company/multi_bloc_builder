import 'package:bloc/bloc.dart';

part 'data_one_state.dart';

class DataOneCubit extends Cubit<DataOneState> {
  DataOneCubit() : super(DataOneInitial()) {
    fetch();
  }

  fetch() {
    emit(DataOneLoading());
    Future.delayed(const Duration(seconds: 3)).then((value) {
      emit(DataOneSuccess('Data One Success'));
    }).catchError((error) {
      emit(DataOneError());
    });
  }
}
