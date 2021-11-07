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

  QuestionsBloc() : super(Idle());

  @override
  Stream<ResultState<List<Question>>> mapEventToState(QuestionsEvent event) async* {
    yield ResultState.loading();

    if (event is Distract) {
      yield ResultState.idle();
    } else if (event is LoadQuestions) {
      print("we already have an is called loadifngQuestions ${event.fieldSetId}");
      List<Question> qs = await getDataBase<QuestionsDao>().fetchQuestionsWithChoices(event.fieldSetId);
      //ApiResult<List<Question>> apiResult = ApiResult.success(data: qs);
      /*await getDataBase<QuestionsDao>().fetchQuestionsWithChoices(event.fieldSetId).then((value) async {
        print("we already have an result success");
        return ApiResult.success(data: value);
      });*/

      yield* ApiResult.success(data: qs).when(success: (List<Question>? data) async* {
        print("we already have an result success 2");
        yield ResultState.data(data: data);
      }, failure: (NetworkExceptions? error) async* {
        yield ResultState.error(error: error);
      });
    }
  }
}
