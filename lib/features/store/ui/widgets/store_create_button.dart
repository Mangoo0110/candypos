
// import '../providers/create_store_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../../../core/utils/constants/app_colors.dart';
// import '../../../../core/utils/enums/common_enums.dart';

// class StoreSaveButton extends StatefulWidget {
//   const StoreSaveButton({super.key});

//   @override
//   State<StoreSaveButton> createState() => _StoreSaveButtonState();
// }

// class _StoreSaveButtonState extends State<StoreSaveButton> {

//   SaveStatus saveStatus = SaveStatus.canNotSave;
//   @override
//   Widget build(BuildContext context) {
//     saveStatus = context.watch<CreateStoreProvider>().saveStatus;
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return InkWell(
//           onTap: () async{
//             if(saveStatus == SaveStatus.canSave){
//               // await context.read<ModifyBranchProvider>().saveBranch(
//               //   ondone:() {
//               //     Navigator.pop(context);
//               //   },);
//             }
//           },
//           child: Icon(
//             Icons.done,
//             size: 30,
//             weight: 4,
//             color: saveStatus != SaveStatus.canSave ? AppColors.context(context).contentBoxGreyColor : AppColors.context(context).accentColor,
//           ),
//         );
//       },
//     );
//   }
// }