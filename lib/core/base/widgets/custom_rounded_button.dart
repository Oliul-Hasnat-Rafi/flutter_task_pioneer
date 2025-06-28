
import 'package:flutter/material.dart';
import 'package:flutter_task/core/base/widgets/custom_elevated_button_widget.dart' show CustomElevatedButton;

import '../../values/app_values.dart';

class CustomRoundedButton extends StatelessWidget {
  final Future<bool?>? Function()? onTap;
  final dynamic Function(bool? _)? onDone;
  final void Function()? onLongPress;
  final Widget? child;
  final Widget? notificationChild;
  final bool enable;
  final Color? iconColor;
  final Color backgroundColor;
  final Duration statusShowingDuration;
  final EdgeInsetsGeometry? margin;

  const CustomRoundedButton({
    super.key,
    this.onTap,
    this.child,
    this.enable = true,
    this.onLongPress,
    this.iconColor,
    this.backgroundColor = Colors.transparent,
    this.onDone,
    this.statusShowingDuration = const Duration(seconds: 2),
    this.notificationChild,
    this.margin = const EdgeInsets.all(AppValues.padding / 4),
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomElevatedButton(
          statusShowingDuration: statusShowingDuration,
          enable: enable,
          iconColor: iconColor ?? Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(100),
          height:AppValues. defaultBoxHeight - AppValues.padding / 4,
          width:AppValues. defaultBoxHeight - AppValues.padding / 4,
          constraints: const BoxConstraints(maxHeight: AppValues.defaultBoxHeight, maxWidth:AppValues. defaultBoxHeight),
          backgroundColor: backgroundColor,
          margin: margin,
          contentPadding: const EdgeInsets.all(AppValues.padding / 2),
          onTap: onTap,
          onDone: onDone,
          onLongPress: onLongPress,
          child: FittedBox(child: child),
        ),
        if (notificationChild != null)
          Positioned(
            right: AppValues.padding / 4,
            top: AppValues.padding / 4,
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
              alignment: Alignment.center,
              height: AppValues.padding,
              width: AppValues.padding,
              constraints: const BoxConstraints(minHeight: AppValues.padding, minWidth: AppValues.padding),
              child: notificationChild,
            ),
          )
      ],
    );
  }
}
