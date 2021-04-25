import 'package:flutter/widgets.dart';

import 'builder_functions.dart';
import 'reactive_base_widget.dart';

class ReactiveWidget<T> extends ReactiveBaseWidget<T> {
  final RxWidget<T> widget;
  final RxErrorWidget<T>? errorWidget;
  final Widget? placeHolderWidget;

  const ReactiveWidget({
    Key? key,
    required Stream<T> stream,
    T? initialData,
    required this.widget,
    this.placeHolderWidget,
    this.errorWidget,
  }) : super(stream, initialData, key: key);

  @override
  Widget build(BuildContext context, T data) => widget(data);

  @override
  Widget placeHolderBuild(BuildContext context) {
    if (placeHolderWidget != null) return placeHolderWidget!;
    return super.placeHolderBuild(context);
  }

  @override
  Widget errorBuild(BuildContext context, Object? error) {
    if (errorWidget != null) return errorWidget!(error);
    return super.errorBuild(context, error);
  }
}
