import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:rightnow/components/combobox_widget.dart';
import 'package:rightnow/components/common_widgets.dart';

class HealthVaccinatedWidget extends StatefulWidget {
  final bool? defaultVaccinated;
  final int? defaultDose;
  final Function(bool vaccinated) onVaccinated;
  final Function(int dose) onDose;
  const HealthVaccinatedWidget({
    Key? key,
    this.defaultVaccinated,
    this.defaultDose,
    required this.onVaccinated,
    required this.onDose,
  }) : super(key: key);

  @override
  _HealthVaccinatedWidgetState createState() => _HealthVaccinatedWidgetState();
}

class _HealthVaccinatedWidgetState extends State<HealthVaccinatedWidget> {
  bool _vaccinated = false;
  int _dose = 1;

  @override
  void initState() {
    _vaccinated = widget.defaultVaccinated ?? false;
    _dose = widget.defaultDose ?? 1;
    print("default dose before is $_dose");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("default dose after is $_dose");
    return Column(
      children: [
        fieldTitle(context, "Vaccination contre la Covid-19".tr()),
        Container(
          child: ComboField<bool>(
            displayValues: ["Oui".tr(), "Non".tr()],
            values: [true, false],
            resultValue: _vaccinated,
            valueBuilder: (value) {
              return value ? Text("Oui".tr()) : Text("Non".tr());
            },
            onResult: (bool r) {
              setState(() {
                _vaccinated = r;
                widget.onVaccinated(r);
              });
            },
          ),
        ),
        SizedBox(
          height: 20,
        ),
        if (_vaccinated) ...[
          fieldTitle(context, "Si oui, combien de doses avez-vous reçu?".tr()),
          Container(
            child: ComboField<int>(
              displayValues: ["1", "2", "3"],
              values: [1, 2, 3],
              resultValue: _dose,
              valueBuilder: (value) {
                return Text(value.toString());
              },
              onResult: (int r) {
                _dose = r;
                widget.onDose(r);
              },
            ),
          ),
        ],
      ],
    );
  }
}
