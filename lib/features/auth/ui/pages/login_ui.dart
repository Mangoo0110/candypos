import 'dart:math';



import 'package:flutter/material.dart';

import '../../../../core/common/textfields/email_textfield.dart';
import '../../../../core/common/textfields/password_textfield.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../providers/auth_ui_notifier.dart';


class LoginUi extends StatefulWidget {
  final AuthUiNotifier authUiNotifier;
  const LoginUi({super.key, required this.authUiNotifier});

  @override
  State<LoginUi> createState() => _LoginUiState();
}

class _LoginUiState extends State<LoginUi> {

  final _logInFormKey = GlobalKey<FormState>();

  final TextEditingController _userEmailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  //final TextEditingController _confirmPasswordController = TextEditingController();

  // focusnodes
  // late FocusNode _emailFocusNode, _passwordFocusNode, _confirmPasswordFocusNode;

  @override
  void initState() {
    // TODO: implement initState
    // _emailFocusNode = FocusNode();
    // _passwordFocusNode = FocusNode();
    // _confirmPasswordFocusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder:(context,constraints) => Form(
        key: _logInFormKey,
        child: Column(
          //mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
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
          
            const SizedBox(height: 12),
          
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
                  return null;
                },
              ),
            ),
          
            const SizedBox(height: 0),
          ],
        ),
      ),
    );
  }
  
}