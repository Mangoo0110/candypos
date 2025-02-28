import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'core/utils/constants/app_names.dart';
import 'core/utils/func/dekhao.dart';
import 'core/utils/themes/theme.dart';
import 'features/auth/ui/pages/auth_ui.dart';
import 'features/auth/ui/providers/auth_provider.dart';
import 'the_app/providers/appdrawer_controller.dart';
import 'features/image/ui/providers/image_read_provider.dart';
import 'features/pos/ui/providers/open_cart.dart';
import 'the_app/pages/store_ui.dart';
import 'features/store/ui/providers/store_data_provider.dart';
import 'the_app/providers/current_app_user_provider.dart';
import 'init_dependency.dart';
import 'the_app/pages/user_dashboard.dart';
import 'the_app/providers/inventory_data_provider.dart';

void main() async{
  
  WidgetsFlutterBinding.ensureInitialized();

  List<ChangeNotifierProvider> providers = [
    ChangeNotifierProvider<ImageReadProvider>(create: (context)=> ImageReadProvider()),
    //ChangeNotifierProvider<ImageWriteProvider>(create: (context)=> ImageWriteProvider()),
    ChangeNotifierProvider<UserAuthProvider>(create: (context)=> UserAuthProvider()),
    ChangeNotifierProvider<CurrentAppUserProvider>(create: (context)=> CurrentAppUserProvider()),
    ChangeNotifierProvider<AppdrawerStateController>(create: (context)=> AppdrawerStateController(), ),
    ChangeNotifierProvider<StoreDataProvider>(create: (context)=> StoreDataProvider()),
    ChangeNotifierProvider<InventoryDataProvider>(create: (context)=> InventoryDataProvider.instance),
    //ChangeNotifierProvider<PosUiProvider>(create: (context)=> PosUiProvider.instance()),
    ChangeNotifierProvider<OpenedCart>(create: (context)=> OpenedCart.instance),
  ];
  
  await getApplicationDocumentsDirectory().then((docDir)  async{
    Hive.init(docDir.path);

    await initDependencies().then((value) async{
      Animate.restartOnHotReload = true;
      runApp(
        MultiProvider(
          providers: providers,
          child: (const MyApp()),
        ));
    });
    
  });
  
}



class MyApp extends StatelessWidget {
  
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppNames.nameOfTheApp,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: StreamBuilder(
        stream: context.read<UserAuthProvider>().getCurrentUserAuth(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            dekhao("waiting");
            return const Center(
              child: CircularProgressIndicator());
          }
          if(snapshot.connectionState == ConnectionState.active || snapshot.connectionState == ConnectionState.done) {
            dekhao("active");
            var userAuth = snapshot.data ;
            
            if(userAuth == null) {
              return  AuthUi(
                onLogIn: (auth) {
                  
                },
              );
            } else {

              return FutureBuilder(
                future: context.read<CurrentAppUserProvider>().getCurrentAppUser(userAuth, context.read<StoreDataProvider>()),
                builder: (context, snapshot) {

                  switch (snapshot.connectionState) {
                    
                    case ConnectionState.waiting:
                      return const Center(
                        child: CircularProgressIndicator()
                      );

                    case ConnectionState.active || ConnectionState.done:
                      final currentAppUser = snapshot.data;
                      if(currentAppUser?.currentStore == null) {
                        return const UserDashboard();
                      } else {
                        // Future.delayed(Duration(seconds: 1), (){
                        //   context.
                        // })
                        return const StoreUi();
                      }

                    default:
                      return const Center(
                        child: CircularProgressIndicator()
                      );
                  }
                }
              );
            }
          }
          return const Center(
            child: CircularProgressIndicator());
        },
        
      ),

    );
  }

}

 