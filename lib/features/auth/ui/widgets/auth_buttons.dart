

import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/common/enums/common_enums.dart';
import '../../../../core/common/widgets/spaces.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../../../../core/utils/constants/app_sizes.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/func/dekhao.dart';
import '../providers/auth_ui_notifier.dart';


class AuthButtons extends StatefulWidget {
  final AuthUiNotifier authUiNotifier;

  const AuthButtons({super.key, required this.authUiNotifier,});

  @override
  State<AuthButtons> createState() => _AuthButtonsState();
}

class _AuthButtonsState extends State<AuthButtons> {

  SaveStatus saveStatus = SaveStatus.canNotSave;


  Color _buttonContainerColor() {
    return saveStatus == SaveStatus.canNotSave ?
      AppColors.context(context).contentBoxGreyColor
      :
      saveStatus == SaveStatus.failed ?
      Colors.redAccent.shade400
      :
      saveStatus == SaveStatus.success ?
      Colors.greenAccent.shade400
      :
      saveStatus == SaveStatus.saving ?
      AppColors.context(context).accentColor
      :
      AppColors.context(context).accentColor;
  }

  // Color _buttonBorderColor() {
  //   return saveStatus == SaveStatus.canNotSave ?
  //     AppColors.context(context).contentBoxGreyColor
  //     :
  //     saveStatus == SaveStatus.failed ?
  //     AppColors.context(context).errorColor
  //     :
  //     AppColors.context(context).accentColor;
  // }

  late AuthMode authMode;

  final double textButtonHeight = 60, textButtonWidth = 230;
  double animatedWidth = 230;
  late TextStyle? _textStyle;
  final BorderRadius _borderRadius = AppSizes.largeBorderRadius;
  BorderRadius _animatedBorderRadius = AppSizes.largeBorderRadius;

  String currentAuthButtonText = '',
      secondaryAuthButtonText = '', 
      authenticatingText = '', 
      successText = 'WELCOME',
      failedText = 'FAILED';



  @override
  void initState() {
    // TODO: implement initState
    
    authMode = widget.authUiNotifier.mode;
    super.initState();
  } 


  @override
  Widget build(BuildContext context) {
    
    //saveStatus =  context.watch<UserProfileWriteProvider>().saveStatus;
    _textStyle = Theme.of(context).textTheme.titleMedium;

    return LayoutBuilder(
      builder: (context, constraints) {
        return ListenableBuilder(
          listenable: widget.authUiNotifier,
          builder: (context, child) {
            // update saveStatus and authMode
            saveStatus = widget.authUiNotifier.saveStatusNotifier.saveStatus;
            authMode = widget.authUiNotifier.mode;

            if(saveStatus == SaveStatus.saving) {
              animatedWidth = textButtonHeight;
              _animatedBorderRadius = BorderRadius.circular(50000000);
            } else if(saveStatus == SaveStatus.success || saveStatus == SaveStatus.failed) {
              animatedWidth = textButtonHeight + 30;
              _animatedBorderRadius = _borderRadius;
            }else{
              animatedWidth = textButtonWidth;
              _animatedBorderRadius = _borderRadius;
            }

            dekhao("Save buttons $saveStatus, $authMode");            
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  child: SizedBox(
                    height: textButtonHeight,
                    width: textButtonWidth,
                    child: Center(
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        height: textButtonHeight,
                        width: animatedWidth,
                        decoration: BoxDecoration(
                          color: _buttonContainerColor(),
                          borderRadius: _animatedBorderRadius,
                          //border: Border.all(color: _buttonBorderColor(), width: 2)
                        ),
                        child: InkWell(
                          borderRadius: _borderRadius,
                      
                          splashColor: AppColors.context(context).textColor.withOpacity(0.7),
                      
                          onTap: saveStatus == SaveStatus.canSave 
                          ?
                            () async{
                              await widget.authUiNotifier.authenticate();
                            }
                          : null,
                          
                          child: 
                            saveStatus == SaveStatus.canNotSave ?
                            _idle().animate().fadeIn(duration: Duration(milliseconds: 200))
                            :
                            saveStatus == SaveStatus.canSave ?
                            _authenticate().animate().fadeIn(duration: Duration(milliseconds: 200))
                            :
                            saveStatus == SaveStatus.saving ?
                            _authenticating().animate().fadeIn(delay: Duration(milliseconds: 200), duration: Duration(milliseconds: 200))
                            : 
                            saveStatus == SaveStatus.failed?
                            _failed().animate().fadeIn(duration: Duration(milliseconds: 200))
                            :
                            _success().animate().fadeIn(duration: Duration(milliseconds: 200)),
                        ),
                      ),
                    ),
                  ),
                ),

                Spaces().verticalSpace2(),
                

                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  // height: 50,
                  // width: constraints.maxWidth,
                  decoration: BoxDecoration(
                    color: AppColors.context(context).textColor,
                    borderRadius: _borderRadius,
                    //border: Border.all(color: _buttonBorderColor(), width: 2)
                  ),
                  child: InkWell(
                    borderRadius: _borderRadius,
                
                    splashColor: AppColors.context(context).textColor.withOpacity(0.7),
                
                    onTap: () {
                      widget.authUiNotifier.switchAuth();
                    },
                    
                    child: 
                      SizedBox(
                        height: textButtonHeight,
                        width: textButtonWidth,
                        child: Center(
                          child: Text(
                            authMode != AuthMode.login ? AuthMode.login.name.toUpperCase() : AuthMode.signup.name.toUpperCase(), 
                            style: _textStyle?.copyWith(color: AppColors.context(context).contentBoxColor),),
                        ),
                      ),
                  ),
                ),
              ],
            );
          }
        );
      },
    );
  }

  Widget _authenticating() {

    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircularProgressIndicator(strokeWidth: 4, color: AppColors.context(context).textColor,),
        );
      },
    );

  }

  Widget _authenticate() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          height: textButtonHeight,
          width: textButtonWidth,
          child: Center(child: Text(authMode.name.toUpperCase(), style: _textStyle)),
        );
      },
    );
  }

  Widget _idle() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          height: textButtonHeight,
          width: textButtonWidth,
          child: Center(
            child: Text(
              authMode.name.toUpperCase(), 
              style: _textStyle
            )
          )
        );
      },
    );
  }

  Widget _success() {

    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.done, size: AppSizes.largeIconSize, weight: 10,),
          ],
        );
      },
    );
  }

  Widget _failed() {

    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.dangerous, size: AppSizes.largeIconSize, weight: 10,),
          ],
        );
      },
    );

  }

}

