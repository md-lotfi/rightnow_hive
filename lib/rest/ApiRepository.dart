import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/db/AnswerHolderDao.dart';
import 'package:rightnow/db/FormStateDao.dart';
import 'package:rightnow/db/LocalUserDao.dart';
import 'package:rightnow/db/OrganisationDao.dart';
import 'package:rightnow/db/ProvincesDao.dart';
import 'package:rightnow/db/ReclamationsDao.dart';
import 'package:rightnow/db/UserNotificationsDao.dart';
import 'package:rightnow/db/blood_group_dao.dart';
import 'package:rightnow/db/disease_dao.dart';
import 'package:rightnow/models/AnswersHolder.dart';
import 'package:rightnow/models/FormFields.dart';
import 'package:rightnow/models/Question.dart';
import 'package:rightnow/models/about.dart';
import 'package:rightnow/models/actualite.dart';
import 'package:rightnow/models/answer.dart';
import 'package:rightnow/models/blood_group.dart';
import 'package:rightnow/models/category_forms.dart';
import 'package:rightnow/models/decision_response.dart';
import 'package:rightnow/models/disease.dart';
import 'package:rightnow/models/file_saver.dart';
import 'package:rightnow/models/form_entry.dart';
import 'package:rightnow/models/form_state.dart';
import 'package:rightnow/models/hash.dart';
import 'package:rightnow/models/link.dart';
import 'package:rightnow/models/local_user.dart';
import 'package:rightnow/models/login_error.dart';
import 'package:rightnow/models/organisation.dart';
import 'package:rightnow/models/profile.dart';
import 'package:rightnow/models/province.dart';
import 'package:rightnow/models/reclamations.dart';
import 'package:rightnow/models/response_form.dart';
import 'package:rightnow/models/social_links.dart';
import 'package:rightnow/models/user_notification.dart';
import 'package:rightnow/rest/ApiClient.dart';
import 'package:rightnow/rest/ApiResult.dart';
import 'package:rightnow/rest/network_exceptions.dart';
import 'package:rightnow/rest_response/categories_response.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';
import 'package:mime/mime.dart';

class ApiRepository {
  late ApiClient apiClient;

  ApiRepository() {
    var dio = Dio();

    apiClient = ApiClient(dio);
  }

  Future<bool> hasInternetConnection() async {
    try {
      await apiClient.get("api/forms/forms/hash/");
      return true;
    } catch (e) {
      print("error when processing data response " + e.toString());
      return false;
    }
  }

  Future<File?> download(String url, Function(int count, int total) progress) async {
    try {
      var tempDir = await getExternalStorageDirectory();
      if (tempDir == null) return null;
      Uuid uid = Uuid();
      final fullPath = tempDir.path + '/' + p.basename(url); //uid.v1() + p.extension(url);

      //"/storage/emulated/0/Documents/"
      log('full path $fullPath, from url $url');
      await Dio().download(
        url, //'https://app.rightnow-by-brenco.com/media/Qst1_Scope3.xlsx',
        fullPath,
        onReceiveProgress: (count, total) {
          progress(count, total);
          log("progress $count / $total");
        },
      );
      return File(fullPath);
    } catch (e) {
      log("error is $e");
      return null;
    }
  }

  /*Future<File?> download(String url, Function(int count, int total) progress) async {
    try {
      var tempDir = await getExternalStorageDirectory();
      if (tempDir == null) return null;
      Uuid uid = Uuid();
      String fullPath = tempDir.path + uid.v1() + p.extension(url); //"/storage/emulated/0/Documents/"
      log('full path $fullPath, from url $url');
      await Dio().download(
        url, //'https://app.rightnow-by-brenco.com/media/Qst1_Scope3.xlsx',
        fullPath,
        onReceiveProgress: (count, total) {
          progress(count, total);
          log("progress $count / $total");
        },
      );
      return File(fullPath);
    } catch (e) {
      log("error is $e");
      return null;
    }
  }*/

