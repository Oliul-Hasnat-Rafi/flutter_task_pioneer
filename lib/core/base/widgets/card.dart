import 'package:flutter/material.dart';
import 'package:flutter_task/core/values/app_values.dart';
import 'package:on_process_button_widget/on_process_button_widget.dart';

class CustomCard
    extends
        StatelessWidget {
  const CustomCard({
    super.key,
    this.child,
    this.onTap,
    this.alignment =
        Alignment.center,
    this.animationAlignment =
        Alignment.topCenter,
    this.onLongPress,
    this.width,
    this.margin,
    this.contentPadding,
    this.isActive =
        true,
    this.constraints,
    this.backgroundColor,
    this.boxShadow,
    this.onDone,
    this.fontColor,
    this.borderRadius = const BorderRadius.all(
      Radius.circular(
        8,
      ),
    ),
  });
  final Widget? child;
  final Future<
    bool?
  >?
  Function()?
  onTap;
  final Function()? onLongPress;
  final AlignmentGeometry alignment;
  final AlignmentGeometry animationAlignment;
  final double? width;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? contentPadding;
  final bool isActive;
  final BoxConstraints? constraints;
  final Color? backgroundColor;
  final List<
    BoxShadow
  >?
  boxShadow;
  final dynamic Function(
    bool? _,
  )?
  onDone;
  final Color? fontColor;
  final BorderRadius borderRadius;

  @override
  Widget build(
    BuildContext context,
  ) {
    final c =
        Theme.of(
          context,
        ).colorScheme.onSurface;
    return OnProcessButtonWidget(
      borderRadius:
          borderRadius,
      fontColor:
          c,
      boxShadow:
          boxShadow ??
          [],
      animationAlignment:
          animationAlignment,
      alignment:
          alignment,
      expandedIcon:
          true,
      iconColor:
          c,
      roundBorderWhenRunning:
          false,
      enable:
          onTap !=
              null ||
          onDone !=
              null,
      width:
          width,
      constraints:
          constraints,
      contentPadding:
          contentPadding ??
          EdgeInsets.all(
            AppValues.padding /
                2,
          ),
      backgroundColor:
          !isActive
              ? Colors.transparent
              : backgroundColor ??
                  c.withAlpha(
                    13,
                  ), // 0.05 opacity = 13/255
      margin:
          margin ??
          EdgeInsets.symmetric(
            vertical:
                AppValues.padding /
                4,
          ),
      onTap:
          onTap,
      onDone:
          onDone,
      onLongPress:
          onLongPress,
      child:
          child,
    );
  }
}
