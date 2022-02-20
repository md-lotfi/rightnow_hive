import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rightnow/events/UpdateProfileEvent.dart';
import 'package:rightnow/rest/ApiRepository.dart';

class ProfileUpdateBloc extends Bloc<UpdateProfileEvent, int> {
  final ApiRepository apiRepository = ApiRepository();

  ProfileUpdateBloc() : super(0);

  @override
  Stream<int> mapEventToState(UpdateProfileEvent event) async* {
    yield 1;

    if (event is SaveProfile) {
      bool x = await apiRepository.setUserProfile(event.profile);
      yield x ? 2 : -1;
    }
  }
}
