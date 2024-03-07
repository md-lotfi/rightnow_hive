import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rightnow/events/RegistrationEvent.dart';
import 'package:rightnow/rest/ApiRepository.dart';
import 'package:rightnow/rest/ApiResult.dart';
import 'package:rightnow/rest/network_exceptions.dart';
import 'package:rightnow/states/result_state.dart';

class CurrentUserIdBloc extends Bloc<RegistrationEvent, ResultState<int>> {
  final ApiRepository apiRepository = ApiRepository();

  CurrentUserIdBloc() : super(const Idle()) {
    on<Distract>((event, emit) => emit(const ResultState.idle()));
    on<GetUser>((event, emit) async => await _mapEventToState(event, emit));
  }

  Future<void> _mapEventToState(GetUser event, Emitter<ResultState<int>> emit) async {
    emit(const ResultState.loading());

    ApiResult<int> apiResult = await apiRepository.currentUser();

    await apiResult.when(
      success: (data) async => emit(ResultState.data(data: data)),
      failure: (error) async => emit(ResultState.error(error: error)),
    );
  }

  /*CurrentUserIdBloc() : super(Idle());

  @override
  Stream<ResultState<int>> mapEventToState(RegistrationEvent event) async* {
    yield ResultState.loading();

    if (event is GetUser) {
      ApiResult<int> apiResult = await apiRepository.currentUser();

      yield* apiResult.when(success: (int? data) async* {
        yield ResultState.data(data: data);
      }, failure: (NetworkExceptions? error) async* {
        yield ResultState.error(error: error);
      });
    }
  }*/
}
