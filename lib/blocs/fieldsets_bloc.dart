import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/db/FieldSetsDao.dart';
import 'package:rightnow/events/FieldsetsEvent.dart';
import 'package:rightnow/models/FieldSet.dart';
import 'package:rightnow/rest/ApiRepository.dart';
import 'package:rightnow/rest/ApiResult.dart';
import 'package:rightnow/rest/network_exceptions.dart';
import 'package:rightnow/states/result_state.dart';

class FieldsetsBloc extends Bloc<FieldsetsEvent, ResultState<List<FieldSet>>> {
  final ApiRepository apiRepository = ApiRepository();

  FieldsetsBloc() : super(const Idle()) {
    //on<Distract>((event, emit) => emit(const ResultState.idle()));
    on<LoadLocalFieldSets>((event, emit) async => await _mapEventToState(event, emit));
  }

  Future<void> _mapEventToState(LoadLocalFieldSets event, Emitter<ResultState<List<FieldSet>>> emit) async {
    emit(const ResultState.loading());

    ApiResult<List<FieldSet>> apiResult = await getDataBase<FieldSetsDao>().fetchFieldsAll(event.formId).then((value) {
      return ApiResult.success(data: value);
    });

    await apiResult.when(
      success: (data) async => emit(ResultState.data(data: data)),
      failure: (error) async => emit(ResultState.error(error: error)),
    );
  }

  //FieldsetsBloc() : super(Idle());

  /*@override
  Stream<ResultState<List<FieldSet>>> mapEventToState(FieldsetsEvent event) async* {
    yield ResultState.loading();

    if (event is LoadLocalFieldSets) {
      ApiResult<List<FieldSet>> apiResult = await getDataBase<FieldSetsDao>().fetchFieldsAll(event.formId).then((value) {
        return ApiResult.success(data: value);
      });
      yield* apiResult.when(success: (List<FieldSet>? data) async* {
        yield ResultState.data(data: data);
      }, failure: (NetworkExceptions? error) async* {
        yield ResultState.error(error: error);
      });
    }
    /*else if (event is UploadAnswerHolder) {
      ApiResult<List<FieldSet>> apiResult = await apiRepository.fetchHash()
          .fetchFieldsAll(event.formId)
          .then((value) {
        return ApiResult.success(data: value);
      });
      yield* apiResult.when(success: (List<FieldSet> data) async* {
        yield ResultState.data(data: data);
      }, failure: (NetworkExceptions error) async* {
        yield ResultState.error(error: error);
      });
    }*/
  }*/
}
