// import 'package:flutter/material.dart';


// class AnimatedListAppBar extends StatefulWidget {
//   const AnimatedListAppBar({super.key});

//   @override
//   State<AnimatedListAppBar> createState() => _AnimatedListAppBarState();
// }

// class _AnimatedListAppBarState extends State<AnimatedListAppBar> {

//   final String _appBarName = "PROFILE";
  
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return SizedBox(
//           height: 60,
//           width: constraints.maxWidth,
//           child: AnimatedList(
//             scrollDirection: Axis.horizontal,
//             initialItemCount: _appBarName.length,
//             itemBuilder: (context, index, animation) {
//               return SlideTransition(
//                 position: animation.drive(Tween<Offset>(
//                   begin: const Offset(1, 0), // Start off-screen (right)
//                   end: Offset(.5 + index * .1, 0), // End at its original position
//                 )),
//                 child: Text(
//                   _appBarName[index],
//                   style: const TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                 ),
//               );
//             },
//           ),
//           // child: AnimatedList(
//           //   scrollDirection: Axis.horizontal,
//           //   initialItemCount: _appBarName.length,
//           //   itemBuilder: (context, index, animation) {
//           //     return Text("${_appBarName[index]}  ", style: Theme.of(context).textTheme.titleMedium,)
//           //       .animate(delay: Duration(milliseconds: baseDelay * index),)
//           //       .fadeIn(duration: Duration(milliseconds: baseDuration))
//           //       ;
//           //   },
//           // ),
//         );
//       },
//     );
//   }
// }