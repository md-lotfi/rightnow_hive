import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/events/RegistrationEvent.dart';
import 'package:rightnow/rest/ApiRepository.dart';
import 'package:rightnow/rest/ApiResult.dart';
import 'package:rightnow/rest/network_exceptions.dart';
import 'package:rightnow/states/result_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginBloc extends Bloc<RegistrationEvent, ResultState<String>> {
  final ApiRepository apiRepository = ApiRepository();

  LoginBloc() : super(const Idle()) {
    on<Distract>((event, emit) => emit(const ResultState.idle()));
    on<LoginUser>((event, emit) async => await _mapEventToState(event, emit));
  }

  Future<void> _mapEventToState(LoginUser event, Emitter<ResultState<String>> emit) async {
    emit(const ResultState.loading());

    ApiResult<String> apiResult = await apiRepository.loginUser(event.localUser);

    await apiResult.when(
      success: (data) async {
        print("storing api key in shared preferences " + data!);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString(AUTH_KEY, data);
        emit(ResultState.data(data: data));
      },
      failure: (error) async => emit(ResultState.error(error: error)),
    );
  }

  //LoginBloc() : super(Idle());

  /*@override
  Stream<ResultState<String>> mapEventToState(RegistrationEvent event) async* {
    yield ResultState.loading();

    if (event is LoginUser) {
      ApiResult<String> apiResult = await apiRepository.loginUser(event.localUser);

      yield* apiResult.when(success: (String? data) async* {
        print("storing api key in shared preferences " + data!);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString(AUTH_KEY, data);

        yield ResultState.data(data: data);
      }, failure: (NetworkExceptions? error) async* {
        yield ResultState.error(error: error);
      });
    }
  }*/
}