  Future<Map<String, dynamic>?> uploadProfilePicture(File file, Function(int received, int total) progress) async {
    try {
      LocalUser? u = await getDataBase<LocalUserDao>().fetchUser();
      if (u != null) {
        String fileName = file.path.split('/').last;
        FormData formData = FormData.fromMap({"picture": await MultipartFile.fromFile(file.path, filename: fileName), "pk": u.user});

        final response = await apiClient.post("api/accounts/profiles/change_picture/", data: formData, onSendProgress: progress);
        print("response received " + response.toString());
        if (response is String) return null;
        return response;
      }
      return {};
    } catch (e) {
      print("error when processing data response " + e.toString());
      return <String, dynamic>{"id": null};
    }
  }

  //deprecated
  Future<ApiResult<Hashes>> fetchHash({required String type}) async {
    try {
      final response = await apiClient.get("api/forms/forms/hash/"); //, queryParameters: {"api_key": _apiKey}
      Hashes hash = Hashes.fromJson(response);
      hash.type = type;
      return ApiResult.success(data: hash);
    } catch (e) {
      print("error when processing data response " + e.toString());
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<String?> fetchHashMain() async {
    try {
      Map<String, dynamic> r = await apiClient.get("api/forms/forms/hash/"); //, queryParameters: {"api_key": _apiKey}
      if (r.containsKey("hash")) return r["hash"];
      return null;
    } catch (e) {
      print("error when processing data response " + e.toString());
      return null;
    }
  }

  Future<List<Link>> getLiensUtils() async {
    try {
      List<dynamic> r = await apiClient.get("api/generic/link/");
      return r.map((e) => Link.fromJson(e)).cast<Link>().toList();
    } catch (e) {
      print("error when processing data response " + e.toString());
      return [];
    }
  }

  Future<Hashes?> fetchHashRaw({required String type}) async {
    try {
      final response = await apiClient.get("api/forms/forms/hash/"); //, queryParameters: {"api_key": _apiKey}
      Hashes hash = Hashes.fromJson(response);
      hash.type = type;
      return hash;
    } catch (e) {
      print("error when processing data response " + e.toString());
      return null;
    }
  }

  Future<bool> addFirebaseRegistratioinId(int user, String registrationId) async {
    try {
      await apiClient.post("api/notifications/devices/", data: {
        "name": "",
        "active": true,
        "device_id": "",
        "registration_id": registrationId,
        "type": "android",
        "user": user,
      });
      return true;
    } catch (e) {
      print("error when processing data response " + e.toString());
      return false;
    }
  }

  Future<dynamic> changePassword(String oldPassword, String newPassword, String confirmPassword) async {
    try {
      final response = await apiClient.post("api/accounts/change_password/", data: {
        "old_password": oldPassword,
        "new_password1": newPassword,
        "new_password2": confirmPassword,
      }); //, queryParameters: {"api_key": _apiKey}
      return true;
    } catch (e) {
      print("error when processing data response " + e.toString());
      return e;
    }
  }

  Future<List<UserNotification>> notificationHistory() async {
    bool isConnected = await hasInternetConnection();
    //List<FCMNotification> newFCM = await getDataBase<FCMNotificationsDao>().fetchFCMNotification();
    List<UserNotification> n = await getDataBase<UserNotificationsDao>().fetchUserNotification();
    if (isConnected) {
      //newFCM.length > 0 || n.length <= 0
      try {
        final response = await apiClient.get("api/notifications/message/"); //, queryParameters: {"api_key": _apiKey}
        List<UserNotification> u = NotificationList.fromJson(response).fields.cast<UserNotification>();
        //await getDataBase<UserNotificationsDao>().removeAllUserNotification();

        //await getDataBase<UserNotificationsDao>().fetchUserNotification();
        return await getDataBase<UserNotificationsDao>().insertUserNotificationsIfNotPresent(u);
      } catch (e) {
        print("error when processing data response " + e.toString());
        return [];
      }
    } else {
      return n;
    }
  }

  Future<List<FormFieldsState>> fetchFormState() async {
    try {
      var response = await apiClient.get("api/reclamations/state"); //, queryParameters: {"api_key": _apiKey}
      List<FormFieldsState> states = FormStatesList.fromJson(response).fields.cast<FormFieldsState>();
      await getDataBase<FormStateDao>().setFormmStates(states);
      return states;
      //return //response.map((e) => FormFieldsState.fromJson(e)).toList();
    } catch (e) {
      print("error when processing data response " + e.toString());
      return [];
    }
  }

  Future<ApiResult<List<Reclamations>>> fetchReclamations() async {
    try {
      var response = await apiClient.get("api/reclamations/?current"); //, queryParameters: {"api_key": _apiKey}
      //return ApiResult.success(data: response.map((e) => Reclamations.fromJson(e)).toList());
      List<Reclamations> reclamations = ReclamationsList.fromJson(response).fields.cast<Reclamations>();
      await getDataBase<ReclamationsDao>().setReclamations(reclamations);
      return ApiResult.success(data: reclamations);
    } catch (e) {
      print("error when processing data response " + e.toString());
      List<Reclamations> r = await getDataBase<ReclamationsDao>().fetchReclamationsAll();
      return ApiResult.success(data: r);
      //return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<DecisionResponse?> fetchAlgoResponse(String deviceId) async {
    try {
      var response = await apiClient.get("/api/forms/algorithms/get_by_device_response/$deviceId/"); //, queryParameters: {"api_key": _apiKey}
      if (response != null) {
        if (response.length > 0) return DecisionResponse.fromJson(response[0]);
      }
      return null;
      //return ApiResult.success(data: response.map((e) => Reclamations.fromJson(e)).toList());
      //List<Reclamations> reclamations = ReclamationsList.fromJson(response).fields.cast<Reclamations>();
      //await getDataBase<ReclamationsDao>().setReclamations(reclamations);
      //return ApiResult.success(data: reclamations);
    } catch (e) {
      print("error when processing data response " + e.toString());
      return null;
      //print("error when processing data response " + e.toString());
      //List<Reclamations> r = await getDataBase<ReclamationsDao>().fetchReclamationsAll();
      //return ApiResult.success(data: r);
      //return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<List<Reclamations>?> fetchReclamationsRaw(int type) async {
    try {
      log('reclamation of states $type');
      var response;
      if (type < 0 && type != -3)
        response = await apiClient.get("api/reclamations/?current");
      else if (type == -3) {
        response = [];
      } else {
        response = await apiClient.get("api/reclamations/?state=$type");
      }
      log("response is $response");
      List<Reclamations> reclamations = ReclamationsList.fromJson(response).fields.cast<Reclamations>();
      await getDataBase<ReclamationsDao>().setReclamations(reclamations);

      List<AnswerHolder> h = await getDataBase<AnswerHolderDao>().fetchAnswerHolderWithChildrenAll(type, HOLDER_ANY_COMPLETED, null);

      Map<String, Reclamations> l = {};

      for (var holder in h) {
        if (holder.deviceId == null) continue;
        l[holder.deviceId!] = Reclamations(
            createdAt: holder.createdAt,
            deviceId: holder.deviceId,
            form: holder.formFields?.name,
            formAr: holder.formFields?.nameAr,
            formDescription: holder.formFields?.description,
            formDescriptionAr: holder.formFields?.descriptionAr,
            localAnswerHolder: holder,
            formId: holder.formId,
            formEntry: FormEntry(
              deviceId: holder.deviceId,
              form: holder.formId,
              completedAt: holder.completedAt,
            ));
      }

      for (var rec in reclamations) {
        if (rec.formEntry?.deviceId == null) continue;
        l[rec.formEntry!.deviceId!] = rec;
      }

      return l.values.map((e) => e).toList();
    } catch (e) {
      print("error when processing data response " + e.toString());
      return await getDataBase<ReclamationsDao>().fetchReclamationsAll();
    }
  }

  Future<List<Reclamations>?> getReclamations() async {
    //try {
    var response = await apiClient.get("api/reclamations/?current"); //, queryParameters: {"api_key": _apiKey}
    print("message response is " + response.toString());
    List<Reclamations> reclamations = ReclamationsList.fromJson(response).fields.cast<Reclamations>();
    await getDataBase<ReclamationsDao>().setReclamations(reclamations);
    return reclamations;
    /*} catch (e) {
      print("error when processing data response " + e.toString());
      return [];
    }*/
  }

  Future<List<SocialLinks>> getSocialLinks() async {
    try {
      var response = await apiClient.get("api/generic/socialmedia/"); //, queryParameters: {"api_key": _apiKey}
      print("message response is " + response.toString());
      return SocialLinkList.fromJson(response).fields.cast<SocialLinks>();
    } catch (e) {
      print("error when processing data response " + e.toString());
      return [];
    }
  }

  Future<List<About>> getAbout() async {
    try {
      var response = await apiClient.get("api/generic/about/"); //, queryParameters: {"api_key": _apiKey}
      print("message response is " + response.toString());
      return AboutList.fromJson(response).fields.cast<About>();
    } catch (e) {
      print("error when processing data response " + e.toString());
      return [];
    }
  }

  Future<ApiResult<List<Actualite>>> getActualite() async {
    try {
      final response = await apiClient.get("api/generic/actualities/"); //, queryParameters: {"api_key": _apiKey}
      print("response actualities length $response");
      return ApiResult.success(data: ActualiteList.fromJson(response).fields.cast<Actualite>());
    } catch (e) {
      print("error when processing data response " + e.toString());
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<List<FormFields>>> fetchFormFields() async {
    //try {
    print("trying to get categories ");
    final response = await apiClient.get("api/forms/forms/"); //, queryParameters: {"api_key": _apiKey}

    //List<SuperCategory> catList = SuperCategoriesResponse.fromJson(response).cats.cast<SuperCategory>();
    return ApiResult.success(data: FormFieldsList.fromJson(response).fields.cast<FormFields>());
    /*} catch (e) {
      print("error when processing data response " + e.toString());
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }*/
  }

  Future<List<FormFields>?> fetchFormFieldsRaw() async {
    //try {
    print("trying to get categories ");
    final response = await apiClient.get("api/forms/forms/"); //, queryParameters: {"api_key": _apiKey}

    //List<SuperCategory> catList = SuperCategoriesResponse.fromJson(response).cats.cast<SuperCategory>();
    return FormFieldsList.fromJson(response).fields.cast<FormFields>();
    /*} catch (e) {
      print("error when processing data response " + e.toString());
      return null;
      //return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }*/
  }

  Future<ApiResult<List<CategoryForms>>> fetchCategories() async {
    try {
      print("trying to get categories ");
      final response = await apiClient.get("api/generic/categories/"); //, queryParameters: {"api_key": _apiKey}

      List<CategoryForms> catList = CategoriesResponse.fromJson(response).cats.cast<CategoryForms>();
      return ApiResult.success(data: catList);
    } catch (e) {
      print("error when processing data response " + e.toString());
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  void printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }

  Future<DecisionResponse?> postAnswerHolder(int userId, AnswerHolder answerHolder) async {
    try {
      AnswerPostObject ap = AnswerPostObject(answerHolder, userId);
      Map<String, dynamic> r = await ap.make();
      //printWrapped("trying to post answers ready to post " + ap.make().toString());
      log("trying to post answers ready to post $r");
      final response = await apiClient.post("api/forms/responses/create_response/", data: r); //, queryParameters: {"api_key": _apiKey}
      print("response received " + response.toString());
      return DecisionResponse.fromJson(response);
    } catch (e) {
      return null;
    }
  }

  //deprecated
  Future<ApiResult<int>> currentUser() async {
    try {
      final response = await apiClient.get("api/accounts/current_user/"); //, queryParameters: {"api_key": _apiKey}
      if (response is Map) {
        if (response.containsKey("email")) {
          LocalUser l = LocalUser.fromJson({
            'user': response['id'],
            'username': response['username'],
            'email': response['email'],
          });
          await getDataBase<LocalUserDao>().setLocalUser(l);
        }
      }
      return ApiResult.success(data: response["id"]);
    } catch (e) {
      print("error when processing data response " + e.toString());
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<int> currentUserRaw() async {
    try {
      final response = await apiClient.get("api/accounts/current_user/"); //, queryParameters: {"api_key": _apiKey}
      if (response is Map) {
        if (response.containsKey("email")) {
          LocalUser l = LocalUser.fromJson({
            'user': response['id'],
            'username': response['username'],
            'email': response['email'],
          });
          await getDataBase<LocalUserDao>().setLocalUser(l);
        }
      }
      return response["id"];
    } catch (e) {
      return -1;
    }
  }

  Future<List<Province>> getProvinces() async {
    try {
      final response = await apiClient.get("api/generic/provinces/"); //, queryParameters: {"api_key": _apiKey}
      List<Province> provs = [];
      if (response != null) {
        for (var p in response) {
          provs.add(Province.fromJson(p));
        }
      }
      await getDataBase<ProvincesDao>().setProvinces(provs);
      return provs;
    } catch (e) {
      print("error when processing data response " + e.toString());
      return [];
    }
  }

  Future<bool> setUserProfile(Map<String, dynamic> profile) async {
    try {
      print("sending profile " + profile.toString());
      await apiClient.put("api/accounts/profiles/${profile['user']}/", data: profile); //, queryParameters: {"api_key": _apiKey}
      //print("response received " + response);
      return true;
    } catch (e) {
      print("error when processing data response " + e.toString());
      return false;
    }
  }

  Future<Organisation?> getOrganisation() async {
    try {
      var r = await apiClient.get("api/accounts/organization/get_current_organization/");
      Organisation o = Organisation.fromJson(r);
      await getDataBase<OrganisationDao>().setOrganisation(o);
      return o;
    } catch (e) {
      print("error when processing data response " + e.toString());
      return null;
    }
  }

  Future<Profile?> getProfile(int userId) async {
    try {
      final response = await apiClient.get("api/accounts/profiles/$userId/");
      print("response received " + response.toString());
      return Profile.fromJson(response);
    } catch (e) {
      log("error on profile $e");
      return null;
    }
  }

  Future<List<Disease>> getDiseases() async {
    try {
      final response = await apiClient.get("api/generic/diseases/");
      print("response received " + response.toString());
      List<Disease> diseases = DiseasesList.fromJson(response).fields.cast<Disease>();
      await getDataBase<DiseaseDao>().setDiseases(diseases);
      return diseases;
    } catch (e) {
      return [];
    }
  }

  Future<ResponseForm?> getResponses(String deviceId) async {
    try {
      List<dynamic> response = await apiClient.get("api/forms/form_entries/get_by_device_response/$deviceId/");
      print("response received " + response.toString());
      //await getDataBase<DiseaseDao>().setDiseases(diseases);
      if (response.length > 0) return ResponseForm.fromJson(response[0]);
    } catch (e) {
      log("get responses error $e");
      return null;
    }
  }

  Future<List<BloodGroup>> getBloodGroup() async {
    try {
      final response = await apiClient.get("api/generic/bloodgroup/");
      List<BloodGroup> bg = BloodGroupList.fromJson(response).fields.cast<BloodGroup>();
      print("response received " + response.toString());
      await getDataBase<BloodGroupDao>().setBloodGroup(bg);
      return bg;
    } catch (e) {
      return [];
    }
  }

  //deprecated
  Future<ApiResult<String>> loginUser(LocalUser localUser) async {
    try {
      //api/token-auth/
      final response = await apiClient.post("login/", data: {"username": localUser.username, "password": localUser.password, "organization": "AXA21"}); //, queryParameters: {"api_key": _apiKey}
      //print("response received " + response);
      //UserLogged user = UserLogged.fromJson(response);
      return ApiResult.success(data: response['token']);
    } catch (e) {
      print("error when processing data response " + e.toString());
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<dynamic> loginUserRaw(LocalUser localUser) async {
    try {
      var m = {"username": localUser.username, "password": localUser.password, "organization": localUser.organization};
      print("before login $m");
      final response = await apiClient
          .post("login/", data: {"username": localUser.username, "password": localUser.password, "organization": localUser.organization}); //organization, queryParameters: {"api_key": _apiKey}
      return response['token'] as String;
    } on DioError catch (e) {
      print("error when processing data response ${e.response?.data}");
      return LoginError.fromJson(e.response?.data ?? {}); //e.response?.statusCode ?? 403;
    }
  }

  Future<bool> forgotPassword(String email) async {
    try {
      await apiClient.post("rest-auth/password/reset/", data: {"email": email});
      return true;
    } on DioError catch (e) {
      print("error when processing data response " + e.toString());
      return false;
    }
  }

  Future<Map<String, dynamic>> uploadFile(int questionId, Uint8List file, String? ext, Function(int received, int total) progress, {bool asByte = false, Uint8List? i}) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString() + (ext != null ? ".$ext" : "");
      //late List<int> l;
      print("data 1 ******************");
      /*if (!asByte)
        fileName = file.path.split('/').last;
      else {
        print("data inside ******************");
        l = i!.toList();
      }*/
      print("data 2 ******************");
      FormData formData = FormData.fromMap({
        //"file": asByte ? MultipartFile.fromBytes(file.toList(), filename: fileName) : await MultipartFile.fromFile(file.path, filename: fileName),
        "file": MultipartFile.fromBytes(file.toList(), filename: fileName),
        "question": questionId,
      });

      print("data 3 ******************");
      final response = await apiClient.post("api/forms/responses/upload_file/", data: formData, onSendProgress: progress); //, queryParameters: {"api_key": _apiKey}
      print("response received " + response.toString());
      return response;
    } catch (e) {
      print("error when processing data response " + e.toString());
      return <String, dynamic>{"id": null};
    }
  }

  Future<Map<String, dynamic>> uploadSignature(int questionId, Uint8List file, Function(int received, int total) progress, {bool asByte = false, Uint8List? i}) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString() + ".png";
      late List<int> l = i!.toList();
      FormData formData = FormData.fromMap({
        "file": MultipartFile.fromBytes(l, filename: fileName),
        "question": questionId,
      });

      final response = await apiClient.post("api/forms/responses/upload_signature/", data: formData, onSendProgress: progress); //, queryParameters: {"api_key": _apiKey}
      print("response received " + response.toString());
      return response;
    } catch (e) {
      print("error when processing data response " + e.toString());
      return <String, dynamic>{"id": null};
    }
  }

  Future<Map<String, dynamic>> uploadSound(Question question, File file, Function(int received, int total) progress, {bool asByte = false, Uint8List? i}) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      fileName = file.path.split('/').last;
      print("data 2 ******************");
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(file.path, filename: fileName),
        "question": question.id,
      });

      final response = await apiClient.post("api/forms/responses/upload_sound/", data: formData, onSendProgress: progress);
      return response;
    } catch (e) {
      print("error when processing data response " + e.toString());
      return <String, dynamic>{"id": null};
    }
  }

  Future<Map<String, dynamic>> uploadSoundUInt(Question question, Uint8List file, Function(int received, int total) progress, {bool asByte = false, Uint8List? i}) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString() + ".webm";
      print("data 2 ******************");
      FormData formData = FormData.fromMap({
        "file": MultipartFile.fromBytes(file.toList(), filename: fileName),
        "question": question.id,
      });

      final response = await apiClient.post("api/forms/responses/upload_sound/", data: formData, onSendProgress: progress);
      return response;
    } catch (e) {
      print("error when processing data response " + e.toString());
      return <String, dynamic>{"id": null};
    }
  }
}

class AnswerPostObject {
  AnswerHolder answerHolder;
  int user;

