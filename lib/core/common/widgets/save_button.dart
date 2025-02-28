

import 'package:flutter_animate/flutter_animate.dart';

import '../notifiers/save_status_provider.dart';
import 'package:flutter/material.dart';

import '../enums/common_enums.dart';
import 'ui_button.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/app_sizes.dart';


class SaveButton extends StatefulWidget {
  final SaveStatusNotifier saveStatusNotifier;

  // Callback when user tap on the save button.
  final VoidCallback onSave;

  // Callback when notifier notifies a successful save.
  final VoidCallback onSuccess;

  final VoidCallback? onFailed;

  const SaveButton({super.key, required this.saveStatusNotifier, required this.onSave, this.onFailed, required this.onSuccess});

  @override
  State<SaveButton> createState() => _SaveButtonState();
}

class _SaveButtonState extends State<SaveButton> {

  SaveStatus saveStatus = SaveStatus.canNotSave;


  Color _buttonContainerColor() {
    return saveStatus == SaveStatus.canNotSave ?
      AppColors.context(context).contentBoxGreyColor
      :
      saveStatus == SaveStatus.failed ?
      AppColors.context(context).contentBoxGreyColor
      :
      saveStatus == SaveStatus.success ?
      Colors.greenAccent.shade400
      :
      AppColors.context(context).accentColor;
  }

  Color _buttonBorderColor() {
    return saveStatus == SaveStatus.canNotSave ?
      AppColors.context(context).contentBoxGreyColor
      :
      saveStatus == SaveStatus.failed ?
      AppColors.context(context).errorColor
      :
      AppColors.context(context).accentColor;
  }


  void _notify() {
    if(saveStatus == SaveStatus.success) {
      Future.delayed(Duration(milliseconds: 600)).then((_){
        widget.onSuccess();
      });
    }

    if(saveStatus == SaveStatus.failed && widget.onFailed != null) {
      Future.delayed(Duration(milliseconds: 600)).then((_){
        widget.onFailed!();
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    
    //saveStatus =  context.watch<UserProfileWriteProvider>().saveStatus;

    return LayoutBuilder(
      builder: (context, constraints) {
        return ListenableBuilder(
          listenable: widget.saveStatusNotifier,
          builder: (context, child) {

            saveStatus = widget.saveStatusNotifier.saveStatus;

            _notify();            
            
            return AnimatedContainer(
              duration: Duration(milliseconds: 300),
              // height: 50,
              // width: constraints.maxWidth,
              decoration: BoxDecoration(
                color: _buttonContainerColor(),
                borderRadius: AppSizes.mediumBorderRadius,
                //border: Border.all(color: _buttonBorderColor(), width: 2)
              ),
              child: UiButton(
                borderRadius: AppSizes.mediumBorderRadius,
                tappable: saveStatus == SaveStatus.canSave,
                onTap: () {
                  widget.onSave();
                },
                child: 
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16),
                    child: saveStatus == SaveStatus.canNotSave ?
                    _idle().animate().fadeIn(duration: Duration(milliseconds: 200))
                    :
                    saveStatus == SaveStatus.canSave ?
                    _saveStatus().animate().fadeIn(duration: Duration(milliseconds: 200))
                    :
                    saveStatus == SaveStatus.saving ?
                    _saving().animate().fadeIn(duration: Duration(milliseconds: 200))
                    : 
                    saveStatus == SaveStatus.failed?
                    _error().animate().fadeIn(duration: Duration(milliseconds: 200))
                    :
                    _saved().animate().fadeIn(duration: Duration(milliseconds: 200)),
                  ),
              ),
            );
          }
        );
      },
    );
  }

  Widget _saving() {

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.context(context).accentColor,
            borderRadius: AppSizes.mediumBorderRadius,
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox( height: 25, width: 25, child: CircularProgressIndicator(strokeWidth: 3,)),
                SizedBox(width: 5,),
                Text("Processing", style: Theme.of(context).textTheme.bodyMedium)
              ],
            ),
          )
        );
      },
    );

  }

  Widget _saveStatus() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Icon(Icons.done, color: AppColors.context(context).textColor,);
      },
    );
  }

  Widget _idle() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Icon(Icons.done, color: AppColors.context(context).textGreyColor,);
      },
    );
  }

  Widget _saved() {

    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.done),
            SizedBox(width: 5,),
            Text("Saved", style: Theme.of(context).textTheme.bodyMedium)
          ],
        );
      },
    );
  }

  Widget _error() {

    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error, color: Colors.deepOrange,),
            SizedBox(width: 5,),
            Text("Error", style: Theme.of(context).textTheme.titleMedium?.copyWith(), )
          ],
        );
      },
    );

  }

}

