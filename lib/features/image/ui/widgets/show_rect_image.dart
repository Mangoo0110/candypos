import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/constants/app_colors.dart';

import '../../domain/repositories/image_repo.dart';
import '../providers/image_read_provider.dart';

class ShowRectImage extends StatefulWidget {
  final Reference imageUrl;
  final double? height;
  final double? width;
  final double borderRadiusVal;
  final bool fromLocalDb;
  const ShowRectImage({super.key, required this.imageUrl, this.height, this.width, required this.borderRadiusVal, this.fromLocalDb = false});

  @override
  State<ShowRectImage> createState() => _ShowRectImageState();
}

class _ShowRectImageState extends State<ShowRectImage> {

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: widget.height ?? constraints.maxHeight,
          width:  widget.width ?? constraints.maxWidth,
          
          decoration: BoxDecoration(
            color: AppColors.context(context).textColor.withOpacity(.5),
            borderRadius: BorderRadius.circular(widget.borderRadiusVal),
          ),
          child: FutureBuilder(
            future: context.read<ImageReadProvider>().fetchImage(imageUrl: widget.imageUrl, fromLocalDb: widget.fromLocalDb), 
            builder:(context, snapshot) {
              switch (snapshot.hasData && snapshot.data != null) {
                case true:
                  ImageX? imageX = snapshot.data;
                  return _image(imageX!.image);
                case false:
                  return Container();
                  
              }
            },
          ),
        );
      },
    );
  }

  Widget _image(Uint8List image){
    return LayoutBuilder(
      builder: (context, constraints) {
        return Image.memory(
          image,
          fit: BoxFit.cover,
          height: constraints.maxHeight,
          width:  constraints.maxWidth,
        ).animate().fadeIn(duration: const Duration(milliseconds: 300));
      },
    );
  }

}