import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../core/utils/constants/app_colors.dart';
import '../../../../core/utils/constants/app_sizes.dart';
import '../../../../core/utils/image/image_loader_func.dart';


class UploadImage extends StatefulWidget {
  final Uint8List? image;
  final Function (Uint8List pickedImage) onPick;
  const UploadImage({required this.onPick, super.key, this.image});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {

  Uint8List? image;


  @override
  void initState() {
    // TODO: implement initState
    image = widget.image;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double imageBoxH = 130, textH = 50;
    final double boxH = imageBoxH + textH, boxW = 180; 
    return 
      LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            decoration: BoxDecoration(
              color: AppColors.context(context).contentBoxGreyColor,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  (image == null)
                  ? Container(
                    width: boxW,
                    height: imageBoxH,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: AppSizes.smallBorderRadius,
                    ),
                    child: Icon(Icons.image, size: 50, color: Colors.grey),
                  )
                  : Image.memory(
                    image!,
                    width: boxW,
                    height: imageBoxH,
                    fit: BoxFit.cover,
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: AppColors.context(context).textColor,
                      borderRadius: AppSizes.smallBorderRadius,
                      onTap: () async{

                        await ImageLoader.instance.pickImage().then((value) {
                          image = value;
                          setState(() {
                            
                          });
                          if(image != null) widget.onPick(image!);
                        });
                        
                      },
                      child: SizedBox(
                        height: textH,
                        width: boxW,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.upload, color: AppColors.context(context).accentColor),
                              SizedBox(width: 10,),
                              Text('Upload', style: Theme.of(context).textTheme.labelLarge?.copyWith(color: AppColors.context(context).accentColor),),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      );
  }
}
