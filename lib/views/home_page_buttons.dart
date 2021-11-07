import 'package:rightnow/models/home_buttons.dart';
import 'package:flutter/material.dart';

class HomePageButtonsWidgets extends StatefulWidget {
  const HomePageButtonsWidgets({Key? key}) : super(key: key);
  @override
  _HomePageButtonsWidgetsState createState() => _HomePageButtonsWidgetsState();
}

class _HomePageButtonsWidgetsState extends State<HomePageButtonsWidgets> {
  _HomePageButtonsWidgetsState();
  @override
  Widget build(BuildContext context) {
    print("start home page get buttons ........");
    //getHomeButtoons();
    return Container();
  }

  Widget _tempButton(HomeButtons homeButtons) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: TextButton(
            onPressed: () {
              /*Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CategoriesPage(
                            homeButton: homeButtons,
                            appDatabase: appDatabase!,
                          )));*/
            },
            child: Text(homeButtons.title ?? "")),
      ),
    );
  }
}
