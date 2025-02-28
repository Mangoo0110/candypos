// import '../../../../../current_app_user_provider.dart';
// import '../providers/edit_variant_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../domain/entities/item.dart';


// class EditVariantUi extends StatefulWidget {
//   final Variant variant;
//   final Function(Variant variantAfterEdit) onDone;
//   const EditVariantUi({super.key, required this.variant, required this.onDone, });

//   @override
//   State<EditVariantUi> createState() => _EditVariantUiState();
// }

// class _EditVariantUiState extends State<EditVariantUi> {


//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<EditVariantProvider>(
//       create:(context) => EditVariantProvider(widget.variant, context.read<CurrentAppUserProvider>().currentAppUser!.userAuth),
//       child: LayoutBuilder(
//         builder: (context, constraints) {
//           return Scaffold();
//         },
//       ),
//     );
//   }
// }