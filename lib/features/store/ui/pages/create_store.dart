import 'dart:typed_data';

import 'package:candypos/the_app/providers/current_app_user_provider.dart';
import 'package:candypos/features/image/ui/widgets/simple_upload_image.dart';

import '../../../../../core/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/common/textfields/description_textfield.dart';
import '../../../../core/common/textfields/name_textfield.dart';
import '../../../../core/common/widgets/save_button.dart';
import '../../../../core/common/widgets/text_widgets.dart';
import '../../domain/entities/store.dart';
import '../providers/create_store_provider.dart';
import '../widgets/store_create_button.dart';

class CreateStoreUi extends StatefulWidget {
  final Store? store;
  final VoidCallback onCreateDone;
  const CreateStoreUi({super.key, required this.onCreateDone, required this.store});

  @override
  State<CreateStoreUi> createState() => _CreateStoreUiState();
}

class _CreateStoreUiState extends State<CreateStoreUi> {

  final TextEditingController _nameInputCntrl = TextEditingController();
  final TextEditingController _contactNoInputCntrl = TextEditingController();
  final TextEditingController _addressInputCntrl = TextEditingController();





  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _addressInputCntrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final CurrentAppUser? currentAppUser = context.read<CurrentAppUserProvider>().currentAppUser;

    if(currentAppUser == null) {
      return Scaffold(
        body: Center(child: TextWidgets(context).highLightTextSize(text: 'No current store!', fontSize: 18)),
      );
    }

    return ChangeNotifierProvider(
      create: (context) => CreateStoreProvider(currentAppUser.userAuth),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.context(context).contentBoxColor,
              appBar: AppBar(
                elevation: 2,
                backgroundColor: AppColors.context(context).contentBoxColor,
                leading: Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: CloseButton(
                    color:  AppColors.context(context).textColor,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: const ButtonStyle(
                      iconSize: MaterialStatePropertyAll(26),
                      //visualDensity: VisualDensity(horizontal: 4, vertical: 4)
                    ),),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.store == null ? 'Create Store' : 'Update Store', 
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    
                  ],
                ),
                actions: [
                  Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: SaveButton(
                      saveStatusNotifier: context.read<CreateStoreProvider>().saveStatusNotifier, 
                      onSave: () async{
                        await context.read<CreateStoreProvider>().createStore();
                      }, 
                      onSuccess: ()async{
                        //Navigator.pop(context);
                      }
                    ),
                  )
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 10,),
                      Container(
                        height: 160,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.context(context).contentBoxColor,
                          border: Border.all(
                            color: AppColors.context(context).contentBoxGreyColor, 
                            width: 2
                          ),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: const [
                            BoxShadow(color: Color(0x1F000000), blurRadius: 5)
                          ]
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: UploadImageSimpleUi(
                            radius: 140,
                            onPick: (Uint8List pickedImage) {  
                              
                            },
                          ),
                        ),
                      ),
                  
                      
                  
                      const SizedBox(height: 10),
                  
                      _editStoreName(),
                      
                      const SizedBox(height: 10),
                      
                      _editContactNo(),
                      
                      const SizedBox(height: 50,),
                  
                      _editStoreAddress(),
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

  Widget _editStoreAddress() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          height: 170,
          width: constraints.maxWidth,
          child: DescriptionTextfield(
            maxLines: 100, 
            onChanged: (text){
              context.read<CreateStoreProvider>().setAddress(text.trim());
            },
            controller: _addressInputCntrl, 
            hintText: 'Street or lane e.g. 05 Block, East Khulsi. You can change it later.', 
            labelText: 'Store Address',
            // validationCheck: (text) {
              
            // },
          ),
        );
      },
    );
  }

  Widget _editStoreName() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          height: 80,
          width: constraints.maxWidth,
          child: NameTextfield(
            maxLines: 100, 
            onChanged: (text){
              context.read<CreateStoreProvider>().setStoreName(text.trim());
            },
            controller: _nameInputCntrl, 
            hintText: 'Name that store goes by or will go by...', 
            labelText: 'Store Name', validationCheck: (text){},
          ),
        );
      },
    );
  }

  Widget _editContactNo() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          height: 80,
          width: constraints.maxWidth,
          child: NameTextfield(
            maxLines: 100, 
            onChanged: (text){
              context.read<CreateStoreProvider>().setContactNo(text.trim());
            },
            controller: _contactNoInputCntrl, 
            hintText: 'Enter a valid mobile number (11 digit).', 
            labelText: 'Contact No',
             validationCheck: (text){},
          ),
        );
      },
    );
  }
}