import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/rendering.dart';
import 'package:rightnow/components/common_widgets.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/db/FCMNotificationsDao.dart';
import 'package:rightnow/db/FormStateDao.dart';
import 'package:rightnow/db/LocalUserDao.dart';
import 'package:rightnow/db/ReclamationsDao.dart';
import 'package:rightnow/db/UserNotificationsDao.dart';
import 'package:rightnow/db/blood_group_dao.dart';
import 'package:rightnow/db/disease_dao.dart';
import 'package:rightnow/health_profile_widget.dart';
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
import 'package:rightnow/models/fcm_notification.dart';
import 'package:rightnow/models/form_state.dart';
import 'package:rightnow/models/hash.dart';
import 'package:rightnow/models/local_user.dart';
import 'package:rightnow/models/profile.dart';
import 'package:rightnow/models/province.dart';
import 'package:rightnow/models/reclamations.dart';
import 'package:rightnow/models/social_links.dart';
import 'package:rightnow/models/user_notification.dart';
import 'package:rightnow/rest/ApiClient.dart';
import 'package:rightnow/rest/ApiResult.dart';
import 'package:rightnow/rest/network_exceptions.dart';
import 'package:rightnow/rest_response/categories_response.dart';
import 'package:dio/dio.dart';

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

  Future<Map<String, dynamic>> uploadProfilePicture(File file, Function(int received, int total) progress) async {
    try {
      LocalUser? u = await getDataBase<LocalUserDao>().fetchUser();
      if (u != null) {
        String fileName = file.path.split('/').last;
        FormData formData = FormData.fromMap({"picture": await MultipartFile.fromFile(file.path, filename: fileName), "pk": u.user});

        final response = await apiClient.post("api/accounts/profiles/change_picture/", data: formData, onSendProgress: progress);
        print("response received " + response.toString());
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
    List<FCMNotification> newFCM = await getDataBase<FCMNotificationsDao>().fetchFCMNotification();
    List<UserNotification> n = await getDataBase<UserNotificationsDao>().fetchUserNotification();
    if (newFCM.length <= 0 && n.length <= 0) {
      try {
        final response = await apiClient.get("api/notifications/message/"); //, queryParameters: {"api_key": _apiKey}
        List<UserNotification> u = NotificationList.fromJson(response).fields.cast<UserNotification>();
        //await getDataBase<UserNotificationsDao>().removeAllUserNotification();

        await getDataBase<UserNotificationsDao>().insertUserNotificationsIfNotPresent(u);
        return await getDataBase<UserNotificationsDao>().fetchUserNotification();
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
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<List<Reclamations>?> fetchReclamationsRaw() async {
    try {
      var response = await apiClient.get("api/reclamations/?current");
      List<Reclamations> reclamations = ReclamationsList.fromJson(response).fields.cast<Reclamations>();
      await getDataBase<ReclamationsDao>().setReclamations(reclamations);
      return reclamations;
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
      //print("response actualities length ${response.length}");
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

  Future<ApiResult<List<Province>>> getProvinces() async {
    try {
      final response = await apiClient.get("api/generic/provinces/"); //, queryParameters: {"api_key": _apiKey}
      List<Province> provs = [];
      if (response != null) {
        for (var p in response) {
          provs.add(Province.fromJson(p));
        }
      }
      return ApiResult.success(data: provs);
    } catch (e) {
      print("error when processing data response " + e.toString());
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<bool> setUserHealth(HealthObject healthObject) async {
    try {
      LocalUser? l = await getDataBase<LocalUserDao>().fetchUser();
      if (l != null) {
        Map<String, dynamic> h = {
          "user": l.user,
          "updated_mobile": true,
          "vaccination": healthObject.vaccinated,
          "vaccin_dose": healthObject.dose,
          "is_smoker": healthObject.smoker,
          "is_pregnant": healthObject.pregnant,
          "blood_group": healthObject.groupSanguin,
          "diseases": healthObject.diseases,
          "height": healthObject.height,
          "weight": healthObject.weight,
          "IMC": healthObject.imc,
        };
        print("sending profile " + h.toString());
        await apiClient.put("api/accounts/profiles/${l.user}/", data: h); //, queryParameters: {"api_key": _apiKey}
        //print("response received " + response);
        return true;
      }
      return false;
    } catch (e) {
      print("error when processing data response " + e.toString());
      return false;
    }
  }

  Future<Profile?> getProfile(int userId) async {
    try {
      final response = await apiClient.get("api/accounts/profiles/$userId/");
      print("response received " + response.toString());
      return Profile.fromJson(response);
    } catch (e) {
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
      print("error when processing data response " + e.toString());
      return e.response?.statusCode ?? 403;
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

  Future<Map<String, dynamic>> uploadFile(int questionId, File file, Function(int received, int total) progress, {bool asByte = false, Uint8List? i}) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      late List<int> l;
      print("data 1 ******************");
      if (!asByte)
        fileName = file.path.split('/').last;
      else {
        print("data inside ******************");
        l = i!.toList();
      }
      print("data 2 ******************");
      FormData formData = FormData.fromMap({
        "file": asByte ? MultipartFile.fromBytes(l, filename: fileName) : await MultipartFile.fromFile(file.path, filename: fileName),
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

  Future<Map<String, dynamic>> uploadSignature(int questionId, File file, Function(int received, int total) progress, {bool asByte = false, Uint8List? i}) async {
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
    Uint8List? f = await getUint8ListFile(answer.valueExtra ?? "");
    print("checking file upload .... ${answer.valueExtra}");
    if (f != null) {
      print("checking file upload f is not null ....");
      ApiRepository apiRepository = ApiRepository();
      Map<String, dynamic> result = await apiRepository.uploadSignature(answer.qustionId!, File.fromRawPath(f), (r, t) {
        print("total sending $r | $t ");
      }, asByte: true, i: f);
      print("checking file upload .... result $result");
      if (result['id'] != null) {
        print("checking file upload .... result id is not null ${result['id']}");
        return result['id'];
      }
    }
    return -1;
  }

  Future<int> uploadFile(Answer answer) async {
    File _image = File(answer.valueExtra ?? "");
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
    return -1;
  }

  Future<int> uploadFileSound(Answer answer) async {
    File f = File(answer.valueExtra!);
    ApiRepository api = ApiRepository();
    Map<String, dynamic> result = await api.uploadSound(answer.question!, f, (received, total) {
      print("progress $received / $total");
    });
    if (result['id'] != null) {
      return result['id'];
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
