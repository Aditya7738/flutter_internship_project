import 'package:Tiara_by_TJ/views/pages/dashboard_page.dart';
import 'package:Tiara_by_TJ/views/pages/home_screen.dart';
import 'package:Tiara_by_TJ/views/pages/home_screen2.dart';
import 'package:Tiara_by_TJ/views/pages/home_screen3.dart';
import 'package:flutter/material.dart';
import 'package:Tiara_by_TJ/model/choice_model.dart';
import 'package:Tiara_by_TJ/views/widgets/label_widget.dart';

class ChoiceWidget extends StatefulWidget {
  final ChoiceModel choiceModel;
  final bool fromCart;
  final bool? forProfile;
  const ChoiceWidget(
      {super.key,
      required this.choiceModel,
      required this.fromCart,
      this.forProfile});

  @override
  State<ChoiceWidget> createState() => _ChoiceWidgetState();
}

class _ChoiceWidgetState extends State<ChoiceWidget> {
  late ChoiceModel choiceModel;

  late List<String> options;

  late String selectedOption;

  bool fromCart = false;

  bool forProfile = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    choiceModel = widget.choiceModel;
    options = choiceModel.options;
    selectedOption = widget.choiceModel.selectedOption;
    fromCart = widget.fromCart;
    forProfile = widget.forProfile ?? false;
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    print("ddl deviceWidth ${(deviceWidth / 36) +  4}");

    Widget mobileDdl = DropdownButton(
        value: selectedOption,
        icon: const Icon(Icons.keyboard_arrow_down_rounded),
        items: options.map((String option) {
          return DropdownMenuItem(
            value: option,
            child: Text(option),
          );
        }).toList(),
        onChanged: (String? newValue) {
          if (mounted) {
            setState(() {
              selectedOption = newValue!;
            });
          }
        });

    Widget rowddl = Row(
      children: [
        Text(choiceModel.label ?? "",
            style: Theme.of(context).textTheme.headline4),
        const SizedBox(
          width: 10.0,
        ),
        DropdownButton(
            value: selectedOption,
            icon: const Icon(Icons.keyboard_arrow_down_rounded),
            items: options.map((String option) {
              return DropdownMenuItem(
                value: option,
                child: Text(option),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (mounted) {
                setState(() {
                  selectedOption = newValue!;
                });

                switch (newValue) {
                  case "Home screen 1":
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DashboardPage(),
                        ));
                    break;
                  case "Home screen 2":
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen2(),
                        ));
                    break;
                  case "Home screen 3":
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen3(),
                        ));
                    break;
                  default:
                }
              }
            })
      ],
    );

    Widget columnddl = Column(
      children: [
        LabelWidget(
          label: choiceModel.label ?? "",
          fontSize: (deviceWidth / 36) +  4,
        ),
        const SizedBox(
          height: 15.0,
        ),
        DropdownButton(
            value: selectedOption,
            icon: const Icon(Icons.keyboard_arrow_down_rounded),
            items: options.map((String option) {
              return DropdownMenuItem(
                value: option,
                child: Text(option),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (mounted) {
                setState(() {
                  selectedOption = newValue!;
                });
              }
            })
      ],
    );

    if (fromCart) {
      return rowddl;
    } else if (forProfile) {
      return mobileDdl;
    }
    return columnddl;
  }
}
