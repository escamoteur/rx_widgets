import 'package:flutter/widgets.dart';
import 'package:rx_widgets/src/builder_functions.dart';
import 'package:rx_widgets/src/reactive_widget.dart';

class ReactiveBuilder<T> extends ReactiveWidget<T> {
  final RxBuilder<T> builder;
  final ErrorBuilder<T> errorBuilder;
  final PlaceHolderBuilder placeHolderBuilder;

  const ReactiveBuilder({
    Key key,
    @required Stream<T> stream,
    T initialData,
    @required this.builder,
    this.placeHolderBuilder,
    this.errorBuilder,
  }) : super(stream, initialData, key: key);

  @override
  Widget build(BuildContext context, T data) => builder(context, data);

  @override
  Widget placeHolderBuild(BuildContext context) {
    if (placeHolderBuilder != null) return placeHolderBuilder(context);
    return super.placeHolderBuild(context);
  }

  @override
  Widget errorBuild(BuildContext context, Object error) {
    if (errorBuilder != null) return errorBuilder(context, error);
    return super.errorBuild(context, error);
  }
}