  AnswerPostObject(this.answerHolder, this.user);

  List<double> getLatLng(Answer answer) {
    List<double> ints = [];
    if (answer.multiSelectAnswer != null) {
      for (var item in answer.multiSelectAnswer!) {
        print('geo answer is ' + item.geoHolder.toString());
        ints.add(item.geoHolder!);
      }
    }
    return ints;
  }

  dynamic _formatValue(Answer answer) {
    if (answer.resourcetype == SELECT_RESPONSE) {
      List<int> ints = [];
      if (answer.multiSelectAnswer != null) {
        for (var item in answer.multiSelectAnswer!) {
          ints.add(item.selectedId!);
        }
      }
      return ints;
    } else {
      return answer.answerValue;
    }
  }

  Future<int> uploadSignatureFile(Answer answer) async {
    FileSaver? x = await FileSaver.getBykey(answer.fileKey);
    if (x != null) {
      //getUint8ListFile(answer.valueExtra ?? "");
      print("checking file upload .... ${answer.valueExtra}");
      print("checking file upload f is not null ....");
      ApiRepository apiRepository = ApiRepository();
      Map<String, dynamic> result = await apiRepository.uploadSignature(answer.qustionId!, x.file, (r, t) {
        print("total sending $r | $t ");
      }, asByte: true, i: x.file);
      print("checking file upload .... result $result");
      if (result['id'] != null) {
        print("checking file upload .... result id is not null ${result['id']}");
        return result['id'];
      }
      /*Uint8List? f = x.file; //getUint8ListFile(answer.valueExtra ?? "");
      print("checking file upload .... ${answer.valueExtra}");
      print("checking file upload f is not null ....");
      ApiRepository apiRepository = ApiRepository();
      Map<String, dynamic> result = await apiRepository.uploadSignature(answer.qustionId!, File.fromRawPath(f), (r, t) {
        print("total sending $r | $t ");
      }, asByte: true, i: f);
      print("checking file upload .... result $result");
      if (result['id'] != null) {
        print("checking file upload .... result id is not null ${result['id']}");
        return result['id'];
      }*/
    }
    return -1;
  }

