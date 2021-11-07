import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/db/FormFieldsDao.dart';
import 'package:rightnow/events/HashEvent.dart';
import 'package:rightnow/models/FormFields.dart';
import 'package:rightnow/models/hash.dart';
import 'package:rightnow/rest/ApiRepository.dart';
import 'package:rightnow/rest/ApiResult.dart';
import 'package:rightnow/rest/network_exceptions.dart';
import 'package:rightnow/states/result_state.dart';

class HashTypeHolder {
  final Hashes? hashes;
  final String? type;
  final int? formId;

  HashTypeHolder({this.hashes, this.type, this.formId});
}

class HashBloc extends Bloc<HashEvent, ResultState<HashTypeHolder>> {
  final ApiRepository apiRepository = ApiRepository();

  HashBloc() : super(Idle());

  @override
  Stream<ResultState<HashTypeHolder>> mapEventToState(HashEvent event) async* {
    yield ResultState.loading();

    if (event is Distract) {
      yield ResultState.idle();
    } else if (event is GetCategoriesHash) {
      ApiResult<Hashes> apiResult = await apiRepository.fetchHash(type: HASH_TYPE_CATEGORIES);

      yield* apiResult.when(success: (Hashes? data) async* {
        yield ResultState.data(data: new HashTypeHolder(hashes: data, type: HASH_TYPE_CATEGORIES));
      }, failure: (NetworkExceptions? error) async* {
        yield ResultState.error(error: error);
      });
    } else if (event is LoadCategories) {
      ApiResult<List<FormFields>> apiResult = await apiRepository.fetchFormFields();
      yield* apiResult.when(success: (List<FormFields>? data) async* {
        await getDataBase<FormFieldsDao>().setForms(data!, new Hashes.fill(event.currentHash, HASH_TYPE_CATEGORIES));
        /*await getDataBase().superCategoriesDao.setSuperCategories(data!, new Hashes.fill(event.currentHash, HASH_TYPE_CATEGORIES)).then((value) {
          print('databse save categories result id ' + value.toString());
        });*/
        yield ResultState.data(data: HashTypeHolder(type: HASH_TYPE_CATEGORIES_LOADED, hashes: Hashes.fill("", HASH_TYPE_CATEGORIES_LOADED)));
      }, failure: (NetworkExceptions? error) async* {
        yield ResultState.error(error: error);
      });
    }
  }
}
