
import 'package:flutter/material.dart';
import 'package:jwelery_app/model/choice_model.dart';
import 'package:jwelery_app/views/widgets/label_widget.dart';

class ChoiceWidget extends StatefulWidget {
  final ChoiceModel choiceModel;
  final bool fromCart;
  final bool? forProfile;
  const ChoiceWidget({super.key, required this.choiceModel, required this.fromCart, this.forProfile});

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
    selectedOption = options[0];
    fromCart = widget.fromCart;
    forProfile = widget.forProfile ?? false;

  }

  
  
  @override
  Widget build(BuildContext context) {

    Widget mobileDdl = DropdownButton(
          value: selectedOption,
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          items: options.map((String option){
            return DropdownMenuItem(
              value: option,
              child: Text(option),
              );
          }).toList(), 
          onChanged: (String? newValue){
            setState(() {
              selectedOption = newValue!;
            });
          });

    Widget rowddl = Row(
      children: [

        LabelWidget(label: choiceModel.label ?? "", fontSize: 16.0,),
        const SizedBox(width: 10.0,),
        DropdownButton(
          value: selectedOption,
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          items: options.map((String option){
            return DropdownMenuItem(
              value: option,
              child: Text(option),
              );
          }).toList(), 
          onChanged: (String? newValue){
            setState(() {
              selectedOption = newValue!;
            });
          })
      ],
    );

    Widget columnddl = Column(
      children: [
        LabelWidget(label: choiceModel.label ?? "", fontSize: 16.0,),
        const SizedBox(height: 15.0,),
        DropdownButton(
          value: selectedOption,
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          items: options.map((String option){
            return DropdownMenuItem(
              value: option,
              child: Text(option),
              );
          }).toList(), 
          onChanged: (String? newValue){
            setState(() {
              selectedOption = newValue!;
            });
          })
      ],
    ); 

    if(fromCart){
      return rowddl;
    }else if(forProfile){
      return mobileDdl;
    }
      return columnddl;
    
       
  
     
  }
}