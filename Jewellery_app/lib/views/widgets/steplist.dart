import 'package:flutter/material.dart';
import 'package:Tiara_by_TJ/model/step.dart';

class StepList extends StatefulWidget {
  final List<ExpansionListItemModel> steps;
  const StepList({super.key, required this.steps});

  @override
  State<StepList> createState() => _StepListState();
}

class _StepListState extends State<StepList> {
  List<ExpansionListItemModel> steps = <ExpansionListItemModel>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    steps = widget.steps;
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      expansionCallback: (panelIndex, isExpanded) {
        if (mounted) {
      setState(() {
          steps[panelIndex].isExpanded = !isExpanded;
        });
        }
      },
      children: steps
          .map<ExpansionPanel>((ExpansionListItemModel expansionListItemModel) {
     
        return ExpansionPanel(
            headerBuilder: (context, isExpanded) {
              return ListTile(
                title: Text(expansionListItemModel.title),
              );
            },
            body: ListTile(
              title: Text(expansionListItemModel.body),
            ),
            isExpanded: expansionListItemModel.isExpanded);
      }).toList(),
    );
  }
}
