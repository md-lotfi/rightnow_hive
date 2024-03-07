import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/db/AnswerHolderDao.dart';
import 'package:rightnow/events/HistoryEvent.dart';
import 'package:rightnow/models/AnswersHolder.dart';
import 'package:rightnow/models/reclamations.dart';
import 'package:rightnow/rest/ApiRepository.dart';
import 'package:rightnow/rest/ApiResult.dart';
import 'package:rightnow/rest/network_exceptions.dart';
import 'package:rightnow/states/result_state.dart';

/*class ReclamationAnswerHolder {
  List<AnswerHolder> answerHolders;
  List<Reclamations> reclamations;
  ReclamationAnswerHolder({
    required this.answerHolders,
    required this.reclamations,
  });
}*/

class HistoryBloc extends Bloc<HistoryEvent, ResultState<List<AnswerHolder>>> {
  final ApiRepository apiRepository = ApiRepository();

  HistoryBloc() : super(const Idle()) {
    //on<Distract>((event, emit) => emit(const ResultState.idle()));
    on<LoadHistory>((event, emit) async => await _mapEventToState(event, emit));
  }

  Future<void> _mapEventToState(LoadHistory event, Emitter<ResultState<List<AnswerHolder>>> emit) async {
    emit(const ResultState.loading());

    ApiResult<List<AnswerHolder>> apiResult = await getDataBase<AnswerHolderDao>().loadAllAnswerHolders().then((value) {
      print("loading answerHolders success " + value.toString());
      return ApiResult.success(data: value);
    });

    await apiResult.when(
      success: (data) async => emit(ResultState.data(data: data)),
      failure: (error) async => emit(ResultState.error(error: error)),
    );
  }

  //HistoryBloc() : super(Idle());

  /*@override
  Stream<ResultState<List<AnswerHolder>>> mapEventToState(HistoryEvent event) async* {
    yield ResultState.loading();

    if (event is LoadHistory) {
      ApiResult<List<AnswerHolder>> apiResult = await getDataBase<AnswerHolderDao>().loadAllAnswerHolders().then((value) {
        print("loading answerHolders success " + value.toString());
        return ApiResult.success(data: value);
      });
      yield* apiResult.when(success: (List<AnswerHolder>? data) async* {
        yield ResultState.data(data: data);
      }, failure: (NetworkExceptions? error) async* {
        yield ResultState.error(error: error);
      });
    }
  }*/
}
