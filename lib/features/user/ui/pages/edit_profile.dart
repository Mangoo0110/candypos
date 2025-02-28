
import 'dart:math';
import 'dart:typed_data';

import 'package:candypos/features/image/ui/widgets/simple_upload_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/constants/app_colors.dart';
import '../../../../core/utils/func/dekhao.dart';
import '../../../auth/ui/pages/auth_ui.dart';
import '../../../auth/ui/providers/auth_provider.dart';
import '../../../../the_app/providers/current_app_user_provider.dart';
import '../providers/user_profile_write_provider.dart';
import '../widgets/input_birthdate.dart';
import '../widgets/input_gender.dart';
import '../widgets/profile_text_input_widget.dart';
import '../../../../core/common/widgets/save_button.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {

  final TextEditingController _nameInptCntrl = TextEditingController();
  final TextEditingController _professionInptCntrl = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    _nameInptCntrl.text = context.read<CurrentAppUserProvider>().currentUser == null ? '' : context.read<CurrentAppUserProvider>().currentUser!.fullName;
    _professionInptCntrl.text = context.read<CurrentAppUserProvider>().currentUser == null ? '' : context.read<CurrentAppUserProvider>().currentUser!.about;
    super.initState();
  }


  
  @override
  Widget build(BuildContext context) {

    final currentUser = context.read<CurrentAppUserProvider>().currentUser;

    if(currentUser == null) {
      return AuthUi(
        onLogIn: (auth) {
        },
      );
    }

    dekhao("Edit profile of ${currentUser.toString()}");
    return ChangeNotifierProvider<UserProfileWriteProvider>(
      create: (context)=> UserProfileWriteProvider(
        currentUser, 
        context.read<UserAuthProvider>().userAuth!,),
      
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Scaffold(
            backgroundColor: AppColors.context(context).contentBoxColor,
            appBar: AppBar(
              title: Text('Edit profile bio', style: Theme.of(context).textTheme.titleMedium,),
              actions:  [
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: SizedBox(
                    height: 60,
                    width: 100,
                    child: SaveButton(
                      saveStatusNotifier: context.read<UserProfileWriteProvider>().saveStatusNotifier, 
                      onSave: () async{
                        await context.read<UserProfileWriteProvider>().saveUser();
                      }, 
                      onSuccess: ()async{
                        Navigator.pop(context);
                      }
                    ),
                  ),
                )
              ],
              leading: CloseButton(
                color: AppColors.context(context).textColor, 
                onPressed: () {   
                  Navigator.pop(context);
                },
              ),
            ),
            body: SizedBox(
              width: min(550, constraints.maxWidth),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // image section
                        
                      SizedBox(
                        height: 160,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: UploadImageSimpleUi(
                            radius: 140,
                            imageUrl: currentUser.imageUrl.fullPath, 
                            onPick: (Uint8List pickedImage) {  },
                          ),
                        ),
                      ),
                        
                      const SizedBox(height: 10,),
              
                      SizedBox(
                        height: 70,
                        width: constraints.maxWidth,
                        child: ProfileTextInputWidget(
                          onChanged: (text){
                            context.read<UserProfileWriteProvider>().setFullName(text.trim());
                          },
                          hintText: 'Type your full name', 
                          labelText: 'Full Name', 
                          suffixIcon: null, 
                          initialTextData: currentUser.fullName, 
                        ),
                      ),
                        
                      const SizedBox(height: 25,),
                  
                      SizedBox(
                        height: 70,
                        width: constraints.maxWidth,
                        child: ProfileTextInputWidget(
                          onChanged: (text){
                            context.read<UserProfileWriteProvider>().setFullName(text.trim());
                          },
                          hintText: 'Type your interest, skill, or simply about you', 
                          labelText: 'Description', 
                          suffixIcon: null, 
                          initialTextData: currentUser.about, 
                        ),
                      ),

                      const SizedBox(height: 25,),
                  
                      InputGender(
                        initialGender: currentUser.gender, 
                        onSelect: (selectedGender){
                          if(selectedGender != null) context.read<UserProfileWriteProvider>().setGender(selectedGender);
                        }
                      ),
                      
                      const SizedBox(height: 25,),

                      InputBirthdate(
                        initialBirthdate: currentUser.birthdate, 
                        onSelect: (selectedDate) {
                          return context.read<UserProfileWriteProvider>().setBirthdate(selectedDate);
                        },
                      ),

                      const SizedBox(height: 25,),

                      //UserEducationEditList(userId: currentUser.docId)
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

}
