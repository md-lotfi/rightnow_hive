/*import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/events/ProvinceEvent.dart';
import 'package:rightnow/models/province.dart';
import 'package:rightnow/rest/ApiRepository.dart';
import 'package:rightnow/rest/ApiResult.dart';
import 'package:rightnow/rest/network_exceptions.dart';
import 'package:rightnow/states/result_state.dart';

class ServerLoadProvincesBloc extends Bloc<ProvinceEvent, ResultState<List<Province>>> {
  final ApiRepository apiRepository = ApiRepository();

  ServerLoadProvincesBloc() : super(Idle());

  @override
  Stream<ResultState<List<Province>>> mapEventToState(ProvinceEvent event) async* {
    yield ResultState.loading();

    if (event is ServerLoadProvinces) {
      //if (!local) {
      ApiResult<List<Province>> apiResult = await apiRepository.getProvinces();
      yield* apiResult.when(success: (List<Province>? data) async* {
        await getDataBase().provinceDao.setProvinces(data!);
        yield ResultState.data(data: data);
      }, failure: (NetworkExceptions? error) async* {
        yield ResultState.error(error: error);
      });
      //}
    }
  }
}
*/