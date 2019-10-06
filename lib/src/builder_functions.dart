import 'package:flutter/widgets.dart';

typedef RxBuilder<T> = Widget Function(BuildContext context, T data);
typedef ErrorBuilder<T> = Widget Function(BuildContext context, Object error);
typedef EmptyBuilder = Widget Function(BuildContext context);
typedef PlaceHolderBuilder = Widget Function(BuildContext context);
