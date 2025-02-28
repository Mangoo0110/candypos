
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/constants/app_colors.dart';
import '../../utils/constants/app_sizes.dart';
import 'text_widgets.dart';

class MmyyyyPicker extends StatefulWidget {
  final DateTime initialDateTime;
  final Function(DateTime pickedDate) onSelect;
  const MmyyyyPicker({super.key, required this.onSelect, required this.initialDateTime});

  @override
  State<MmyyyyPicker> createState() => _MmyyyyPickerState();
}

class _MmyyyyPickerState extends State<MmyyyyPicker> {

  late DateTime selectedDateTime;
  final List<String> monthList = [
    'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December' 
  ];

  final int minYear = 1900;
  final int maxYear = DateTime.now().year + 50;

  @override
  void initState() {
    // TODO: implement initState
    selectedDateTime = widget.initialDateTime;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return AlertDialog(
          elevation: 8,
          shape: RoundedRectangleBorder(side: BorderSide(color: AppColors.context(context).hintColor,), borderRadius: AppSizes.smallBorderRadius),
          //backgroundColor: AppColors.context(context).backgroundColor.withOpacity(.9),
          actions: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextWidgets(context).buttonMedium(buttonText: "Cancel", textColor: AppColors.context(context).hintColor,),
              ),
            ),

            InkWell(
              onTap: () {
                widget.onSelect(selectedDateTime);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextWidgets(context).buttonMedium(buttonText: "Done", textColor: AppColors.context(context).textColor,),
              ),
            ),
          ],
          content: SizedBox(
            height: 200,
            child: CupertinoDatePicker(
              onDateTimeChanged: (value) {
                selectedDateTime = value;
              },
              initialDateTime: widget.initialDateTime,
              itemExtent: 700,
              mode: CupertinoDatePickerMode.monthYear,
                    
              minimumYear: minYear,
              maximumYear: maxYear,
              
                    
            ),
          ),
        );
      }
    );
  }
}