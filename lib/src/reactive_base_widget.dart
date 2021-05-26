import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

abstract class ReactiveBaseWidget<T> extends StatefulWidget {
  final Stream<T> stream;
  final T? initialData;

  @mustCallSuper
  const ReactiveBaseWidget(this.stream, this.initialData, {Key? key})
      : super(key: key);

  Widget build(BuildContext context, T data);

  Widget errorBuild(BuildContext context, Object error) {
    return Center(
      child: Text(error.toString()),
    );
  }

  Widget placeHolderBuild(BuildContext context) {
    if (!kIsWeb && Platform.isIOS)
      return Center(child: CupertinoActivityIndicator());
    return Center(child: CircularProgressIndicator());
  }

  @override
  _ReactiveBaseWidgetState<T> createState() => _ReactiveBaseWidgetState<T>();
}

class _ReactiveBaseWidgetState<T> extends State<ReactiveBaseWidget<T>> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      initialData: widget.initialData,
      stream: widget.stream,
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        if (snapshot.hasError)
          return widget.errorBuild(context, snapshot.error!);
        if (snapshot.hasData) return widget.build(context, snapshot.data!);
        return widget.placeHolderBuild(context);
      },
    );
  }
}
