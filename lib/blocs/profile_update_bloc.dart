import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rightnow/events/UpdateProfileEvent.dart';
import 'package:rightnow/rest/ApiRepository.dart';

class ProfileUpdateBloc extends Bloc<UpdateProfileEvent, int> {
  final ApiRepository apiRepository = ApiRepository();

  ProfileUpdateBloc() : super(0) {
    on<Distract>((event, emit) => emit(0));
    on<SaveProfile>((event, emit) async => await _mapEventToState(event, emit));
  }

  Future<void> _mapEventToState(SaveProfile event, Emitter<int> emit) async {
    emit(1);

    bool x = await apiRepository.setUserProfile(event.profile);
    var r = x ? 2 : -1;
    log("updating state to $r");
    emit(r);
  }

  //ProfileUpdateBloc() : super(0);

  /*@override
  Stream<int> mapEventToState(UpdateProfileEvent event) async* {
    yield 1;

    if (event is Distract) {
      log("updating state to 0");
      yield 0;
    } else if (event is SaveProfile) {
      bool x = await apiRepository.setUserProfile(event.profile);
      var r = x ? 2 : -1;
      log("updating state to $r");
      yield r;
    }
  }*/
}
