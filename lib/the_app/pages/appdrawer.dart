
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/utils/constants/app_colors.dart';
import '../providers/appdrawer_controller.dart';
import '../widgets/drawer_header.dart';

enum AppDrawerTabState {
  pos, 
  inventory, 
  analysis,
  expenses, 
  settings;

  static AppDrawerTabState get initialTabScreen => AppDrawerTabState.pos;
  
  }


class AppDrawer extends StatefulWidget {
  final Function(AppDrawerTabState selectedTab) onNewTabSelect;
  const AppDrawer({required this.onNewTabSelect, super.key,});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}



class _AppDrawerState extends State<AppDrawer> {
  AppDrawerTabState selectedAppDrawerTab = AppDrawerTabState.pos;

  @override
  void initState() {
    // TODO: implement initState
    selectedAppDrawerTab = context.read<AppdrawerStateController>().selectedAppDrawerTab;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    selectedAppDrawerTab = context.watch<AppdrawerStateController>().selectedAppDrawerTab;
    return Drawer(
      backgroundColor: AppColors.context(context).backgroundColor,
      shape: const LinearBorder(side: BorderSide()),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
        
            double drawerBottomHeight = 112;
            double drawerUpperHeight = constraints.maxHeight - drawerBottomHeight;
        
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: drawerUpperHeight,
                  child: ListView(
                    children: [
                      const SizedBox(height: 0,),
                      const AppDrawerHeader(),
                      _appDrawerTile(icon: Icons.attach_money, appDrawerTabState: AppDrawerTabState.pos),
                      _appDrawerTile(icon: Icons.inventory_sharp, appDrawerTabState: AppDrawerTabState.inventory),
                      _appDrawerTile(icon: Icons.analytics, appDrawerTabState: AppDrawerTabState.analysis),
                      _appDrawerTile(icon: Icons.settings, appDrawerTabState: AppDrawerTabState.settings)
                    ],
                  ),
                ),
                    
                // Column(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Container(
                //       height: (drawerBottomHeight - 6) / 2,
                //       decoration: BoxDecoration(
                //         border: Border(bottom: BorderSide(color: AppColors().appBackgroundColor(context: context), width: 2))
                //       ),
                //       child: _toDtoreDashboardButton()
                //     ),
                //     SizedBox(height: (drawerBottomHeight - 6) / 2, child: _logoutButton()),
                //   ],
                // )
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _appDrawerTile({required IconData icon, required AppDrawerTabState appDrawerTabState}) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: ListTile(
              style: ListTileStyle.list,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              leading: Container(
                decoration: BoxDecoration(
                  color: AppColors.context(context).textColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(8)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(icon, color: AppColors.context(context).textColor),
                )
                ),
              title: Text(appDrawerTabState.name.toUpperCase(), style: Theme.of(context).textTheme.bodyMedium,),
              onTap: () {
                if(selectedAppDrawerTab != appDrawerTabState) {
                  Future.delayed(const Duration(milliseconds: 600), (){}).then((value) {
                    if(context.mounted) {
                      Scaffold.of(context).closeEndDrawer();
                      Scaffold.of(context).closeDrawer();
                    }
                  });
                  selectedAppDrawerTab = appDrawerTabState;
                  context.read<AppdrawerStateController>().changeAppDrawerTab(selectedAppDrawerTab);
                  //widget.onNewTabSelect(appDrawerTabState);
                  
                }
              },
              //tileColor: widget.appDrawerTabState == AppDrawerTabState.settings ? Colors.orange.shade200 : Colors.transparent,
              selected: selectedAppDrawerTab == appDrawerTabState,
              selectedColor: AppColors.context(context).textColor,
              selectedTileColor: AppColors.context(context).textColor.withAlpha(125),
            ),
          ),
        );
      },
    );
  }
  


}