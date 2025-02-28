



import '../../domain/entities/user_pub.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/constants/app_colors.dart';
import '../../../image/ui/widgets/show_round_image.dart';

class OtherUserProfile extends StatefulWidget {
  final UserPub user;
  const OtherUserProfile({super.key, required this.user});

  @override
  State<OtherUserProfile> createState() => _OtherUserProfileState();
}

class _OtherUserProfileState extends State<OtherUserProfile> with SingleTickerProviderStateMixin{

  //final String _appBarName = "PROFILE";
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          backgroundColor: AppColors.context(context).backgroundColor,
          appBar: AppBar(
            shadowColor: AppColors.context(context).textColor,
            elevation: 1,
            centerTitle: true,
            title: Text('P R O F I L E', style: Theme.of(context).textTheme.titleMedium,)
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // image section
                Material(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                        tag: widget.user.imageUrl,
                        child: SizedBox(
                          height: 130,
                          width: 130,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ShowRoundImage(imageUrl: widget.user.imageUrl),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget.user.fullName, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500),),
                                // const SizedBox(height: 4,),
                                // Text(widget.user.about, style: Theme.of(context).textTheme.titleSmall),
                              ],
                            ),
                            
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(height: 4, color: AppColors.context(context).dividerColor,),


                const SizedBox(height: 100,) //For floating action button
              ],
            ),
          ),
        );
      },
    );
  }


}