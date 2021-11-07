import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/events/RegistrationEvent.dart';
import 'package:rightnow/models/profile.dart';
import 'package:rightnow/rest/ApiRepository.dart';
import 'package:rightnow/rest/ApiResult.dart';
import 'package:rightnow/rest/network_exceptions.dart';
import 'package:rightnow/states/result_state.dart';

class SetUserProfileBloc extends Bloc<RegistrationEvent, ResultState<Profile>> {
  final ApiRepository apiRepository = ApiRepository();

  SetUserProfileBloc() : super(Idle());

  @override
  Stream<ResultState<Profile>> mapEventToState(RegistrationEvent event) async* {
    yield ResultState.loading();

    /*if (event is SetUserProfile) {
      ApiResult<Profile> apiResult = await apiRepository.setUserProfile(event.profile);

      yield* apiResult.when(success: (Profile? data) async* {
        await getDataBase().profileDao.setProfile(data!);
        yield ResultState.data(data: data);
      }, failure: (NetworkExceptions? error) async* {
        yield ResultState.error(error: error);
      });
    }*/
  }
}
