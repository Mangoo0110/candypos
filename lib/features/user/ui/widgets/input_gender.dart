import '../../../../core/common/enums/common_enums.dart';
import '../../../../core/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';


class InputGender extends StatefulWidget {
  final Gender? initialGender;
  final Function (Gender? selectedGender) onSelect;
  const InputGender({super.key, required this.initialGender, required this.onSelect});

  @override
  State<InputGender> createState() => _InputGenderState();
}

class _InputGenderState extends State<InputGender> {
  Gender? selectedGender;

  @override
  void initState() {
    // TODO: implement initState
    selectedGender = widget.initialGender;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Gender", style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.context(context).textColor.withOpacity(.6)),),
                        
            //Male selector switch
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  _customSwith(
                    label: 'Male',
                    isTrue: selectedGender == Gender.male, 
                    onTap: (tf){
                      if(selectedGender != Gender.male) {
                        selectedGender = Gender.male;
                        widget.onSelect(Gender.male);
                        setState(() {
                          
                        });
                      }
                    }),
                ],
              ),
            ),

            //Female selector switch
            Row(
              children: [
                _customSwith(
                  label: 'Female',
                  isTrue: selectedGender == Gender.female, 
                  onTap: (tf){
                    if(selectedGender != Gender.female) {
                      selectedGender = Gender.female;
                      widget.onSelect(Gender.female);
                      setState(() {
                        
                      });
                    }
                  }),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _customSwith({required bool isTrue, required Function(bool value) onTap, required String label}) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return InkWell(
          onTap: () {
            onTap(true);
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  color: isTrue ? AppColors.context(context).accentColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(800000000),
                  border: Border.all(color: AppColors.context(context).textColor, width: .5)
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(label, style: Theme.of(context).textTheme.labelLarge,),
              ),
            ],
          ),
        );
      },
    );
  }
}