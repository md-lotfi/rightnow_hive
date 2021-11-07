import 'package:rightnow/blocs/hash_bloc.dart';
import 'package:rightnow/blocs/set_user_profile_bloc.dart';
import 'package:rightnow/events/HashEvent.dart';
import 'package:rightnow/hash_page.dart';
import 'package:rightnow/models/profile.dart';
import 'package:rightnow/rest/network_exceptions.dart';
import 'package:rightnow/states/result_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UploadProfilePage extends StatefulWidget {
  const UploadProfilePage({Key? key}) : super(key: key);
  @override
  _UploadProfilePageState createState() => _UploadProfilePageState();
}

class _UploadProfilePageState extends State<UploadProfilePage> {
  _UploadProfilePageState();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<SetUserProfileBloc, ResultState<Profile>>(
          builder: (BuildContext context, ResultState<Profile> state) {
            return state.when(
              loading: () {
                return Center(child: CircularProgressIndicator());
              },
              idle: () {
                return Container();
              },
              data: (Profile? profile) {
                SchedulerBinding.instance!.addPostFrameCallback((_) {
                  BlocProvider.of<HashBloc>(context).add(HashEvent.getCategoriesHash());
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HashPage()));
                });
                return Container();
              },
              error: (NetworkExceptions? error) {
                return Center(child: Text(NetworkExceptions.getErrorMessage(error!)));
              },
            );
          },
        ),
      ),
    );
  }
}
