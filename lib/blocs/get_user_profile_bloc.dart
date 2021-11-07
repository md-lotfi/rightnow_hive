import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/events/RegistrationEvent.dart';
import 'package:rightnow/models/local_user.dart';
import 'package:rightnow/models/profile.dart';
import 'package:rightnow/rest/ApiRepository.dart';
import 'package:rightnow/rest/ApiResult.dart';
import 'package:rightnow/rest/network_exceptions.dart';
import 'package:rightnow/states/result_state.dart';

class GetUserProfileBloc extends Bloc<RegistrationEvent, ResultState<Profile>> {
  final ApiRepository apiRepository = ApiRepository();

  GetUserProfileBloc() : super(Idle());

  @override
  Stream<ResultState<Profile>> mapEventToState(RegistrationEvent event) async* {
    yield ResultState.loading();

    /*if (event is GetUserProfile) {
      LocalUser? lu = await getDataBase().localUser.fetchUser();
      assert(lu != null);

      ApiResult<Profile> apiResult = await apiRepository.getUserProfile(lu!);

      yield* apiResult.when(success: (Profile? data) async* {
        yield ResultState.data(data: data);
      }, failure: (NetworkExceptions? error) async* {
        yield ResultState.error(error: error);
      });
    } else if (event is Distract) {
      yield ResultState.idle();
    }*/
  }
}
