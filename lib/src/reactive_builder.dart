import 'package:flutter/widgets.dart';
import 'package:rx_widgets/src/builder_functions.dart';
import 'package:rx_widgets/src/reactive_widget.dart';

class ReactiveBuilder<T> extends ReactiveBuilderBase<T> {
  final RxBuilder<T> builder;

  const ReactiveBuilder({
    Key key,
    @required Stream<T> stream,
    T initialData,
    @required this.builder,
    EmptyBuilder streamEmptyBuilder,
    ErrorBuilder<T> errorBuilder,
  }) : super(
            stream: stream,
            initialData: initialData,
            streamEmptyBuilder: streamEmptyBuilder,
            errorBuilder: errorBuilder,
            key: key);

  @override
  Widget build(BuildContext context, T data) => builder(context, data);
}

abstract class ReactiveBuilderBase<T> extends ReactiveWidget<T> {
  final ErrorBuilder<T> errorBuilder;
  final EmptyBuilder streamEmptyBuilder;

  const ReactiveBuilderBase({
    Key key,
    @required Stream<T> stream,
    T initialData,
    this.streamEmptyBuilder,
    this.errorBuilder,
  }) : super(stream, initialData, key: key);

  @override
  Widget streamEmptyBuild(BuildContext context) {
    return streamEmptyBuilder != null
        ? streamEmptyBuilder(context)
        : super.streamEmptyBuild(context);
  }

  @override
  Widget errorBuild(BuildContext context, Object error) {
    return errorBuilder != null
        ? errorBuilder(context, error)
        : super.errorBuild(context, error);
  }
}
