import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rightnow/events/ActualiteEvent.dart';
import 'package:rightnow/models/actualite.dart';
import 'package:rightnow/rest/ApiRepository.dart';
import 'package:rightnow/rest/ApiResult.dart';
import 'package:rightnow/rest/network_exceptions.dart';
import 'package:rightnow/states/result_state.dart';

class ActualiteBloc extends Bloc<ActualiteEvent, ResultState<List<Actualite>>> {
  final ApiRepository apiRepository = ApiRepository();

  ActualiteBloc() : super(const Idle()) {
    on<Distract>((event, emit) => emit(const ResultState.idle()));
    on<GetActualite>((event, emit) async => await _mapEventToState(event, emit));
  }

  Future<void> _mapEventToState(GetActualite event, Emitter<ResultState<List<Actualite>>> emit) async {
    emit(const ResultState.loading());

    ApiResult<List<Actualite>> apiResult = await apiRepository.getActualite();

    await apiResult.when(
      success: (data) async => emit(ResultState.data(data: data)),
      failure: (error) async => emit(ResultState.error(error: error)),
    );
  }

  /*ActualiteBloc() : super(Idle());

  @override
  Stream<ResultState<List<Actualite>>> mapEventToState(ActualiteEvent event) async* {
    yield ResultState.loading();

    if (event is GetActualite) {
      ApiResult<List<Actualite>> apiResult = await apiRepository.getActualite();

      yield* apiResult.when(success: (List<Actualite>? data) async* {
        yield ResultState.data(data: data);
      }, failure: (NetworkExceptions? error) async* {
        yield ResultState.error(error: error);
      });
    }
  }*/
}
