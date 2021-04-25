import 'package:flutter/widgets.dart';

typedef RxBuilder<T> = Widget Function(BuildContext context, T data);
typedef ErrorBuilder<T> = Widget Function(BuildContext context, Object? error);
typedef BusyBuilder = Widget Function(BuildContext context);
typedef PlaceHolderBuilder = Widget Function(BuildContext context);

typedef RxWidget<T> = Widget Function(T data);
typedef RxErrorWidget<T> = Widget Function(Object? error);
