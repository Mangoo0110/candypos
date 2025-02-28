// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/constants/app_colors.dart';
import '../../../../core/utils/func/dekhao.dart';
import '../../../../core/utils/image/image_loader_func.dart';

class UploadImageSimpleUi extends StatefulWidget {
  final double? radius;
  final String? imageUrl;
  final bool fromLocalDb;
  final Color? cameraIconBackgroundColor;
  final void Function(Uint8List pickedImage) onPick;
  const UploadImageSimpleUi({
    super.key,
    this.radius,
    this.imageUrl,
    this.fromLocalDb = false,
    required this.onPick, 
    this.cameraIconBackgroundColor,
  });

  @override
  State<UploadImageSimpleUi> createState() => _UploadImageSimpleUiState();
}

class _UploadImageSimpleUiState extends State<UploadImageSimpleUi> {

  Uint8List? _image;

  _onPick(Uint8List? image) {
    _image = image;
    if(_image != null) {
      setState(() {
        
      });

      widget.onPick(_image!);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    //context.read<ImageWriteProvider>().init(referencePath: widget.imageUrl, image: null, fromLocalDb: widget.fromLocalDb);
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          child: Stack(
            alignment: Alignment.topLeft,
            children: [
              ClipOval(
                child: Container(
                  height: widget.radius ?? min(140, constraints.maxWidth ),
                  width: widget.radius ?? min(140, constraints.maxWidth),
                  decoration: BoxDecoration(
                    color: AppColors.context(context).textColor,
                    borderRadius: BorderRadius.circular(8000000)
                  ),
                  child: _image == null 
                    ? Icon(
                        Icons.image, 
                        color: AppColors.context(context).textColor.withOpacity(.7), 
                        size: min(140, constraints.maxWidth / 2) - 6,
                      )
                    : Image.memory(_image!, fit: BoxFit.cover,),
                ),
              ),
              Positioned(
                bottom: 8,
                left: min(140, constraints.maxWidth) - 40,
                child: InkWell(
                  onTap: () async{

                    await ImageLoader.instance.pickImage().then((value) {
                      _onPick(value!);
                    });
                    
                  },
                  child: CircleAvatar(
                    backgroundColor: widget.cameraIconBackgroundColor ?? AppColors.context(context).contentBoxColor,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: CircleAvatar(
                        backgroundColor: AppColors.context(context).accentColor,
                        child:  Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Icon(
                            Icons.camera_alt,
                            color: AppColors.context(context).backgroundColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

}