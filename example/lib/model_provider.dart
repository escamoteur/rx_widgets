import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rx_widget_demo/homepage/homepage_model.dart';

// InheritedWidgets allow you to propagate values down the Widget Tree.
// it can then be accessed by just writing  TheViewModel.of(context)
class ModelProvider extends InheritedWidget {
  final HomePageModel model;

  const ModelProvider({Key? key, required this.model, required Widget child})
      : super(key: key, child: child);

  static HomePageModel of(BuildContext context) {
    final type = context.dependOnInheritedWidgetOfExactType<ModelProvider>();
    final model = type?.model;
    assert(model != null);
    return model!;
  }

  @override
  bool updateShouldNotify(ModelProvider oldWidget) => model != oldWidget.model;
}
