import 'dart:async';

import 'package:flutter/widgets.dart';

import 'builder_functions.dart';
import 'reactive_base_widget.dart';

/// `WidgetSelector`is a convenience class that will return one of two Widgets based on the output of a `Stream<bool>`
/// This is pretty handy if you want to react to state change like enable/disable in you ViewModel and update
/// the View accordingly.
/// If you don't need builders for the alternative child widgets this class offers a more concise expression than `WidgetBuilderSelector`
class WidgetSelector extends ReactiveBaseWidget<bool> {
  final Widget? onTrue;
  final Widget? onFalse;
  final ErrorBuilder<String>? errorBuilder;
  final PlaceHolderBuilder? placeHolderBuilder;

  /// Creates a new WidgetSelector instance
  /// `stream` : `Stream<bool>`that signals that the this Widget should be updated
  /// `onTrue` : Widget that should be returned if an item with value true is received
  /// `onFalse`: Widget that should be returned if an item with value false is received
  const WidgetSelector({
    Key? key,
    required Stream<bool> buildEvents,
    this.onTrue,
    this.onFalse,
    this.errorBuilder,
    this.placeHolderBuilder,
    bool? initialValue,
  }) : super(buildEvents, initialValue, key: key);

  @override
  Widget build(BuildContext context, data) {
    if (data) return onTrue ?? SizedBox();
    return onFalse ?? SizedBox();
  }

  @override
  Widget placeHolderBuild(BuildContext context) {
    if (placeHolderBuilder != null) return placeHolderBuilder!(context);
    return onFalse ?? SizedBox();
  }

  @override
  Widget errorBuild(BuildContext context, Object error) {
    if (errorBuilder != null) return errorBuilder!(context, error);
    return onFalse ?? SizedBox();
  }
}

/// `WidgetBuilderSelector`is a convenience class that will one of two builder methods based on the output of a `Stream<bool>`
/// This is pretty handy if you want to react to state change like enable/disable in you ViewModel and update
/// the View accordingly.
/// In comparison to `WidgetSelector` this is best used if the alternative child widgets are large so that you don't want to have them created
/// without using them.
class WidgetBuilderSelector extends ReactiveBaseWidget<bool> {
  final WidgetBuilder? onTrue;
  final WidgetBuilder? onFalse;
  final ErrorBuilder<String>? errorBuilder;
  final PlaceHolderBuilder? placeHolderBuilder;

  /// Creates a new WidgetBuilderSelector instance
  /// `stream` : `Stream<bool>`that signals that the this Widget should be updated
  /// `onTrue` : builder that should be executed if an item with value true is received
  /// `onFalse`: builder that should be executed if an item with value false is received
  const WidgetBuilderSelector({
    required Stream<bool> buildEvents,
    this.onTrue,
    this.onFalse,
    this.errorBuilder,
    this.placeHolderBuilder,
    Key? key,
    bool? initialValue,
  }) : super(buildEvents, initialValue, key: key);

  Widget onTrueWidget(BuildContext context) {
    if (onTrue != null) {
      return onTrue!(context);
    } else {
      return SizedBox();
    }
  }

  Widget onFalseWidget(BuildContext context) {
    if (onFalse != null) {
      return onFalse!(context);
    } else {
      return SizedBox();
    }
  }

  @override
  Widget build(BuildContext context, data) {
    if (data) return onTrueWidget(context);
    return onFalseWidget(context);
  }

  @override
  Widget placeHolderBuild(BuildContext context) {
    if (placeHolderBuilder != null) return placeHolderBuilder!(context);
    return onFalseWidget(context);
  }

  @override
  Widget errorBuild(BuildContext context, Object error) {
    if (errorBuilder != null) return errorBuilder!(context, error);
    return onFalseWidget(context);
  }
}
