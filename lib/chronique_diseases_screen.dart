import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rightnow/components/tile_checkbox_widget.dart';
import 'package:rightnow/constants/constants.dart';
import 'package:rightnow/db/disease_dao.dart';
import 'package:rightnow/models/disease.dart';
import 'package:collection/collection.dart';
import 'package:rightnow/screen_viewer.dart';

class ChroniqueDeseasesPage extends StatefulWidget {
  final List<Disease> defaultDiseases;
  //final Function(List<Disease> data) onSelected;
  const ChroniqueDeseasesPage({Key? key, required this.defaultDiseases}) : super(key: key);

  @override
  _ChroniqueDeseasesPageState createState() => _ChroniqueDeseasesPageState();
}

class _ChroniqueDeseasesPageState extends State<ChroniqueDeseasesPage> {
  List<Disease?> _index = [];
  @override
  Widget build(BuildContext context) {
    _index = widget.defaultDiseases;
    return ScreenViewerWidget(
        page: Scaffold(
      appBar: AppBar(
        title: Text('Maladies chroniques'.tr()),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: FutureBuilder<List<Disease>>(
        future: getDataBase<DiseaseDao>().fetchDisease(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data != null) {
              return Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 70,
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        Disease d = snapshot.data![index];
                        var _selected = _index.firstWhereOrNull(
                              (element) => element?.id == d.id,
                            ) !=
                            null;
                        print("_index list _selected $_index");
                        return TileCheckBoxWidget(
                          defaultSelected: _selected,
                          title: d.name ?? "",
                          onChange: (value) {
                            print("selected now");
                            if (value) {
                              if (_index.firstWhereOrNull(
                                    (element) => element?.id == d.id,
                                  ) ==
                                  null) {
                                _index.add(d);
                                return;
                              }
                            }
                            print("removing $d");
                            _index.removeWhere((element) => element?.id == d.id);
                            print("removed now $_index");
                          },
                        );
                      },
                    ),
                  ),
                  Positioned(
                      bottom: 20,
                      left: 0,
                      right: 0,
                      child: Container(
                        margin: EdgeInsets.only(left: 25, right: 25),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context, _index);
                            //if (snapshot.data != null) widget.onSelected(snapshot.data!);
                          },
                          child: Text("Ok".tr()),
                        ),
                      )),
                ],
              );
            }
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    ));
  }
}
