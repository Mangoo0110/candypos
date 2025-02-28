

import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import '../widgets/auth_buttons.dart';
import 'login_ui.dart';
import 'register_ui.dart';

import '../../../../core/common/widgets/animated_app_title.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../providers/auth_ui_notifier.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/user_auth.dart';


class AuthUi extends StatefulWidget {
  final void Function(UserAuth auth) onLogIn;

  const AuthUi({super.key, required this.onLogIn});

  @override
  State<AuthUi> createState() => _AuthUiState();
}

class _AuthUiState extends State<AuthUi> {

  
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

    // return LayoutBuilder(
    //   builder:(context, constraints) {
    //     return Scaffold(
    //     );
    //   },
    // );

    return ChangeNotifierProvider<AuthUiNotifier>(
      create: (context) => AuthUiNotifier(),
      child: LayoutBuilder(
        builder:(context,constraints) => Scaffold(
          backgroundColor: AppColors.context(context).backgroundColor,
          body: SingleChildScrollView(
            //keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 200),
        
                Center(child: const AnimatedAppTitle()),
        
                const SizedBox(height: 60),
                
                AuthPage(authUiNotifier: context.read<AuthUiNotifier>(),
                                ),
          
                Center(child: AuthButtons(authUiNotifier: context.read<AuthUiNotifier>()))
                
              ],
            ),
          ),
        ),
      ),
    );
  }

  
}


class AuthPage extends StatefulWidget {
  final AuthUiNotifier authUiNotifier;
  const AuthPage({super.key, required this.authUiNotifier});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  @override
  void initState() {
    // TODO: implement initState
    _currentMode = widget.authUiNotifier.mode;
    super.initState();
  }

  late AuthMode _currentMode ;

  _watchAuthUiChange() {
    final listener = widget.authUiNotifier.addListener((){
      if(widget.authUiNotifier.mode != _currentMode) {
        _currentMode = widget.authUiNotifier.mode;
        setState(() {
          
        });
      }
    });
  }

  @override
  void didChangeDependencies() {
    _watchAuthUiChange();
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: (_currentMode == AuthMode.login 
        ? LoginUi(authUiNotifier: widget.authUiNotifier,) 
        : RegisterUi(authUiNotifier: widget.authUiNotifier)
      ).animate().fadeIn(delay: Duration(milliseconds: 300), duration: Duration(milliseconds: 300)),
    );
  }
}