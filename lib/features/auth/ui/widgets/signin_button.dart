
// import 'package:flutter/material.dart';
// import '../../../../core/common/enums/common_enums.dart';
// import 'package:provider/provider.dart';
// import '../../../../core/common/widgets/ui_button.dart';
// import '../../../../core/utils/constants/app_colors.dart';

// import '../../../../core/utils/constants/app_sizes.dart';
// import '../providers/signin_provider.dart';
// class SignInButton extends StatefulWidget {
//   const SignInButton({super.key});

//   @override
//   State<SignInButton> createState() => _SignInButtonState();
// }

// class _SignInButtonState extends State<SignInButton> {

//   // void _watchModifyStatus(){
//   //   saveStatus = context.watch<ModifyPlayerStateProvider>().saveStatus;
//   //   deleteStatus = context.watch<ModifyPlayerStateProvider>().deleteStatus;
//   //   if(saveStatus == SaveStatus.saved || deleteStatus == DeleteStatus.deleted){
//   //     Future.delayed(Duration(seconds: 1), (){
//   //       if(mounted) Navigator.pop(context);
//   //     });
//   //   }
//   // }



//   Color _buttonContainerColor() {
//     return Colors.transparent;
//   }

//   Color _buttonBorderColor() {
//     return saveStatus == SaveStatus.canNotSave ?
//       AppColors.context(context).contentBoxGreyColor
//       :
//       saveStatus == SaveStatus.failed ?
//       AppColors.context(context).errorColor
//       :
//       AppColors.context(context).accentColor;
//   }

//   @override
//   void didChangeDependencies() {
//     // TODO: implement didChangeDependencies
//     //_watchModifyStatus();
//     super.didChangeDependencies();
//   }

//   @override
//   Widget build(BuildContext context) {
//     //dekhao(saveStatus.name.toString());
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return AnimatedContainer(
//           duration: Duration(milliseconds: 300),
//           height: 55,
//           width: constraints.maxWidth,
//           decoration: BoxDecoration(
//             color: _buttonContainerColor(),
//             borderRadius: AppSizes.largeBorderRadius,
//             border: Border.all(color: _buttonBorderColor(), width: 2)
//           ),
//           child: UiButton(
//             borderRadius: AppSizes.largeBorderRadius,
//             tappable: saveStatus == SaveStatus.canSave,
//             onTap: () {
//               context.read<SigninProvider>().loginBang(
//                 onDone: () {
                  
//                 },
//               );
//             },
//             child: 
//               Center(
//                 child: saveStatus == SaveStatus.canNotSave ?
//                 _idle()
//                 :
//                 saveStatus == SaveStatus.canSave ?
//                 _saveStatus()
//                 :
//                 saveStatus == SaveStatus.saving ?
//                 _saving()
//                 : 
//                 saveStatus == SaveStatus.failed?
//                 _error()
//                 :
//                 _saved()
//               ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _saving() {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SizedBox( height: 25, width: 25, child: CircularProgressIndicator(strokeWidth: 3,)),
//             SizedBox(width: 5,),
//             Text("Processing", style: Theme.of(context).textTheme.titleSmall)
//           ],
//         );
//       },
//     );
//   }

//   Widget _saveStatus() {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return Text(
//           "Sign in", 
//           style: Theme.of(context).textTheme.titleMedium);
//       },
//     );
//   }

//   Widget _idle() {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return Text(
//           "Sign in", 
//           style: Theme.of(context).textTheme.titleMedium
//             ?.copyWith(color: AppColors.context(context).textGreyColor));
//       },
//     );
//   }

//   Widget _saved() {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.done),
//             SizedBox(width: 5,),
//             Text("Success", style: Theme.of(context).textTheme.titleMedium)
//           ],
//         );
//       },
//     );
//   }

//   Widget _error() {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.error, color: Colors.yellow,),
//             SizedBox(width: 5,),
//             Text("Error", style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.yellow), )
//           ],
//         );
//       },
//     );
//   }

// }




// // class LoginButtonWidget extends StatefulWidget {
// //   const LoginButtonWidget({super.key});

// //   @override
// //   State<LoginButtonWidget> createState() => _LoginButtonWidgetState();
// // }

// // class _LoginButtonWidgetState extends State<LoginButtonWidget> {
// //   SaveStatus loginStatus = SaveStatus.canNotSave;

// //   @override
// //   Widget build(BuildContext context) {
// //     loginStatus =  context.watch<LoginProvider>().loginStatus;
// //     return LayoutBuilder(
// //       builder: (context, constraints) {
// //         return InkWell(
// //           onTap: () async{
// //             if(loginStatus == SaveStatus.canSave) {
// //               await context.read<LoginProvider>()
// //               .loginBang(
// //                 onDone: () {
// //                   Navigator.of(context)
// //                     .pushAndRemoveUntil(MaterialPageRoute(builder: (context)=> const AppInitialScreen()), (route) => false);
// //                 },
// //               );
// //             }
            
// //           },
// //           child: Container(
// //             height: 60,
// //             width: min(550, constraints.maxWidth),
// //             decoration: BoxDecoration(
// //               color: (loginStatus == SaveStatus.canSave || loginStatus == SaveStatus.saving) ? AppColors.context(context).accentColor : AppColors.context(context).accentColor.withOpacity(.2),
// //               borderRadius: BorderRadius.circular(5),
// //             ),
// //             child: Center(
// //               child: TextWidgets(context).buttonTextHigh(
// //                 buttonText: "Sign in", 
// //                 textColor: (loginStatus) ? AppColors.context(context).textColor: AppColors.context(context).textColor.withOpacity(.3)
// //               )
// //             ),
// //           )
        
// //         );
// //       },
// //     );
// //   }


  
// //   Widget _saving() {
// //     return LayoutBuilder(
// //       builder: (context, constraints) {
// //         return Row(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             SizedBox( height: 25, width: 25, child: CircularProgressIndicator(strokeWidth: 3,)),
// //             SizedBox(width: 5,),
// //             Text("Processing", style: Theme.of(context).textTheme.titleSmall)
// //           ],
// //         );
// //       },
// //     );
// //   }

// //   Widget _saveStatus() {
// //     return LayoutBuilder(
// //       builder: (context, constraints) {
// //         return Text(
// //           "Sign in", 
// //           style: Theme.of(context).textTheme.titleMedium);
// //       },
// //     );
// //   }

// //   Widget _idle() {
// //     return LayoutBuilder(
// //       builder: (context, constraints) {
// //         return Text(
// //           "Sign in", 
// //           style: Theme.of(context).textTheme.titleMedium
// //             ?.copyWith(color: AppColors.context(context).textGreyColor));
// //       },
// //     );
// //   }

// //   Widget _saved() {
// //     return LayoutBuilder(
// //       builder: (context, constraints) {
// //         return Row(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             Icon(Icons.done),
// //             SizedBox(width: 5,),
// //             Text("Saved", style: Theme.of(context).textTheme.titleMedium)
// //           ],
// //         );
// //       },
// //     );
// //   }

// //   Widget _error() {
// //     return LayoutBuilder(
// //       builder: (context, constraints) {
// //         return Row(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             Icon(Icons.error, color: Colors.yellow,),
// //             SizedBox(width: 5,),
// //             Text("Error", style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.yellow), )
// //           ],
// //         );
// //       },
// //     );
// //   }

// // }