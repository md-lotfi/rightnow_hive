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

  AnswersPostBloc() : super(Idle());

  @override
  Stream<ResultState<void>> mapEventToState(AnswersEvent event) async* {
    yield ResultState.loading();

    if (event is Distract) {
      yield ResultState.idle();
    } else if (event is UploadAnswerHolder) {
      bool isOk = false;

      List<AnswerHolder>? waitingUploadAnswerHolder = await getDataBase<AnswerHolderDao>().fetchAnswerHoldersNotUploadedWithChildren();
      if (waitingUploadAnswerHolder != null) {
        /*if (waitingUploadAnswerHolder.length > 0) {
          LocalUser? lu = await getDataBase().localUser.fetchUser();
          print("answers post bloc uploading answer holder " + waitingUploadAnswerHolder.length.toString());
          isOk = true;
          for (var i = 0; i < waitingUploadAnswerHolder.length; i++) {
            bool sent = await apiRepository.postAnswerHolder(lu?.user ?? 0, waitingUploadAnswerHolder[i]);
            if (sent) {
              print("terminating answer holder ....");
              getDataBase().answerHolderDao.terminateAnswerHolder(waitingUploadAnswerHolder[i].id!);
            } else {
              print("deleting answer holder ....");
              getDataBase().answerHolderDao.deleteAnswerHolder(waitingUploadAnswerHolder[i].id!);
            }
          }
          yield ResultState.data(data: true);
          /*yield* apiResult.when(success: (void data) async* {
            getDataBase().answerHolderDao.teminateAnswerHolders(waitingUploadAnswerHolder);
            yield ResultState.data(data: true);
          }, failure: (NetworkExceptions? error) async* {
            getDataBase().answerHolderDao.teminateAnswerHolders(waitingUploadAnswerHolder);
            yield ResultState.error(error: error);
          });*/
        }*/
      }
      if (!isOk) {
        yield ResultState.idle();
      }
    }
  }
}
