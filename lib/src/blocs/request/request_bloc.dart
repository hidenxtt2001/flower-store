import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flower_store/src/models/request/request.dart';
import 'package:flower_store/src/services/app_repository.dart';

part 'request_event.dart';
part 'request_state.dart';

class RequestBloc extends Bloc<RequestEvent, RequestState> {
  RequestBloc() : super(RequestInitial()) {
    on<RequestLoaded>((event, emit) async {
      emit(RequestLoading());
      try {
        final requestList = await AppRepository().request.get();
        emit(RequestLoadedSuccess(requestList: requestList));
      } catch (error) {
        if (error is Response)
          emit(RequestLoadedFail(message: error.data["message"]));
        else
          emit(RequestLoadedFail(message: error.toString()));
      }
    });
  }
}