  Future<int> uploadFile(Answer answer) async {
    FileSaver? f = await FileSaver.getBykey(answer.fileKey);
    if (f != null) {
      /*if (f.forceUploadThis == true) {
        File file = File(f.path);
        f.file = await file.readAsBytes();
        f.extension = p.extension(file.path);
        log('forcing local file upload from ${file.path}, with extension ${f.extension}');
      }*/
      ApiRepository apiRepository = ApiRepository();
      Map<String, dynamic> result = await apiRepository.uploadFile(answer.qustionId!, f.file, f.extension, (r, t) {
        print("total sending $r | $t ");
      });
      if (result['id'] != null) {
        return result['id'];
      }
    }
    return -1;
    /*File _image = File(answer.valueExtra ?? "");
    print("checking file upload (uploading file) .... ${answer.valueExtra}");
    if (await _image.exists()) {
      ApiRepository apiRepository = ApiRepository();
      Map<String, dynamic> result = await apiRepository.uploadFile(answer.qustionId!, _image, (r, t) {
        print("total sending $r | $t ");
      });
      if (result['id'] != null) {
        return result['id'];
      }
    }
    return -1;*/
  }

  Future<int> uploadFileSound(Answer answer) async {
    if (!kIsWeb) {
      File f = File(answer.valueExtra!);
      ApiRepository api = ApiRepository();
      Map<String, dynamic> result = await api.uploadSound(answer.question!, f, (received, total) {
        print("progress $received / $total");
      });
      if (result['id'] != null) {
        return result['id'];
      }
    } else {
      FileSaver? f = await FileSaver.getBykey(answer.fileKey);
      if (f != null) {
        ApiRepository apiRepository = ApiRepository();
        Map<String, dynamic> result = await apiRepository.uploadSoundUInt(answer.question!, f.file, (r, t) {
          print("total sending $r | $t ");
        });
        if (result['id'] != null) {
          return result['id'];
        }
      }
      return -1;
    }
    return -1;
  }

