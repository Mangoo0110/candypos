



import 'package:intl/intl.dart';

import '../../../../core/common/enums/common_enums.dart';
import '../../../auth/ui/pages/auth_ui.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/constants/app_colors.dart';
import '../../../../core/utils/constants/app_sizes.dart';
import '../../../../core/utils/routing/smooth_page_transition.dart';
import '../../../image/ui/widgets/show_round_image.dart';
import '../../../../the_app/providers/current_app_user_provider.dart';
import 'edit_profile.dart';

class CurrentUserProfile extends StatefulWidget {
  const CurrentUserProfile({super.key});

  @override
  State<CurrentUserProfile> createState() => _CurrentUserProfileState();
}

class _CurrentUserProfileState extends State<CurrentUserProfile> with SingleTickerProviderStateMixin{

  //final String _appBarName = "PROFILE";
  @override
  Widget build(BuildContext context) {
    final currentUser = context.read<CurrentAppUserProvider>().currentUser;

    if(currentUser == null) {
      return AuthUi(
        onLogIn: (auth) {
        },
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          backgroundColor: AppColors.context(context).contentBoxColor,
          appBar: AppBar(
            shadowColor: AppColors.context(context).textColor,
            elevation: 1,
            centerTitle: true,
            title: Text('P R O F I L E', style: Theme.of(context).textTheme.titleMedium,),
            
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // image section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: context.read<CurrentAppUserProvider>().currentUser!.imageUrl,
                      child: SizedBox(
                        height: 130,
                        width: 130,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ShowRoundImage(imageUrl: context.read<CurrentAppUserProvider>().currentUser!.imageUrl),
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
                              Text(context.read<CurrentAppUserProvider>().currentUser!.fullName, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500),),
                              const SizedBox(height: 4,),
                              Text(context.read<CurrentAppUserProvider>().currentUser!.about, style: Theme.of(context).textTheme.titleSmall),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                              //color: AppColors.context(context).buttonColor,
                              borderRadius: BorderRadius.circular(8)
                            ),
                            child: Padding(
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
                            )),
                        ],
                      ),
                    ),
                  ],
                ),

                if(currentUser.gender != null) Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        currentUser.gender == Gender.male ? Icons.male 
                        : currentUser.gender == Gender.female ? Icons.female
                        : Icons.transgender, 
                        color: AppColors.context(context).textColor.withOpacity(.6),),
                      Padding(
                        padding: const EdgeInsets.only(left: 6.0),
                        child: Text(
                          currentUser.gender == Gender.male ? "Male" 
                          : currentUser.gender == Gender.female ? "Female"
                          : 'Other',),
                      )
                    ],
                  ),
                ),

                if(currentUser.birthdate != null) Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.cake, color: AppColors.context(context).textColor.withOpacity(.6),),
                      Padding(
                        padding: const EdgeInsets.only(left: 6.0),
                        child: Text(DateFormat.yMMMd().format(currentUser.birthdate!),),
                      )
                    ],
                  ),
                ),

                //UserEducationList(userId: context.read<UserAuthProvider>().userAuth!.id,).animate().fadeIn(duration: const Duration(milliseconds: 300)),
                // const UserWorkRoleList(workRoles: [],).animate().fadeIn(delay: const Duration(milliseconds: 100), duration: const Duration(milliseconds: 300)),
                // Container(height: 4, color: AppColors.context(context).dividerColor,),

                const SizedBox(height: 50,),
                Container(
                  height: .5,
                  width: constraints.maxWidth,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border(bottom: BorderSide(color: AppColors.context(context).textGreyColor))
                  ),
                ),
                
                Row(
                  children: [
                    //Icon(Icons.precision_manufacturing_rounded, size: AppSizes.largeIconSize, color: AppColors.context(context).accentColor,),
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Text("Manage(Admin)", style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.context(context).textGreyColor),),
                    )
                  ],
                ),
                const SizedBox(height: 50,),
                const SizedBox(height: 50,), //For floating action button
              ],
            ),
          ),
        );
      },
    );
  }


}