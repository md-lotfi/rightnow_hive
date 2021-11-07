import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rightnow/events/ReclamationsEvent.dart';
import 'package:rightnow/models/reclamations.dart';
import 'package:rightnow/rest/ApiRepository.dart';
import 'package:rightnow/rest/ApiResult.dart';
import 'package:rightnow/rest/network_exceptions.dart';
import 'package:rightnow/states/result_state.dart';

class ReclamationsBloc extends Bloc<ReclamationsEvent, ResultState<List<Reclamations>>> {
  final ApiRepository apiRepository = ApiRepository();

  ReclamationsBloc() : super(Idle());

  @override
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
  }
}
