

import 'package:candypos/core/utils/func/dekhao.dart';
import 'package:candypos/features/inventory/item/ui/notifiers/edit_item_notifier.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import '../../../../../core/common/enums/common_enums.dart';
import '../../../../../core/common/widgets/ui_button.dart';
import '../../../../../core/utils/constants/app_colors.dart';
import '../../../../../core/utils/constants/app_sizes.dart';
import '../../../../../core/common/notifiers/save_status_provider.dart';
import 'package:flutter/material.dart';


class ItemSaveButton extends StatefulWidget {
  final SaveStatusNotifier saveStatusNotifier;

  // Callback when user tap on the save button.
  final VoidCallback onSave;

  // Callback when notifier notifies a successful save.
  final VoidCallback onSuccess;

  final VoidCallback? onFailed;

  const ItemSaveButton({super.key, required this.saveStatusNotifier, required this.onSave, this.onFailed, required this.onSuccess});

  @override
  State<ItemSaveButton> createState() => _ItemSaveButtonState();
}

class _ItemSaveButtonState extends State<ItemSaveButton> {

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
      Future.delayed(Duration(milliseconds: 900)).then((_){
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

            dekhao("saveStatus = ${saveStatus.name}");
            
            _notify();            
            
            return AnimatedContainer(
              duration: Duration(milliseconds: 300),
              // height: 50,
              // width: constraints.maxWidth,
              decoration: BoxDecoration(
                //color: _buttonContainerColor(),
                borderRadius: AppSizes.maxCircularRadius,
                //border: Border.all(color: _buttonBorderColor(), width: 2)
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: AppSizes.maxCircularRadius,
                  splashColor: AppColors.context(context).textColor.withOpacity(0.7),
                
                  onTap: saveStatus == SaveStatus.canSave
                  ? () {
                    Future.delayed(const Duration(milliseconds: 350)).then((_) async{
                      widget.onSave();
                    });
                  }
                  : null,
                
                  child: 
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20),
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
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox( height: 25, width: 25, child: CircularProgressIndicator(strokeWidth: 3,)),
              SizedBox(width: 5,),
              Text("Processing", style: Theme.of(context).textTheme.bodyMedium)
            ],
          ),
        );
      },
    );

  }

  Widget _saveStatus() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Icon(Icons.done, weight: 30, size: AppSizes.largeIconSize, color: AppColors.context(context).accentColor,);
      },
    );
  }

  Widget _idle() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Icon(Icons.done, weight: 30, size: AppSizes.largeIconSize, color: AppColors.context(context).textGreyColor,);
      },
    );
  }

  Widget _saved() {

    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.done, color: _buttonContainerColor(),),
            SizedBox(width: 5,),
            Text("Saved", style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: _buttonContainerColor()))
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

