
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';


import '../../../../core/common/textfields/email_textfield.dart';
import '../../../../core/common/textfields/password_textfield.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../providers/auth_ui_notifier.dart';



class RegisterUi extends StatefulWidget {
  final AuthUiNotifier authUiNotifier;
  const RegisterUi({super.key, required this.authUiNotifier});

  @override
  State<RegisterUi> createState() => _RegisterUiState();
}

class _RegisterUiState extends State<RegisterUi> {

  bool canOnboard = false;
  final GlobalKey<FormState>  _registerFormKey = GlobalKey<FormState>();

  final TextEditingController _userEmailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmPasswordController = TextEditingController();

    Uint8List? _pickedImage;

  final TextEditingController _nameController = TextEditingController();
  
  final FocusNode _nameFocus = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder:(context, constraints) => Center(
        child: Form(
          key: _registerFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
                  
              Container(
                height: 75,
                width: min(550, constraints.maxWidth),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10)
                ),
                child: EmailTextfield(
                  maxLines: 1,
                  controller: _userEmailController,
                  hintText: "your@example.com",
                  labelText: "Email",
                  onChanged: (value) {
                    widget.authUiNotifier.email = value;
                  },
                  validationCheck: (text) {
                    return RegExp(
                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                    ).hasMatch(text) ? null : 'Not a valid email';
                    
                  },
              )),
              
              const SizedBox(height: 0),
          
              Container(
                height: 75,
                width: min(550, constraints.maxWidth),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10)
                ),
                child: PasswordTextfield(
                  maxLines: 1,
                  controller: _passwordController,
                  hintText: "453dftaker44@",
                  labelText: "Password",
                  onChanged: (value) {
                   widget.authUiNotifier.password = value;
                  },
                  validationCheck: (text) {
                    return RegExp(
                      r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$',
                    ).hasMatch(text) ? null : 'At least 8 characters and one special character.';
                  },
                ),
              ),
              
              const SizedBox(height: 0),
          
              Container(
                height: 75,
                width: min(550, constraints.maxWidth),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10)
                ),
                child: PasswordTextfield(
                  maxLines: 1,
                  controller: _confirmPasswordController,
                  hintText: "453dftaker44@",
                  labelText: "Confirm password",
                  onChanged: (value) {
                    widget.authUiNotifier.confirmPassword = value;
                  },
                  validationCheck: (text) {
                    return RegExp(
                      r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$',
                    ).hasMatch(text) ? null : 'At least 8 characters and one special character.';
                  },
                ),
              ),
          
              const SizedBox(height: 0),
            ],
          ),
        ),
      ),
    );
  }
  

}