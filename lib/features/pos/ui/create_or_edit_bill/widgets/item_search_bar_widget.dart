
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../core/common/textfields/no_border_textfield.dart';
import '../../../../../core/utils/constants/app_colors.dart';

enum ShowBar {fullbar, searchbar, scanbar}

class ItemSearchBar extends StatefulWidget {

  const ItemSearchBar({super.key,});

  @override
  State<ItemSearchBar> createState() => _ItemSearchBarState();
}

class _ItemSearchBarState extends State<ItemSearchBar> {

  final TextEditingController _controller = TextEditingController();

  bool animateFullBar = false;

  ShowBar showBar = ShowBar.fullbar;
  
  List<String> categoryList = ["All products"];
  String selectedCategoryName = 'All products';

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          height: 55, 
          width: constraints.maxWidth, 
          child: showBar == ShowBar.fullbar
          ?
          (animateFullBar ? _fullBar().animate().slideX(begin: -1, end: 0, duration: const Duration(milliseconds: 500), curve: Curves.easeInOutBack) : _fullBar()) 
          : 
          showBar == ShowBar.searchbar ? _searchBar() : _barcodeScanBar()
        );
      },
    );
  }

  Widget _fullBar() {
    animateFullBar = false;
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: AppColors.context(context).textGreyColor),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: constraints.maxWidth * .45,
                child: _categories(constraints: constraints)),
              SizedBox(
                width: constraints.maxWidth * .5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(height: constraints.maxHeight - 10, width: .4, color: AppColors.context(context).textGreyColor,),
                    _search(),
                    Container(height: constraints.maxHeight - 10, width: .4, color: AppColors.context(context).textGreyColor,),
                    _barcodeScan()
                  ],
                ),
              )
            ],
          ),
        );
      }
    );
  }

  Widget _searchBar() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: AppColors.context(context).textGreyColor),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: constraints.maxWidth * .58,
                child: NoBorderTextfield(
                  maxLines: 1, 
                  prefiexIcon: null,
                  onChanged: (text){
                    
                  }, 
                  controller: _controller, 
                  hintText: 'Search name, code/barcode', 
                  labelText: '', 
                  validationCheck: (text){
                        
                  }
                )),
              SizedBox(
                width: constraints.maxWidth * .4,
                height: constraints.maxHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(height: constraints.maxHeight - 10, width: .4, color: AppColors.context(context).textGreyColor,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: _cancel(),
                    ),
                  ],
                ),
              )
            ],
          ),
        ).animate().slideX(begin: 1, end: 0, duration: const Duration(milliseconds: 400), curve: Curves.fastEaseInToSlowEaseOut);
      }
    );
  }

  Widget _barcodeScanBar() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: AppColors.context(context).textGreyColor),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: constraints.maxWidth * .58,
                child: NoBorderTextfield(
                  maxLines: 1, 
                  prefiexIcon: null,
                  onChanged: (text){
                    
                  }, 
                  controller: _controller, 
                  hintText: 'barcode/code', 
                  labelText: '', 
                  validationCheck: (text){
                        
                  }
                )),
              SizedBox(
                width: constraints.maxWidth * .4,
                height: constraints.maxHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(height: constraints.maxHeight - 10, width: .4, color: AppColors.context(context).textGreyColor,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: FittedBox(child: _tryAgain()),
                    ),
                    Container(height: constraints.maxHeight - 10, width: .4, color: AppColors.context(context).textGreyColor,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: _cancel(),
                    ),
                  ],
                ),
              )
            ],
          ),
        ).animate().slideX(begin: 1, end: 0, duration: const Duration(milliseconds: 400), curve: Curves.fastEaseInToSlowEaseOut);
      }
    );
  }

  Widget _search(){
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          children: [
            Container(height: constraints.maxHeight - 10, width: .4, color: AppColors.context(context).textGreyColor),
            Hero(
              tag: ShowBar.searchbar.name,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      showBar = ShowBar.searchbar;
                    });
                  },
                  borderRadius: BorderRadius.circular(6),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                    child: Icon(Icons.search, ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _barcodeScan(){
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          children: [
            
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  setState(() {
                    showBar = ShowBar.scanbar;
                  });
                },
                borderRadius: BorderRadius.circular(6),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                  child: Icon(Icons.qr_code_scanner,),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _categories({required BoxConstraints constraints}) {
    return SizedBox(
      width: constraints.maxWidth,
      child: Material(
        color: Colors.transparent,
        child: DropdownButton(
          alignment: Alignment.center,
          iconSize: 30,
          borderRadius: BorderRadius.circular(6),
          //isDense: true,
          enableFeedback: true,
          underline: Container(),
          isExpanded: true,
          padding: const EdgeInsets.all(8),
          hint: Text(selectedCategoryName),
          onChanged: (categoryName) {
            if(categoryName != null) {
              setState(() {
                selectedCategoryName = categoryName;
              });
            }
          },
          items: categoryList.map((categoryName) {
            return DropdownMenuItem(
              value: categoryName, 
              child: Container(
                padding: const EdgeInsets.all(4),
                child: Text(categoryName),
              ), 
            );
          }
        ).toList()),
      ),
    );
  }

  Widget _cancel() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(2),
            onTap: () {
              setState(() {
                showBar = ShowBar.fullbar;
                animateFullBar = true;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text("Cancel", style: Theme.of(context).textTheme.labelLarge?.copyWith(color: AppColors.context(context).textGreyColor),)
            )),
        );
      },
    );
  }

  Widget _tryAgain() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(2),
            onTap: () {
              setState(() {
                showBar = ShowBar.fullbar;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Try", style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColors.context(context).accentColor),),
                  Text("again", style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColors.context(context).accentColor),)
                ],
              ),
            )),
        );
      },
    );
  }
}