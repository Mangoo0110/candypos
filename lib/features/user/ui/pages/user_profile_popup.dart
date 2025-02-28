



import 'package:intl/intl.dart';


import '../../../../core/common/enums/common_enums.dart';
import '../../domain/entities/user_pub.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/constants/app_colors.dart';
import '../../../../core/utils/constants/app_sizes.dart';
import '../../../../core/utils/routing/smooth_page_transition.dart';
import '../../../image/ui/widgets/show_round_image.dart';
import '../../../../the_app/providers/current_app_user_provider.dart';
import 'edit_profile.dart';

class UserProfilePopup extends StatefulWidget {
  final UserPub userPub;
  const UserProfilePopup({super.key, required this.userPub});

  @override
  State<UserProfilePopup> createState() => _UserProfilePopupState();
}

class _UserProfilePopupState extends State<UserProfilePopup> with SingleTickerProviderStateMixin{

  //final String _appBarName = "PROFILE";
  @override
  Widget build(BuildContext context) {
    final userInfo = widget.userPub;

    final currentUser = context.read<CurrentAppUserProvider>().currentUser;

    return LayoutBuilder(
      builder: (context, constraints) {
        return  Scaffold(
          backgroundColor: Colors.transparent,
          body: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            focusColor: Colors.transparent,
            onTap: () {
              Navigator.pop(context);
            },
            child: Material(
              color: AppColors.context(context).backgroundColor.withOpacity(.5),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 120,
                    left: 20,
                    right: 20,
                    child: GestureDetector(
                      onTap: () {
                        
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.context(context).dividerColor,
                          borderRadius: AppSizes.mediumBorderRadius,
                          boxShadow: [
                            BoxShadow(color: AppColors.context(context).shadowColor, blurRadius: 8)
                          ]
                        ),
                        child: SingleChildScrollView(
                            child:  Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // image section
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Hero(
                                      tag: userInfo.imageUrl,
                                      child: SizedBox(
                                        height: 130,
                                        width: 130,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ShowRoundImage(imageUrl: userInfo.imageUrl),
                                        ),
                                      ),
                                    ),
                                    Material(
                                      color: Colors.transparent,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Column( 
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(userInfo.fullName, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500),),
                                                const SizedBox(height: 4,),
                                                //Text(userInfo.about, style: Theme.of(context).textTheme.titleSmall),
                                              ],
                                            ),
                                            if(currentUser?.id == userInfo.id) Padding(
                                              padding: const EdgeInsets.all(6.0),
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.of(context).push(SmoothPageTransition().bottomToUp(secondScreen: EditProfilePage(
                                                    
                                                  )));
                                                },
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.mode_edit_outlined, color: AppColors.context(context).buttonTextColor, size: AppSizes.mediumTextSize + 10,),
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 6.0),
                                                      child: Text("Edit Bio", style: TextStyle(color: AppColors.context(context).buttonTextColor, fontSize: AppSizes.mediumTextSize, fontWeight: FontWeight.bold)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                            
                                if(userInfo.gender != null) Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        userInfo.gender == Gender.male ? Icons.male 
                                        : userInfo.gender == Gender.female ? Icons.female
                                        : Icons.transgender, 
                                        color: AppColors.context(context).textColor.withOpacity(.6),),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 6.0),
                                        child: Text(
                                          userInfo.gender == Gender.male ? "Male" 
                                          : userInfo.gender == Gender.female ? "Female"
                                          : 'Other',),
                                      )
                                    ],
                                  ),
                                ),
                            
                                if(userInfo.birthdate != null) Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Icon(Icons.cake, color: AppColors.context(context).textColor.withOpacity(.6),),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 6.0),
                                        child: Text(DateFormat.yMMMd().format(userInfo.birthdate!),),
                                      )
                                    ],
                                  ),
                                ),
                            
                                //UserEducationList(userId: context.read<UserAuthProvider>().userAuth!.id,).animate().fadeIn(duration: const Duration(milliseconds: 300)),
                                // const UserWorkRoleList(workRoles: [],).animate().fadeIn(delay: const Duration(milliseconds: 100), duration: const Duration(milliseconds: 300)),
                                // Container(height: 4, color: AppColors.context(context).dividerColor,),
                            
                                const SizedBox(height: 100,) //For floating action button
                              ],
                            ),
                          )
      
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      
      },
    );
  }


}