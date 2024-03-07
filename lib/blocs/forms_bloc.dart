import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/db/AnswerHolderDao.dart';
import 'package:rightnow/db/FormFieldsDao.dart';
import 'package:rightnow/events/FormsEvent.dart';
import 'package:rightnow/models/FormFields.dart';
import 'package:rightnow/rest/ApiRepository.dart';
import 'package:rightnow/rest/ApiResult.dart';
import 'package:rightnow/rest/network_exceptions.dart';
import 'package:rightnow/states/result_state.dart';

class FormsBloc extends Bloc<FormsEvent, ResultState<List<FormFields>>> {
  final ApiRepository apiRepository = ApiRepository();

  FormsBloc() : super(const Idle()) {
    on<Distract>((event, emit) => emit(const ResultState.idle()));
    on<LoadLocalForms>((event, emit) async => await _mapEventToState(event, emit));
  }

  Future<void> _mapEventToState(LoadLocalForms event, Emitter<ResultState<List<FormFields>>> emit) async {
    emit(const ResultState.loading());

    ApiResult<List<FormFields>> apiResult = await getDataBase<FormFieldsDao>().loadFormsCategoryId(null, null, HOLDER_ANY_COMPLETED).then((value) {
      print("loading forms success " + value.toString());
      return ApiResult.success(data: value);
    });

    await apiResult.when(
      success: (data) async => emit(ResultState.data(data: data)),
      failure: (error) async => emit(ResultState.error(error: error)),
    );
  }

  /*FormsBloc() : super(Idle());

  @override
  Stream<ResultState<List<FormFields>>> mapEventToState(FormsEvent event) async* {
    yield ResultState.loading();

    if (event is Distract) {
      yield ResultState.idle();
    } else if (event is LoadLocalForms) {
      ApiResult<List<FormFields>> apiResult = await getDataBase<FormFieldsDao>().loadFormsCategoryId(null, null, HOLDER_ANY_COMPLETED).then((value) {
        print("loading forms success " + value.toString());
        return ApiResult.success(data: value);
      });
      yield* apiResult.when(success: (List<FormFields>? data) async* {
        yield ResultState.data(data: data);
      }, failure: (NetworkExceptions? error) async* {
        yield ResultState.error(error: error);
      });
    }
  }*/
}
