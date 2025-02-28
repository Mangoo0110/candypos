import 'dart:typed_data';

import 'package:candypos/core/common/textfields/name_textfield.dart';
import 'package:candypos/core/common/textfields/num_textfield.dart';
import 'package:candypos/core/utils/constants/app_colors.dart';
import 'package:candypos/core/utils/constants/app_sizes.dart';

import '../../../../../core/common/textfields/description_textfield.dart';
import '../../../../../core/common/widgets/text_widgets.dart';
import '../../../../../the_app/providers/current_app_user_provider.dart';
import '../../../../../the_app/providers/inventory_data_provider.dart';
import '../../../../image/ui/widgets/upload_image.dart';
import '../../../unit/domain/entities/unit.dart';
import '../notifiers/edit_item_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/item.dart';
import '../widgets/item_save_button.dart';

class EditItemUi extends StatefulWidget {
  final Item? modifyingItem;
  final Uint8List? itemImage;

  /// Key: category's id
  /// ***
  /// Value: category's name
  final Map<String, String> allCategories = CategoryData.instance.categories.map((key, value) => MapEntry(key, value.name));
  final Map<String, Uint8List?> categoryImages = CategoryImageData.instance.images;
  EditItemUi({super.key, this.modifyingItem, this.itemImage,});

  @override
  State<EditItemUi> createState() => _EditItemUiState();
}

class _EditItemUiState extends State<EditItemUi> {

  late TextEditingController _itemNameController;
  late TextEditingController _skuController;
  late TextEditingController _barcodeController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;

  @override
  void initState() {
    super.initState();
    _itemNameController = TextEditingController(text: widget.modifyingItem?.itemName);
    _skuController = TextEditingController(text: widget.modifyingItem?.baseVariant.sku);
    _barcodeController = TextEditingController(text: widget.modifyingItem?.baseVariant.barcode);
    _descriptionController = TextEditingController(text: widget.modifyingItem?.description);
    _priceController = TextEditingController(text: widget.modifyingItem?.baseVariant.price.toString());
  }

  @override
  void dispose() {
    _itemNameController.dispose();
    _skuController.dispose();
    _barcodeController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EditItemNotifier>(
      create: (context) => EditItemNotifier(widget.modifyingItem,
          context.read<CurrentAppUserProvider>().currentAppUser!.userAuth),
      child: LayoutBuilder(
        builder: (context, constraints) {
          
          return Scaffold(
              backgroundColor: AppColors.context(context).contentBoxColor,
              appBar: AppBar(
                leading: CloseButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: TextWidgets(context).createUpdateAppbarTitle(
                  titleText: widget.modifyingItem == null
                      ? "Create item"
                      : "Update item",
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 0.0),
                    child: ItemSaveButton(
                        saveStatusNotifier:
                            context.read<EditItemNotifier>().saveStatusNotifier,
                        onSave: () async {
                          await context.read<EditItemNotifier>().save(context.read<CurrentAppUserProvider>().currentAppUser!.userAuth);
                        },
                        onSuccess: () {
                          Navigator.pop(context);
                        }),
                  )
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  
                      Center(child: UploadImage(
                        onPick: (pickedImage) {
                          context.read<EditItemNotifier>().itemImage = pickedImage;
                        },
                        image: widget.itemImage,
                      )),
                      SizedBox(height: 30),
                      
                      Flexible(child: _details()),

                      Flexible(child: _priceAndInventory()),
                      
                    ],
                  ),
                ),
              )
            );
        },
      ),
    );
  }

  Widget _section({required String sectionName, required Widget child}) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(sectionName, style: Theme.of(context).textTheme.titleLarge,),
            SizedBox(
              height: 20,
            ),

            // child
            child,

            SizedBox(
              height: 10,
            ),
            Container(
              height: 10,
              width: constraints.maxWidth,
              decoration: BoxDecoration(
                color: AppColors.context(context).dividerColor,
                borderRadius: AppSizes.maxCircularRadius,
              ),
            ),

            SizedBox(
              height: 40,
            ),
          ],
        );
      },
    );
  }

  Widget _details(){
    double inputFieldHeight = 65;
    return LayoutBuilder(
      builder:(context, constraints) {
        return _section(
          sectionName:  "Details", 
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [

              // Item name
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: SizedBox(
                    height: inputFieldHeight,
                    child: NameTextfield(
                      maxLines: 10,
                      onChanged: (value) {
                        context.read<EditItemNotifier>().itemName = value;
                      },
                      controller: _itemNameController,
                      hintText:
                          "e.g. coconut oil or lether shoe or butter nun...",
                      labelText: "Item name",
                      validationCheck: (value) {
                          
                      },
                    ),
                  ),
                ),

              // description input
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: SizedBox(
                    height: inputFieldHeight * 3,
                    child: DescriptionTextfield(
                      maxLines: 10,
                      onChanged: (value) {
                        context.read<EditItemNotifier>().description = value;
                      },
                      controller: _descriptionController,
                      hintText:
                          "Short description about the item...",
                      labelText: "DESCRIPTION",
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: SelectCategoriesButton(),
                ),
            ],
          )
        );
      } ,
    );
  }


  Widget _priceAndInventory(){
    double inputFieldHeight = 65;
    return LayoutBuilder(
      builder:(context, constraints) {
        return _section(
          sectionName:  "Price and inventory",
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [              

              // barcode input
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: SizedBox(
                  height: inputFieldHeight,
                  child: NameTextfield(
                    prefiexIcon: Icons.qr_code_scanner,
                    maxLines: 10,
                    onChanged: (value) {
                      context.read<EditItemNotifier>().baseVariant.barcode = value;
                    },
                    controller: _barcodeController,
                    hintText:
                        "Barcode/ID of the item..",
                    labelText: "Barcode",
                    validationCheck: (value) {
                    },
                  ),
                ),
              ),
              
          
              // sku input
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: SizedBox(
                  height: inputFieldHeight,
                  child: NameTextfield(
                    prefiexIcon: Icons.numbers,
                    maxLines: 10,
                    onChanged: (value) {
                      context.read<EditItemNotifier>().baseVariant.sku = value;
                    },
                    controller: _skuController,
                    hintText:
                        "Unique inventory SKU of the item..",
                    labelText: "SKU",
                    validationCheck: (value) {
                      
                    },
                  ),
                ),
              ),

              // price input
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: SizedBox(
                  height: inputFieldHeight,
                  child: NumTextfield(
                    prefiexIcon: Icons.money,
                    onlyInteger: false,
                    onTap: () {
                      
                    },
                    maxLines: 10,
                    onChanged: (value) {
                      final price = double.tryParse(value);
                      if(price != null) {
                        context.read<EditItemNotifier>().baseVariant.price = price;
                      }
                    },
                    controller: _priceController,
                    hintText:
                        "Enter the sale price..",
                    labelText: "Price",
                    validationCheck: (value) {
                      
                    },
                  ),
                ),
              ),

              // Choose unit specifier.
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: SelectItemUnit(),
                ),
              ),
            ],
          )

        );
      } ,
    );
  }
}

