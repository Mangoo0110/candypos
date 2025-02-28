
import 'package:candypos/the_app/pages/inventory_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/utils/constants/app_colors.dart';
import 'pos_page.dart';
import '../providers/appdrawer_controller.dart';
import '../providers/inventory_data_provider.dart';
import 'appdrawer.dart';
import '../widgets/selected_app_page.dart';
import '../widgets/appbar.dart';
import '../../features/store/domain/entities/store.dart';


class StoreUi extends StatefulWidget {
  const StoreUi({super.key});

  @override
  State<StoreUi> createState() => _StoreUiState();
}

class _StoreUiState extends State<StoreUi> {

  Store? currentStore;
  final AppDrawerTabState _appDrawerTabState = AppDrawerTabState.pos;

  Future<void> fetchEssentialData() async{
    await context.read<InventoryDataProvider>().init();
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() async{
    // TODO: implement didChangeDependencies
    await fetchEssentialData();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {

        // switch (context.watch<AppdrawerStateController>().selectedAppDrawerTab) {
        //   case AppDrawerTabState.pos:
        //     return PosUi();
        //   case AppDrawerTabState.inventory:
        //     return InventoryPage();
        //   case AppDrawerTabState.expenses:
        //     return Scaffold();
        //   case AppDrawerTabState.analysis:
        //     return Scaffold();
        //   case AppDrawerTabState.settings:
        //     return Scaffold();
        //   }
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.context(context).contentBoxColor,
          appBar: AppBar(
            titleSpacing: 0,
            backgroundColor: AppColors.context(context).contentBoxColor,
            title: const AppbarWidget()
          ),
          drawer: AppDrawer(
            onNewTabSelect: (selectedAppDrawerTab) {
              context.read<AppdrawerStateController>().changeAppDrawerTab(selectedAppDrawerTab);
            },
          ),

          body: const SelectedAppPage()
        );
      },
    );
  }



  
}