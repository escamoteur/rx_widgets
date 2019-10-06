import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rx_widgets/src/reactive_builder.dart';

void main() {
  testWidgets("When stream receive a data ", (tester) async {
    var _controller = StreamController<String>();

    var widget = ReactiveBuilder<String>(
      stream: _controller.stream,
      builder: (_, data) => MaterialApp(home: Text(data)),
    );

    _controller.add("Hello");
    await tester.pumpWidget(widget);
    await tester.pump(Duration.zero);

    final textFinder = find.text('Hello');

    expect(textFinder, findsOneWidget);

    _controller.close();
  });

  testWidgets(
      "When not receive any data and no streamEmptyBuilder is passed - Expected the CircularProgressIndicator",
      (tester) async {
    var _controller = StreamController<String>();

    var widget = ReactiveBuilder<String>(
      stream: _controller.stream,
      builder: (_, data) => MaterialApp(home: Text(data)),
    );

    await tester.pumpWidget(widget);
    await tester.pump(Duration.zero);

    final textFinder = find.byType(CircularProgressIndicator);

    expect(textFinder, findsOneWidget);

    _controller.close();
  });

  testWidgets(" When not receive any data - Expected text containing Loading",
      (tester) async {
    var _controller = StreamController<String>();

    var widget = MaterialApp(
        home: ReactiveBuilder<String>(
      stream: _controller.stream,
      builder: (_, data) => Text(data),
      streamEmptyBuilder: (_) => Container(
        child: Text("Loading"),
      ),
    ));

    await tester.pumpWidget(widget);
    await tester.pump(Duration.zero);

    final textFinder = find.widgetWithText(Container, "Loading");

    expect(textFinder, findsOneWidget);

    _controller.close();
  });

  testWidgets(
      "When ReactiveBuilder receive a erro and no errorBuilder is passed",
      (tester) async {
    var _controller = StreamController<String>();

    var widget = MaterialApp(
        home: ReactiveBuilder<String>(
      stream: _controller.stream,
      builder: (_, data) => Text(data),
    ));

    _controller.addError("Error");
    await tester.pumpWidget(widget);
    await tester.pump(Duration.zero);

    final textFinder = find.text("Error");

    expect(textFinder, findsOneWidget);

    _controller.close();
  });

  testWidgets("When ReactiveBuilder receive a erro", (tester) async {
    var _controller = StreamController<String>();

    var widget = MaterialApp(
        home: ReactiveBuilder<String>(
      stream: _controller.stream,
      builder: (_, data) => Text(data),
      errorBuilder: (_, error) => Text(error),
    ));

    _controller.addError("Custom Error");
    await tester.pumpWidget(widget);
    await tester.pump(Duration.zero);

    final textFinder = find.text("Custom Error");

    expect(textFinder, findsOneWidget);

    _controller.close();
  });

  testWidgets("when it is initialized with initialData value.", (tester) async {
    var _controller = StreamController<String>();
    var key = Key("Initial");
    var widget = MaterialApp(
        home: ReactiveBuilder<String>(
      stream: _controller.stream,
      builder: (_, data) => Text(data, key: key),
      initialData: "Test",
    ));

    await tester.pumpWidget(widget);
    await tester.pump(Duration.zero);

    final textFinder = find.byKey(key);
    final textFinderText = find.text("Test");

    expect(textFinderText, findsOneWidget);
    expect(textFinder, findsOneWidget);

    _controller.close();
  });
}
