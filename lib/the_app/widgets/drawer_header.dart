
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../features/image/ui/widgets/show_rect_image.dart';
import '../../features/store/ui/providers/store_data_provider.dart';

class AppDrawerHeader extends StatefulWidget {
  const AppDrawerHeader({super.key});

  @override
  State<AppDrawerHeader> createState() => _AppDrawerHeaderState();
}

class _AppDrawerHeaderState extends State<AppDrawerHeader> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return DrawerHeader(
          padding: const EdgeInsets.all(2),
          child: Stack(
            children: [
              DecoratedBox(
                position: DecorationPosition.foreground,
                decoration: BoxDecoration(
                  gradient: RadialGradient(colors: [Colors.grey.shade800, Colors.transparent], )
                ),
                child: ShowRectImage(
                  imageUrl: context.read<StoreDataProvider>().currentStore!.imageUrl,
                  height: 100,
                  width: constraints.maxWidth,
                  borderRadiusVal: 0,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  context.read<StoreDataProvider>().currentStore!.storeName, 
                  style: Theme.of(context).textTheme.titleLarge),
              )
            ],
          ),
        );
      },
    );
  }
}