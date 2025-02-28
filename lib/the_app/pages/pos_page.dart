import '../../features/pos/ui/widgets/cart_status_widget.dart';
import 'package:flutter/material.dart';

import '../../core/utils/constants/app_colors.dart';
import '../widgets/pos_items_grid.dart';

class PosPage extends StatefulWidget {
  const PosPage({super.key});

  @override
  State<PosPage> createState() => _PosPageState();
}

class _PosPageState extends State<PosPage> with TickerProviderStateMixin{

  late TabController _tabController ;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          return SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: _body()
            ),
          );
        },
      );
  }

  Widget _body() {
    return LayoutBuilder(
      builder: (context, constraints) {
        double barHeight = 50;
        double tabHeight = constraints.maxHeight - barHeight;
        return Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            
            SizedBox(
              height: barHeight,
              width: constraints.maxWidth,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10),
                child: Center(child: _tabBar()),
              )
            ),

            Flexible(
              child: SizedBox(
                //height: tabHeight,
                width: constraints.maxWidth,
                //child:  ItemsTab(key: UniqueKey(),),
                child: TabBarView(
                  controller: _tabController,
                  // : (value) {
                  //   setState(() {
                  //     currentTabIndex = value;
                  //   });
                  // },
                  children: [
                    Container(),
                    PosItemsGrid(),
                  ],
                ),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CartStatusWidget(),
            ),
          ],
        );
          
      },
    );
  }


  Widget _tabBar() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          decoration: BoxDecoration(
            color: AppColors.context(context).contentBoxGreyColor,
            borderRadius: BorderRadius.circular(8)
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: TabBar(
                controller: _tabController,
                dividerColor: Colors.transparent,
                labelColor: AppColors.context(context).textColor.withOpacity(.9),
                //labelStyle: Theme.of(context).textTheme.labelLarge?.copyWith(color: AppColors.context(context).textColor),
                indicatorSize: TabBarIndicatorSize.tab,
                //indicatorPadding: EdgeInsets.symmetric(horizontal: 10),
                indicator: BoxDecoration(
                  color: AppColors.context(context).backgroundColor,
                  borderRadius: BorderRadius.circular(8)
                ),
                //controller: ,
                //isScrollable: true,
                onTap: (value) {
                  // setState(() {
                  //   currentTabIndex = value;
                  // });
                },
                tabs:  [
                  Tab(text: 'Keypad', height: constraints.maxHeight,),
                  Tab(text: 'Items', height: constraints.maxHeight,),
                ],
              ),
            
            ),
          ),
        );
      },
    );
  }
}