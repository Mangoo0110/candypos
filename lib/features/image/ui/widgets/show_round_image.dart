import 'dart:math';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/constants/app_colors.dart';
import '../../domain/repositories/image_repo.dart';
import '../providers/image_read_provider.dart';

class ShowRoundImage extends StatefulWidget {
  final Reference imageUrl;
  final double? radius;
  final bool fromLocalDb;
  const  ShowRoundImage({super.key, required this.imageUrl, this.radius, this.fromLocalDb = false});

  @override
  State<ShowRoundImage> createState() => _ShowRoundImageState();
}

class _ShowRoundImageState extends State<ShowRoundImage> {

  ImageX? image;

  @override
  void didChangeDependencies() async{
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    if(!mounted || image != null) return;
    await context.read<ImageReadProvider>().fetchImage(imageUrl: widget.imageUrl, fromLocalDb: widget.fromLocalDb).then((res) {
      image = res;
      setState(() {
      
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {

        double radius = widget.radius ?? min(constraints.maxWidth, constraints.maxHeight);
        
        return CircleAvatar(
          // height: radius ,
          // width:  radius,
          backgroundColor: AppColors.context(context).textColor.withOpacity(.5),
          // decoration: BoxDecoration(
          //   color: AppColors.context(context).textColor.withOpacity(.5),
          //   borderRadius: BorderRadius.circular(8000000000),
          // ),
          child: (image != null) ? _image(image!.image, radius) : null
          
        );
      },
    );
  }

  Widget _image(Uint8List image, double radius){
    return LayoutBuilder(
      builder: (context, constraints) {
        return ClipOval(
          child: Image.memory(
            image,
            fit: BoxFit.cover,
            height: radius - 2,
            width:  radius - 2,
          ).animate().fadeIn(curve: Curves.easeInOutSine, duration: const Duration(milliseconds: 300)),
        );
      },
    );
  }

}