  Future<Map<String, dynamic>> make() async {
    List<Map<String, dynamic>> aMap = [];
    if (answerHolder.answers != null) {
      for (var answer in answerHolder.answers!) {
        Map<String, dynamic> m = {
          'question': answer.qustionId,
          'resourcetype': answer.resourcetype,
          //'value': _formatValue(answer),
          //'extra': answer.valueExtra,
        };
        if (answer.resourcetype != GEO_RESPONSE) {
          if (answer.resourcetype == SIGNATURE_RESPONSE) {
            //log("answers in SignResponse ${answer.toJson()}");
            int rId = await uploadSignatureFile(answer);
            print("signature rId is $rId");
            if (rId != -1) {
              answer.answerValue = rId.toString();
              //m['value'] = answer.answerValue;
            }
          } else if (answer.resourcetype == FILE_RESPONSE) {
            int rId = await uploadFile(answer);
            print("file rId is $rId");
            if (rId != -1) {
              answer.answerValue = rId.toString();
              //m['value'] = answer.answerValue;
            }
          } else if (answer.resourcetype == SOUND_RESPONSE) {
            int rId = await uploadFileSound(answer);
            print("sound rId is $rId");
            if (rId != -1) {
              answer.answerValue = rId.toString();
              //m['value'] = answer.answerValue;
            }
          }
          m['value'] = _formatValue(answer);
        } else {
          List<double> latlng = getLatLng(answer);
          if (latlng.length > 0) {
            m['lat'] = latlng[0];
            m['lng'] = latlng[1];
          } else {
            m['lat'] = 0;
            m['lng'] = 0;
          }
        }
        aMap.add(m);
      }
    }
    return <String, dynamic>{
      'form': answerHolder.formId,
      'user': user,
      'completed_at': DateTime.now().toString(), //answerHolder.completedAt,
      'device_id': answerHolder.deviceId,
      'responses': aMap,
    };
  }
}

class FormFieldsList {
  List<FormFields> fields = [];

