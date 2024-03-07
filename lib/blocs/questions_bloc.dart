import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/db/QuestionsDao.dart';
import 'package:rightnow/events/QuestionsEvent.dart';
import 'package:rightnow/models/Question.dart';
import 'package:rightnow/rest/ApiRepository.dart';
import 'package:rightnow/rest/ApiResult.dart';
import 'package:rightnow/rest/network_exceptions.dart';
import 'package:rightnow/states/result_state.dart';

class QuestionsBloc extends Bloc<QuestionsEvent, ResultState<List<Question>>> {
  final ApiRepository apiRepository = ApiRepository();

  QuestionsBloc() : super(const Idle()) {
    on<Distract>((event, emit) => emit(const ResultState.idle()));
    on<LoadQuestions>((event, emit) async => await _mapEventToState(event, emit));
  }

  Future<void> _mapEventToState(LoadQuestions event, Emitter<ResultState<List<Question>>> emit) async {
    emit(const ResultState.loading());

    print("we already have an is called loadifngQuestions ${event.fieldSetId}");
    List<Question> qs = await getDataBase<QuestionsDao>().fetchQuestionsWithChoices(event.fieldSetId);

    await ApiResult.success(data: qs).when(
      success: (data) async => emit(ResultState.data(data: data)),
      failure: (error) async => emit(ResultState.error(error: error)),
    );
  }
}
