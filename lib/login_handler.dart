import 'package:rightnow/blocs/login_bloc.dart';
import 'package:rightnow/events/RegistrationEvent.dart';
import 'package:rightnow/login_check.dart';
import 'package:rightnow/models/local_user.dart';
import 'package:rightnow/rest/network_exceptions.dart';
import 'package:rightnow/states/result_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

class LoginHadlerPage extends StatefulWidget {
  final LocalUser? localUser;

  const LoginHadlerPage({Key? key, this.localUser}) : super(key: key);
  @override
  _LoginHadlerPageState createState() => _LoginHadlerPageState(localUser);
}

class _LoginHadlerPageState extends State<LoginHadlerPage> {
  final LocalUser? localUser;

  _LoginHadlerPageState(this.localUser);

  @override
  void initState() {
    if (localUser != null) {
      BlocProvider.of<LoginBloc>(context).add(RegistrationEvent.loginUser(localUser!));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: BlocBuilder<LoginBloc, ResultState<String>>(
            builder: (BuildContext context, ResultState<String> state) {
              return state.when(
                loading: () {
                  return Container(); //Center(child: Image.asset("assets/logo.gif", width: 80, height: 80));
                },
                idle: () {
                  return Container();
                },
                data: (String? data) {
                  SchedulerBinding.instance!.addPostFrameCallback((_) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginCheck(
                                  localUser: localUser!,
                                )));
                  });
                  return Container();
                  //return Center(child: Image.asset("assets/logo.gif", width: 80, height: 80));
                  /*return Container(
                  child: Center(
                    child: Text(
                      "Patientez SVP ...".tr(),
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                  ),
                );*/ //dataWidget(data);
                },
                error: (NetworkExceptions? error) {
                  error?.maybeWhen(
                    unauthorisedRequest: (response) {
                      SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
                        Navigator.pop(context, 403);
                      });
                      return Center(
                        child: Text("Username or password not found"),
                      );
                    },
                    orElse: () {
                      return Center(
                        child: Text(NetworkExceptions.getErrorMessage(error)),
                      );
                    },
                  );
                  return Center(
                    child: Text(NetworkExceptions.getErrorMessage(error!)),
                  );
                },
              );
            },
          ),
        ),
      ),
      fit: BoxFit.fill,
    );
  }
}
