import '../../../image/ui/widgets/show_round_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../the_app/providers/current_app_user_provider.dart';
/// A tile indicating user with image and full name from top to bottom (column style). Tile color is transparent.
class UserImageNamePreviewTile extends StatefulWidget {
  final String userId;
  final String? userName;
  const UserImageNamePreviewTile({super.key, required this.userId, this.userName,});

  @override
  State<UserImageNamePreviewTile> createState() => _UserImageNamePreviewTileState();
}

class _UserImageNamePreviewTileState extends State<UserImageNamePreviewTile> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return FutureBuilder(
          future: context.read<CurrentAppUserProvider>().fetchUserInfo(userId: widget.userId),
          builder:(context, snapshot) {
            switch (snapshot.hasData && snapshot.data != null) {
              case true:
                final user = snapshot.data!;
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            ShowRoundImage(imageUrl: user.imageUrl, radius: 45,),
                            Padding(
                              padding: const EdgeInsets.only(left: 6.0),
                              child: Text(user.fullName, style: Theme.of(context).textTheme.labelLarge,),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              case false:
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(800000000)
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 6.0),
                          child: Text(widget.userName ?? '', style: Theme.of(context).textTheme.labelLarge,),
                        )
                      ],
                    ),
                  ),
                );
              default:
                return Container();
            }
          },
        );
      },
    );
  }


}