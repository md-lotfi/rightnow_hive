import 'package:flutter/material.dart';

import 'package:rightnow/chronique_diseases_screen.dart';
import 'package:rightnow/models/disease.dart';

class PillsWidget extends StatefulWidget {
  final List<Disease>? defaultDiseases;
  final Function(List<Disease> diseases) onChange;
  const PillsWidget({
    Key? key,
    this.defaultDiseases,
    required this.onChange,
  }) : super(key: key);

  @override
  _PillsWidgetState createState() => _PillsWidgetState();
}

class _PillsWidgetState extends State<PillsWidget> {
  List<Disease> _diseases = [];

  @override
  void initState() {
    _diseases = widget.defaultDiseases ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChroniqueDeseasesPage(
              defaultDiseases: _diseases,
            ),
          ),
        ).then((value) {
          if (value != null) {
            setState(() {
              _diseases = value;
            });
            widget.onChange(_diseases);
          }
        });
      },
      child: Wrap(
        alignment: WrapAlignment.start,
        spacing: 10,
        children: [
          for (var i = 0; i < _diseases.length; i++)
            Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(5),
              ),
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
              child: Text(
                _diseases[i].name ?? "",
                style: TextStyle(color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}

/*class WrapBuilder extends StatelessWidget {
  final int itemCount;
  final Widget Function(BuildContext context, int index) builder;
  const WrapBuilder({Key? key, required this.itemCount, required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 10,
      children: [
        for (var i = 0; i < itemCount; i++) builder(context, i),
        /*Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(5),
            ),
            padding: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
            child: Text(
              "Diabète",
              style: TextStyle(color: Colors.white),
            ),
          )*/
      ],
    );
  }
}*/
