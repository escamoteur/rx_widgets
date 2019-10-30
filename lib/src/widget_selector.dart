import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:rx_widgets/src/reactive_widget.dart';
import 'builder_functions.dart';

/// `WidgetSelector`is a convenience class that will return one of two Widgets based on the output of a `Stream<bool>`
/// This is pretty handy if you want to react to state change like enable/disable in you ViewModel and update
/// the View accordingly.
/// If you don't need builders for the alternative child widgets this class offers a more concise expression than `WidgetBuilderSelector`

class WidgetSelector extends ReactiveWidget<bool> {
  final Widget onTrue;
  final Widget onFalse;
  final ErrorBuilder<String> errorBuilder;
  final PlaceHolderBuilder placeHolderBuilder;

  /// Creates a new WidgetSelector instance
  /// `stream` : `Stream<bool>`that signals that the this Widget should be updated
  /// `onTrue` : Widget that should be returned if an item with value true is received
  /// `onFalse`: Widget that should be returned if an item with value false is received

  const WidgetSelector(
      {Stream<bool> stream,
      this.onTrue,
      this.onFalse,
      this.errorBuilder,
      this.placeHolderBuilder,
      bool initialValue,
      Key key})
      : assert(stream != null),
        assert(onTrue != null),
        assert(onFalse != null),
        super(stream, initialValue, key: key);

  @override
  Widget build(BuildContext context, data) {
    if (data) return onTrue;
    return onFalse;
  }

  @override
  Widget placeHolderBuild(BuildContext context) {
    if (placeHolderBuilder != null) return placeHolderBuilder(context);
    return onFalse;
  }

  @override
  Widget errorBuild(BuildContext context, Object error) {
    if (errorBuilder != null) return errorBuilder(context, error);
    return onFalse;
  }
}

/// `WidgetBuilderSelector`is a convenience class that will one of two builder methods based on the output of a `Stream<bool>`
/// This is pretty handy if you want to react to state change like enable/disable in you ViewModel and update
/// the View accordingly.
/// In comparrison to `WidgetSelector` this is best used if the alternative child widgets are large so that you don't want to have them created
/// without using them.
class WidgetBuilderSelector extends ReactiveWidget<bool> {
  final WidgetBuilder onTrue;
  final WidgetBuilder onFalse;
  final ErrorBuilder<String> errorBuilder;
  final PlaceHolderBuilder placeHolderBuilder;

  /// Creates a new WidgetBuilderSelector instance
  /// `stream` : `Stream<bool>`that signals that the this Widget should be updated
  /// `onTrue` : builder that should be executed if an item with value true is received
  /// `onFalse`: builder that should be executed if an item with value false is received
  const WidgetBuilderSelector({
    Stream<bool> stream,
    this.onTrue,
    this.onFalse,
    this.errorBuilder,
    this.placeHolderBuilder,
    Key key,
    bool initialValue,
  })  : assert(stream != null),
        assert(onTrue != null),
        assert(onFalse != null),
        super(stream, initialValue, key: key);

  @override
  Widget build(BuildContext context, data) {
    if (data) return onTrue(context);
    return onFalse(context);
  }

  @override
  Widget placeHolderBuild(BuildContext context) {
    if (placeHolderBuilder != null) return placeHolderBuilder(context);
    return onFalse(context);
  }

  @override
  Widget errorBuild(BuildContext context, Object error) {
    if (errorBuilder != null) return errorBuilder(context, error);
    return onFalse(context);
  }
}
