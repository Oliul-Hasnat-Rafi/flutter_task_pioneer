import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_task/core/base/widgets/size_builder.dart';

import '../../utils/image_conversion.dart';


class PictureFrom64 extends StatelessWidget {
  const PictureFrom64({
    super.key,
    this.image64,
    this.placeholder = Icons.no_photography,
    this.fit = BoxFit.cover,
    this.text,
  });
  final String? image64;
  final IconData placeholder;
  final BoxFit fit;
  final String? text;

  @override
  Widget build(BuildContext context) {
    // devPrint("PictureFromLink: ${image64?.customCutString()}");
    Widget? we;

    Uint8List? x;
    try {
      x = imageStringToByte(image64);
    } catch (e) {
    }

    if (x != null) {
      we = Image.memory(
        x,
        fit: fit,
      );
    }

    final c = Theme.of(context).colorScheme.onBackground;

    return we ??
        CustomSizeBuilder(
          child: text == null
              ? Icon(placeholder, color: c)
              : FittedBox(
                  child: Text(text!, style: Theme.of(context).textTheme.titleLarge?.copyWith(color: c)),
                ),
        );
  }
}

class PictureFromLink extends StatelessWidget {
  const PictureFromLink({
    super.key,
    this.imageLink,
    this.placeholder = Icons.no_photography,
    this.fit = BoxFit.cover,
    this.loadingBuilder,
    this.padding,
    this.onErrorWidget,
    this.scale = 1,
  });
  final String? imageLink;
  final IconData placeholder;
  final BoxFit fit;
  final Widget Function(BuildContext context, Widget child, ImageChunkEvent? loadingProgress)? loadingBuilder;
  final EdgeInsetsGeometry? padding;
  final Widget? onErrorWidget;
  final double scale;

  Widget w(BuildContext context) {
    return onErrorWidget == null
        ? CustomSizeBuilder(
            child: Icon(placeholder, color: Theme.of(context).colorScheme.onBackground),
          )
        : FittedBox(child: onErrorWidget);
  }

  @override
  Widget build(BuildContext context) {
    // devPrint("PictureFromLink: $imageLink");
    return FractionallySizedBox(
      widthFactor: 1,
      heightFactor: 1,
      child: imageLink == null || imageLink!.isEmpty
          ? w(context)
          : Image.network(
              imageLink ?? "",
              fit: fit,
              scale: scale,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingBuilder != null) loadingBuilder!(context, child, loadingProgress);
                if (loadingProgress?.cumulativeBytesLoaded == loadingProgress?.expectedTotalBytes) return child;
                return LinearProgressIndicator(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                );
              },
              errorBuilder: (context, error, stackTrace) => w(context),
            ),
    );
  }
}
