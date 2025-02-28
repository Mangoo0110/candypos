
import 'package:flutter/material.dart';

import '../../core/utils/routing/smooth_page_transition.dart';
import '../../features/inventory/category/ui/pages/categories_page.dart';
import '../../features/inventory/item/ui/pages/items_page.dart';
import 'appdrawer.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(
        onNewTabSelect: (selectedAppDrawerTab) {
          //context.read<AppdrawerStateController>().changeAppDrawerTab(selectedAppDrawerTab);
        },
      ),
      body: ListView(
        children: [
          // Categories
          _tile(
            icon: Icons.category_outlined, 
            title: "Categories", 
            onTap: (){
              Navigator.push(context, SmoothPageTransition().rightToLeft(secondScreen: CategoriesPage()));
            }
          ),
          
          // Items
          _tile(
            icon: Icons.list, 
            title: "Items", 
            onTap: () async{
              Future.delayed(Duration(milliseconds: 500)).then((_){
                if(context.mounted) {
                  Navigator.push(
                    context, SmoothPageTransition()
                    .rightToLeft(
                      secondScreen: ItemsPage()
                    )
                  );
                }
              });
              
            }
          ),

          // Raw-materials

          // Stocks
        ],
      ),
    );
  }

  Widget _tile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ListTile(
          onTap: () => onTap(),
          leading: Icon(icon,),
          title: Text(title, style: Theme.of(context).textTheme.titleMedium,),
        );
      },
    );
  }
}