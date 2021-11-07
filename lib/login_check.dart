//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/scheduler.dart';
import 'package:rightnow/blocs/current_user_id.dart';
import 'package:rightnow/blocs/hash_bloc.dart';
import 'package:rightnow/events/HashEvent.dart';
import 'package:rightnow/events/RegistrationEvent.dart';
import 'package:rightnow/hash_page.dart';
import 'package:rightnow/models/local_user.dart';
import 'package:rightnow/rest/ApiRepository.dart';
import 'package:rightnow/rest/network_exceptions.dart';
import 'package:rightnow/states/result_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCheck extends StatefulWidget {
  final LocalUser? localUser;

  const LoginCheck({Key? key, this.localUser}) : super(key: key);
  @override
  _LoginCheckState createState() => _LoginCheckState(this.localUser);
}

class _LoginCheckState extends State<LoginCheck> {
  final LocalUser? localUser;

  _LoginCheckState(this.localUser);

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CurrentUserIdBloc>(context).add(RegistrationEvent.getUser());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<CurrentUserIdBloc, ResultState<int>>(
          builder: (BuildContext context, ResultState<int> state) {
            print("current user page state received ... ");
            return state.when(
              loading: () {
                return Center(child: Image.asset("assets/logo.gif", width: 80, height: 80));
              },
              idle: () {
                return Container();
              },
              data: (int? id) {
                print("current user page data loaded ... " + id.toString());
                print("registring user firbase topic user-$id");
                SchedulerBinding.instance!.addPostFrameCallback((_) async {
                  /*FirebaseMessaging.instance.getToken().then((token) async {
                    print("firebase token is $token");
                    if (token != null && id != null) {
                      ApiRepository api = ApiRepository();
                      bool r = await api.addFirebaseRegistratioinId(id, token);
                    }
                  });
                  await FirebaseMessaging.instance.subscribeToTopic('user-$id');*/
                  BlocProvider.of<HashBloc>(context).add(HashEvent.getCategoriesHash());
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HashPage()));
                });
                //redirectToProfilePage(context, getDataBase());
                return Center(child: Image.asset("assets/logo.gif", width: 80, height: 80));
              },
              error: (NetworkExceptions? error) {
                return Text(NetworkExceptions.getErrorMessage(error!));
              },
            );
          },
        ),
      ),
    );
  }

  /*_saveUser(Map<String, dynamic> user) async {
    if (localUser != null) {
      localUser!.user = id;
      await appDatabase!.localUser.setLocalUser(localUser!);
    }
  }*/
}
