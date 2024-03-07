import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rightnow/events/ReclamationsEvent.dart';
import 'package:rightnow/models/reclamations.dart';
import 'package:rightnow/rest/ApiRepository.dart';
import 'package:rightnow/rest/ApiResult.dart';
import 'package:rightnow/rest/network_exceptions.dart';
import 'package:rightnow/states/result_state.dart';

class ReclamationsBloc extends Bloc<ReclamationsEvent, ResultState<List<Reclamations>>> {
  final ApiRepository apiRepository = ApiRepository();

  ReclamationsBloc() : super(const Idle()) {
    //on<Distract>((event, emit) => emit(const ResultState.idle()));
    on<MyReclamations>((event, emit) async => await _mapEventToState(event, emit));
  }

  Future<void> _mapEventToState(MyReclamations event, Emitter<ResultState<List<Reclamations>>> emit) async {
    emit(const ResultState.loading());

    ApiResult<List<Reclamations>> apiResult = await apiRepository.fetchReclamations();

    await apiResult.when(
      success: (data) async => emit(ResultState.data(data: data)),
      failure: (error) async => emit(ResultState.error(error: error)),
    );
  }

  //ReclamationsBloc() : super(Idle());

  /*@override
  Stream<ResultState<List<Reclamations>>> mapEventToState(ReclamationsEvent event) async* {
    yield ResultState.loading();

    if (event is MyReclamations) {
      ApiResult<List<Reclamations>> apiResult = await apiRepository.fetchReclamations();

      yield* apiResult.when(success: (List<Reclamations>? data) async* {
        yield ResultState.data(data: data);
      }, failure: (NetworkExceptions? error) async* {
        yield ResultState.error(error: error);
      });
    }
  }*/
}
