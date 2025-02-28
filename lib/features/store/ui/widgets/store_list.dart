import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/constants/app_colors.dart';
import '../../../../core/utils/routing/smooth_page_transition.dart';
import '../../../image/ui/widgets/show_round_image.dart';
import '../../domain/entities/store.dart';
import '../../../../the_app/pages/store_ui.dart';
import '../providers/store_data_provider.dart';


class StoreList extends StatefulWidget {
  final double contentMaxScreenWidth;
  const StoreList({super.key, required this.contentMaxScreenWidth});

  @override
  State<StoreList> createState() => _StoreListState();
}

class _StoreListState extends State<StoreList> {

  // final StreamController<List<Store>> _StoreListStreamController = StreamController<List<Store>>() ;

  // functions
  populateStoreList() {
    
  }

  List<Store> storeList = [];


  @override
  void initState() {
    // TODO: implement initState
    populateStoreList();
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    // _StoreListStreamController.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return FutureBuilder(
          future: context.read<StoreDataProvider>().fetchAllStoresOfUser(true),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              case ConnectionState.done || ConnectionState.active:
                if(snapshot.hasData) {
                  storeList = snapshot.data as List<Store>;
                  if(storeList.isEmpty) {
                    return Container(
                      //height: min(constraints.maxHeight, 100),
                      width: min(500, widget.contentMaxScreenWidth),
                      decoration: BoxDecoration(
                        color: AppColors.context(context).contentBoxGreyColor,
                        borderRadius: BorderRadius.circular(8)
                      ),
                      child: Center(
                        child: Text(
                          'No stores to show', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.context(context).textGreyColor),
                        ),
                      ),
                    );
                  } else {
                    return  ListView.builder(
                      clipBehavior: Clip.hardEdge,
                      shrinkWrap: true,
                      itemCount: storeList.length,
                      itemBuilder: (context, index) {
                        return Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(2),
                            onTap: () async{
                              await context.read<StoreDataProvider>().saveAsCurrentStore(store: storeList[index]).then((value) {
                                if(value && context.mounted){
                                  Navigator.pushAndRemoveUntil(
                                    context, 
                                    SmoothPageTransition().bottomToUp(secondScreen: const StoreUi()), (route) => false
                                  );
                                }
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 6),
                              child: SizedBox(
                                height: 100,
                                width: min(500, widget.contentMaxScreenWidth),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: ShowRoundImage(
                                        imageUrl: storeList[index].imageUrl,
                                        radius: 70,
                                      )
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 4),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(storeList[index].storeName, style: Theme.of(context).textTheme.bodyMedium,)
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                } else {
                  return const Center(child: Text('Error from service!!'));
                }
              default: 
                return const Center(child: CircularProgressIndicator());
            }
          },
        );
      },
    );
  }
}