class SelectCategoriesButton extends StatefulWidget {
  const SelectCategoriesButton({super.key});

  @override
  State<SelectCategoriesButton> createState() => _SelectCategoriesButtonState();
}

class _SelectCategoriesButtonState extends State<SelectCategoriesButton> {

  
  @override
  Widget build(BuildContext context) {

    String categories = '';
    int cnt = 0;
    for(final mapEntry in context.read<EditItemNotifier>().categoryIdMapName.entries) {
      if(cnt != 0) categories += ',';
      categories += mapEntry.value;
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: 80,
          decoration: BoxDecoration(
            //color: AppColors.context(context).backgroundColor
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: AppColors.context(context).textColor,
              onTap: () {
                
              },
              child:  Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Categories", style: Theme.of(context).textTheme.titleMedium,),
                        categories.isNotEmpty 
                        ? Text(categories, style: Theme.of(context).textTheme.labelLarge,)
                        : Text("Tap to select categories", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic, color: AppColors.context(context).textGreyColor),),
                      ],
                    ),
                    Icon(Icons.keyboard_arrow_right),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}


class SelectItemUnit extends StatefulWidget {
  const SelectItemUnit({super.key});

  @override
  State<SelectItemUnit> createState() => _SelectItemUnitState();
}

class _SelectItemUnitState extends State<SelectItemUnit> {

  List<Unit> units = Unit.units;

  @override
  Widget build(BuildContext context) {
    context.watch<EditItemNotifier>().unit;
    return LayoutBuilder(
      builder: (context, constraints) {
        return  Container(
          decoration: BoxDecoration(
            color: AppColors.context(context).backgroundColor,
            borderRadius: AppSizes.smallBorderRadius,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Unit of the item", style: Theme.of(context).textTheme.titleMedium,),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: units.length,
                      itemBuilder: (context, index) {
                        final unit = units[index];
                        
                        return Row(
                          children: [
                            Checkbox(
                              fillColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
                                  if (!states.contains(WidgetState.selected)) {
                                    return Colors.transparent;
                                  }
                                  return AppColors.context(context).accentColor;
                                }),
                              value: context.read<EditItemNotifier>().unit == unit, 
                              onChanged: (selected) {
                                if (selected == true) {
                                  context.read<EditItemNotifier>().unit = unit;
                                }
                              },
                            ),
                  
                            Text(
                              "${unit.longName}(${unit.shortName})",
                              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                color: context.read<EditItemNotifier>().unit == unit 
                                ? AppColors.context(context).accentColor
                                : AppColors.context(context).textGreyColor
                              ),
                            )
                          ],
                        );
                      },
                    ),
                ),
              ],
            ),
          ),
        );
      
      },
    );
  }

  
}
