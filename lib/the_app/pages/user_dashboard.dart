import 'dart:math';


import 'package:candypos/core/common/widgets/animated_app_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/common/widgets/spaces.dart';
import '../../core/common/widgets/text_widgets.dart';
import '../../core/utils/constants/app_colors.dart';
import '../../core/utils/constants/app_names.dart';
import '../../core/utils/func/dekhao.dart';
import '../../core/utils/routing/smooth_page_transition.dart';
import '../providers/current_app_user_provider.dart';
import '../../features/image/ui/widgets/show_round_image.dart';
import '../../features/store/ui/pages/create_store.dart';
import '../../features/store/ui/providers/store_data_provider.dart';
import '../../features/store/ui/widgets/store_list.dart';


class UserDashboard extends StatefulWidget {
  const UserDashboard({super.key});

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {

  CurrentAppUser? currentAppUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    currentAppUser = context.read<CurrentAppUserProvider>().currentAppUser;

    return LayoutBuilder(
      builder: (context, constraints) {
        dekhao(currentAppUser?.toString());
        if(currentAppUser == null || currentAppUser?.userPrvDetails == null) {
          dekhao("etfffffff ${currentAppUser?.userPrvDetails}");
          return Scaffold(
            body: Center(child: TextWidgets(context).highLightText(text: "Login with store account, please!", textColor: AppColors.context(context).textColor)),
          );
        }

        double contentMaxScreenWidth = min(constraints.maxWidth, 700);
        return Scaffold(
          
          // appBar: (constraints.maxHeight < 500) ? null : AppBar(
          //   forceMaterialTransparency: true,
          //   backgroundColor: AppColors.context(context).contentBoxColor,
          //   foregroundColor: AppColors.context(context).contentBoxColor,
          // ),
          backgroundColor: AppColors.context(context).contentBoxColor,
          body: Padding(
            padding: EdgeInsets.fromLTRB(8, (constraints.maxHeight < 500) ? 10 : constraints.maxHeight * .1, 8, 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(alignment: Alignment.center, child: AnimatedAppTitle()),
                Spaces().verticalSpace2(),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    //mainAxisSize: MainAxisSize.min,
                    children: [
                      _userStore(contentMaxScreenWidth: contentMaxScreenWidth),
                      Spaces().verticalSpace2(),
                      Container(
                        height: 1,
                        width: min(500, contentMaxScreenWidth),
                        color: AppColors.context(context).contentBoxGreyColor,
                      ),
                      Spaces().verticalSpace2(),
                      Flexible(
                        child: _store(contentMaxScreenWidth: contentMaxScreenWidth)
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  Widget _appName() {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return const LinearGradient(
          colors: [Colors.orange, Colors.yellow],
        ).createShader(bounds);
      },
      blendMode: BlendMode.srcATop,
      child: Text(AppNames.nameOfTheApp, style: Theme.of(context).textTheme.headlineMedium,)
    );
  }

  Widget _userStore({required double contentMaxScreenWidth}) {
    return Container(
      height: 80,
      width: min(500, contentMaxScreenWidth),
      decoration: BoxDecoration(
        color: AppColors.context(context).backgroundColor,
        borderRadius: BorderRadius.circular(200),
        border: Border.all(color: AppColors.context(context).contentBoxGreyColor),
        boxShadow: [
          BoxShadow(color: AppColors.context(context).shadowColor, blurRadius: 5)
        ]
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(200),
            onTap: () {
              //Navigator.push(context, MaterialPageRoute(builder: (context)=> const EditUserInfoScreen(heroTagForImage: 'userInfo')));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(
                    children: [
                      ShowRoundImage(
                        imageUrl: currentAppUser!.userPrvDetails!.imageUrl, 
                        radius: 60,
                      ),
                      Flexible(child: Text(overflow: TextOverflow.ellipsis, currentAppUser?.userPrvDetails?.fullName ?? 'Na',  style: Theme.of(context).textTheme.titleMedium,)),
                    ],
                  ),
                ),
                Center(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(500000),
                    onTap: () {
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=> const EditUserInfoScreen(heroTagForImage: 'blank')));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.settings, size: 30, color: AppColors.context(context).accentColor,),
                    )
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _store({required double contentMaxScreenWidth}) {
    return Container(
      width: min(500, contentMaxScreenWidth),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.context(context).contentBoxColor,
        border: Border.all(color: AppColors.context(context).contentBoxGreyColor),
        boxShadow: const [
          BoxShadow(color: Color(0x1F000000), blurRadius: 5)
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Stores', style: Theme.of(context).textTheme.titleLarge,),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {
                      Navigator.push(context, SmoothPageTransition().bottomToUp(secondScreen: CreateStoreUi(
                        store: null,
                        onCreateDone: () async{

                          Navigator.pop(context);
                          await context.read<StoreDataProvider>().fetchAllStoresOfUser(true).then((_) {
                            setState(() {
                              
                            });
                          });

                        },
                      )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.add, size: 20,color: AppColors.context(context).accentColor,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Text('Create', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.context(context).accentColor),),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Spaces().verticalSpace1(),
          Flexible(
            child: StoreList(contentMaxScreenWidth: contentMaxScreenWidth)
          )
        ],
      ),
    );
  }
}