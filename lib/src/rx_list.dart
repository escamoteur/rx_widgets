import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'builder_functions.dart';
import 'reactive_builder.dart';

class RxList<T> extends ReactiveBuilder<BuiltList<T>> {
  const RxList({
    Key key,
    BuiltList<T> initialData,
    @required Stream<BuiltList<T>> stream,
    @required RxBuilder<BuiltList<T>> builder,
    PlaceHolderBuilder placeHolderBuilder,
    this.emptyListBuilder,
    ErrorBuilder<T> errorBuilder,
  })  : assert(stream != null),
        assert(builder != null),
        super(
          key: key,
          stream: stream,
          builder: builder,
          placeHolderBuilder: placeHolderBuilder,
          errorBuilder: errorBuilder,
        );

  final EmptyListBuilder emptyListBuilder;

  @override
  Widget build(BuildContext context, BuiltList<T> data) {
    if (data.isEmpty) {
      if (emptyListBuilder != null) return emptyListBuilder(context);

      return _DefaultEmptyList();
    }

    return super.build(context, data);
  }
}

class _DefaultEmptyList extends StatelessWidget {
  const _DefaultEmptyList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Empty List'),
    );
  }
}
