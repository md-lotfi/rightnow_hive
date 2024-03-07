import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/db/AnswerHolderDao.dart';
import 'package:rightnow/events/AnswersEvent.dart';
import 'package:rightnow/models/AnswersHolder.dart';
import 'package:rightnow/models/local_user.dart';
import 'package:rightnow/rest/ApiRepository.dart';
import 'package:rightnow/states/result_state.dart';

class AnswersPostBloc extends Bloc<AnswersEvent, ResultState<void>> {
  final ApiRepository apiRepository = ApiRepository();

  AnswersPostBloc() : super(const Idle()) {
    on<Distract>((event, emit) => emit(const ResultState.idle()));
    on<UploadAnswerHolder>((event, emit) async => await _mapEventToState(event, emit));
  }

  Future<void> _mapEventToState(UploadAnswerHolder event, Emitter<ResultState<void>> emit) async {
    emit(const ResultState.loading());

    bool isOk = false;

    List<AnswerHolder>? waitingUploadAnswerHolder = await getDataBase<AnswerHolderDao>().fetchAnswerHoldersNotUploadedWithChildren();

    if (!isOk) {
      emit(ResultState.idle());
    }
  }

  /*AnswersPostBloc() : super(Idle());

  @override
  Stream<ResultState<void>> mapEventToState(AnswersEvent event) async* {
    yield ResultState.loading();

    if (event is Distract) {
      yield ResultState.idle();
    } else if (event is UploadAnswerHolder) {
      bool isOk = false;

      List<AnswerHolder>? waitingUploadAnswerHolder = await getDataBase<AnswerHolderDao>().fetchAnswerHoldersNotUploadedWithChildren();
      if (!isOk) {
        yield ResultState.idle();
      }
    }
  }*/
}
