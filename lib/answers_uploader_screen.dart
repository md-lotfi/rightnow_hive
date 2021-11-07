import 'package:rightnow/blocs/answers_post_bloc.dart';
import 'package:rightnow/events/AnswersEvent.dart';
import 'package:rightnow/history_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rightnow/home_screen.dart';
import 'package:rightnow/rest/network_exceptions.dart';
import 'package:rightnow/screen_viewer.dart';
import 'package:rightnow/states/result_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnswersUploaderPage extends StatefulWidget {
  final String? redirect;

  const AnswersUploaderPage({Key? key, this.redirect}) : super(key: key);
  @override
  _AnswersUploaderPageState createState() => _AnswersUploaderPageState(this.redirect);
}

class _AnswersUploaderPageState extends State<AnswersUploaderPage> {
  final String? redirect;

  _AnswersUploaderPageState(this.redirect);

  @override
  void initState() {
    super.initState();

    BlocProvider.of<AnswersPostBloc>(context).add(AnswersEvent.uploadAnswerHolder());
  }

  @override
  Widget build(BuildContext context) {
    return ScreenViewerWidget(
        page: SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            children: [
              BlocBuilder<AnswersPostBloc, ResultState<void>>(
                builder: (BuildContext context, ResultState<void> state) {
                  return state.when(
                    loading: () {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text(
                                'Synchronisation avec le serveur.\nPatientez SVP ...'.tr(),
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    idle: () {
                      _redirect();
                      return Container();
                    },
                    data: (dynamic data) {
                      print("data is " + data.toString());
                      _redirect();
                      return Container(
                        child: Center(
                          child: Text(
                            "Patientez SVP ...".tr(),
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                          ),
                        ),
                      ); //dataWidget(data);
                    },
                    error: (NetworkExceptions? error) {
                      //print("error uploading data to server " + NetworkExceptions.getErrorMessage(error!));
                      return error!.maybeWhen(
                        unauthorisedRequest: (response) {
                          if (response != null) {
                            print("response is " + response.data.toString());
                            return Center(
                              child: Container(
                                child: Text("Une erreur est survenue lors de l'envoie d'un formulaire".tr()),
                              ),
                            );
                          } else {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    NetworkExceptions.getErrorMessage(error),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                        orElse: () {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  NetworkExceptions.getErrorMessage(error),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }

  _redirect() {
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      if (redirect == null)
        Navigator.pop(context);
      else if (redirect == "homepage") {
        print("redirecting to super home page");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => HistoryPage(
                  //currentFormHash: currentHash,
                  )),
        );
      }
    });
  }
}
