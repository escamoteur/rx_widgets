import 'package:flutter/material.dart';
import 'package:rx_command/rx_command.dart';

/// a reimplementation of a  `RaisedButton` where the `onPressed` is replaced with `rxCommand`
/// so the button gets disabled if the `rxCommand` has the `canExecute` set to `false` or when it is executing
class RxRaisedButton extends StatelessWidget {
  final RxCommand<BuildContext, void> rxCommand;
  final ValueChanged<bool>? onHighlightChanged;
  final ButtonTextTheme? textTheme;
  final Color? textColor;
  final Color? disabledTextColor;
  final Color? color;
  final Color? disabledColor;
  final Color? highlightColor;
  final Color? splashColor;
  final Brightness? colorBrightness;
  final double? elevation;
  final double? highlightElevation;
  final double? disabledElevation;
  final EdgeInsetsGeometry? padding;
  final ShapeBorder? shape;
  final Clip clipBehavior = Clip.none;
  final MaterialTapTargetSize? materialTapTargetSize;
  final Duration? animationDuration;
  final Widget? child;

  RxRaisedButton({
    Key? key,
    this.child,
    required this.rxCommand,
    this.onHighlightChanged,
    this.textTheme,
    this.textColor,
    this.disabledTextColor,
    this.color,
    this.disabledColor,
    this.highlightColor,
    this.splashColor,
    this.colorBrightness,
    this.elevation,
    this.highlightElevation,
    this.disabledElevation,
    this.padding,
    this.shape,
    this.materialTapTargetSize,
    this.animationDuration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: rxCommand.canExecute,
      builder: (context, snapshot) {
        // ignore: deprecated_member_use
        return RaisedButton(
          onPressed: snapshot.hasData ? () => rxCommand() : null,
          onHighlightChanged: onHighlightChanged,
          textTheme: textTheme,
          textColor: textColor,
          disabledTextColor: disabledTextColor,
          color: color,
          disabledColor: disabledColor,
          highlightColor: highlightColor,
          splashColor: splashColor,
          colorBrightness: colorBrightness,
          elevation: elevation,
          highlightElevation: highlightElevation,
          disabledElevation: disabledElevation,
          padding: padding,
          shape: shape,
          clipBehavior: clipBehavior,
          materialTapTargetSize: materialTapTargetSize,
          animationDuration: animationDuration,
          child: child,
        );
      },
    );
  }
}
