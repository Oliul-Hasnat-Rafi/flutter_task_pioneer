import 'package:flutter/material.dart';
import 'package:flutter_task/core/base/widgets/picture.dart';

class CustomProfilePicture extends StatelessWidget {
  const CustomProfilePicture({
    super.key,
    this.image64,
    this.imageLink,
  });

  final String? image64;
  final String? imageLink;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 1,
      widthFactor: 1,
      child: imageLink != null && imageLink!.isNotEmpty
          ? PictureFromLink(
              imageLink: imageLink,
              placeholder: Icons.person,
            )
          : PictureFrom64(
              image64: image64,
              placeholder: Icons.person,
            ),
    );
  }
}