  FormFieldsList.fromJson(List<dynamic> json) {
    for (var data in json) fields.add(FormFields.fromJson(data));
  }
}

class ActualiteList {
  List<Actualite> fields = [];

  ActualiteList.fromJson(List<dynamic> json) {
    for (var data in json) {
      fields.add(Actualite.fromJson(data));
    }
  }
}

class ReclamationsList {
  List<Reclamations> fields = [];

  ReclamationsList.fromJson(List<dynamic> json) {
    for (var data in json) fields.add(Reclamations.fromJson(data));
  }
}

class SocialLinkList {
  List<SocialLinks> fields = [];
  SocialLinkList.fromJson(List<dynamic> json) {
    for (var data in json) fields.add(SocialLinks.fromJson(data));
  }
}

class AboutList {
  List<About> fields = [];
  AboutList.fromJson(List<dynamic> json) {
    for (var data in json) fields.add(About.fromJson(data));
  }
}

class FormStatesList {
  List<FormFieldsState> fields = [];

  FormStatesList.fromJson(List<dynamic> json) {
    for (var data in json) fields.add(FormFieldsState.fromJson(data));
  }
}

class DiseasesList {
  List<Disease> fields = [];

  DiseasesList.fromJson(List<dynamic> json) {
    for (var data in json) fields.add(Disease.fromJson(data));
  }
}

class BloodGroupList {
  List<BloodGroup> fields = [];

  BloodGroupList.fromJson(List<dynamic> json) {
    for (var data in json) fields.add(BloodGroup.fromJson(data));
  }
}

class NotificationList {
  List<UserNotification> fields = [];

  NotificationList.fromJson(List<dynamic> json) {
    for (var data in json) fields.add(UserNotification.fromJson(data));
  }
}
