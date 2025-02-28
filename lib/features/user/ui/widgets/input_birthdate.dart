import '../../../../core/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/func/dekhao.dart';


class InputBirthdate extends StatefulWidget {
  final DateTime? initialBirthdate;

  /// Return the same selected date if the selected date is applicable. Otherwise return whatever was previous.
  final DateTime? Function (DateTime selectedDate) onSelect;
  const InputBirthdate({super.key, required this.initialBirthdate, required this.onSelect});

  @override
  State<InputBirthdate> createState() => _InputBirthdateState();
}

class _InputBirthdateState extends State<InputBirthdate> {
  DateTime? selectedBirthdate;
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState

    dekhao("InputBirthdate initialize ${selectedBirthdate.toString()}");
    selectedBirthdate = widget.initialBirthdate;
    if(selectedBirthdate != null) _controller.text = DateFormat.yMMMMd().format(selectedBirthdate!);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    _focusNode.dispose();
    selectedBirthdate = null;
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Date of birth", style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.context(context).textColor.withOpacity(.6)),),
            
            const SizedBox(height: 8,),
            
            //Birth date
            SizedBox(
              height: 70,
              width: constraints.maxWidth,
              child: TextField(
                controller: _controller,
                onTapOutside: (event) {
                  _focusNode.unfocus();
                },
                focusNode: _focusNode, 
                
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(right: 4, bottom: 6, top: 6),
                  suffixIcon: InkWell(
                    onTap: () async{
                      await showDatePicker(
                        context: context, 
                        initialDate: selectedBirthdate,
                        firstDate: DateTime(1900), 
                        lastDate: DateTime(2050),
                      ).then((date){
                        if(date != null) {
                          selectedBirthdate = widget.onSelect(date);
                          _controller.text = DateFormat.yMMMMd().format(selectedBirthdate!);
                          if(mounted) {
                            setState(() {
                              
                          });
                          }
                        }
                      });
                      // CalendarDatePicker(
                      //   initialDate: widget.initialBirthdate, 
                      //   firstDate: DateTime(1900), 
                      //   lastDate: DateTime(2050), 
                      //   onDateChanged: (selectedDate){
                      //     widget.onSelect(selectedDate);
                      //   });
                    },
                    
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Icon(Icons.calendar_month, color: AppColors.context(context).textColor,),
                    ),
                  ),
                  alignLabelWithHint: true,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: "Select by tapping the icon",
                  // enabledBorder: const UnderlineInputBorder(),
                  // focusedBorder: const UnderlineInputBorder(),
                  // border: const UnderlineInputBorder(),
                  // disabledBorder: const UnderlineInputBorder()
                ),
              ),
            ),
            
          ],
        );
      },
    );
  }
}
