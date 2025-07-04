import 'package:flutter/material.dart';
import 'package:flutter_task/core/values/app_values.dart';

class CustomSizeBuilder extends StatelessWidget {
  const CustomSizeBuilder({
    super.key,
    required this.child,
    this.constraints,
    this.alignment = Alignment.center,
    this.maxSize,
  });
  final Widget child;
  final BoxConstraints? constraints;
  final AlignmentGeometry? alignment;
  final double? maxSize;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, box) => Container(
        alignment: alignment,
        child: Container(
          height: box.maxHeight,
          width: box.maxWidth,
          constraints: constraints ?? BoxConstraints(maxHeight: maxSize ?? AppValues.padding, maxWidth: maxSize ?? AppValues.padding),
          child: FittedBox(
            child: child,
          ),
        ),
      ),
    );
  }
}
