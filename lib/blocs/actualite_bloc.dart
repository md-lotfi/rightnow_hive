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

  ActualiteBloc() : super(Idle());

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
  }
}
