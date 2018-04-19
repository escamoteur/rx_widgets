import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rx_command/rx_command.dart';
import 'package:rx_widget_demo/homepage/homepage.dart';
import 'package:rx_widget_demo/homepage/homepage_model.dart';
import 'package:rx_widget_demo/keys.dart';
import 'package:rx_widget_demo/model_provider.dart';
import 'package:rx_widget_demo/service/weather_entry.dart';
import 'package:collection/collection.dart';



class MockModel extends Mock implements HomePageModel {}

//class MockCommand<TParam,TResult> extends Mock implements RxCommand<TParam,TResult> {}


class MockStream<T>  extends Mock implements Stream<T>{}

main() {
  group('HomePage', () {
    testWidgets('Shows a loading spinner and disables the button while executing and shows the ListView on data arrival', (tester) async {
      final model = new MockModel();
      final command = new MockCommand<String,List<WeatherEntry>>();
      final widget = new ModelProvider(
        model: model,
        child: new MaterialApp(home: new HomePage()),
      );

      when(model.updateWeatherCommand).thenReturn(command);

   //   model.updateWeatherCommand.canExecute.listen((b) => print("Can exceute: $b"));
   //   model.updateWeatherCommand.isExecuting.listen((b) => print("Is Exceuting: $b"));

      print("Start pumping");
      await tester.pumpWidget(widget);// Build initial State
      print("pumping");
      await tester.pump(); 

      expect(find.byKey(AppKeys.loadingSpinner), findsNothing);
      expect(find.byKey(AppKeys.updateButtonDisabled), findsNothing);
      expect(find.byKey(AppKeys.updateButtonEnabled), findsOneWidget);
      expect(find.byKey(AppKeys.weatherList), findsNothing);
      expect(find.byKey(AppKeys.loaderError), findsNothing);
      expect(find.byKey(AppKeys.loaderPlaceHolder), findsOneWidget);


      command.startExecution();
      await tester.pump(); 
      await tester.pump();  //because there are two streams involded it seems we have to pump twice so that both streambuilders can work

      expect(find.byKey(AppKeys.loadingSpinner), findsOneWidget);
      expect(find.byKey(AppKeys.updateButtonDisabled), findsOneWidget);
      expect(find.byKey(AppKeys.updateButtonEnabled), findsNothing);
      expect(find.byKey(AppKeys.weatherList), findsNothing);
      expect(find.byKey(AppKeys.loaderError), findsNothing);
      expect(find.byKey(AppKeys.loaderPlaceHolder), findsNothing);

      command.endExecutionWithData([new WeatherEntry("London", 10.0, 30.0, "sunny", 12)]);
      await tester.pump(); // Build after Stream delivers value

      expect(find.byKey(AppKeys.loadingSpinner), findsNothing);
      expect(find.byKey(AppKeys.updateButtonDisabled), findsNothing);
      expect(find.byKey(AppKeys.updateButtonEnabled), findsOneWidget);
      expect(find.byKey(AppKeys.weatherList), findsOneWidget);
      expect(find.byKey(AppKeys.loaderError), findsNothing);
      expect(find.byKey(AppKeys.loaderPlaceHolder), findsNothing);
    });


    testWidgets('Shows a loading spinner and disables the button while executing and shows place holder due to no data', (tester) async {
      final model = new MockModel();
      final command = new MockCommand<String,List<WeatherEntry>>();
      final widget = new ModelProvider(
        model: model,
        child: new MaterialApp(home: new HomePage()),
      );

      when(model.updateWeatherCommand).thenReturn(command);

    ///  model.updateWeatherCommand.canExecute.listen((b) => print("Can exceute: $b"));
    ///  model.updateWeatherCommand.isExecuting.listen((b) => print("Is Exceuting: $b"));

      print("Start pumping");
      await tester.pumpWidget(widget);// Build initial State
      print("pumping");
      await tester.pump(); 

      expect(find.byKey(AppKeys.loadingSpinner), findsNothing);
      expect(find.byKey(AppKeys.updateButtonDisabled), findsNothing);
      expect(find.byKey(AppKeys.updateButtonEnabled), findsOneWidget);
      expect(find.byKey(AppKeys.weatherList), findsNothing);
      expect(find.byKey(AppKeys.loaderError), findsNothing);
      expect(find.byKey(AppKeys.loaderPlaceHolder), findsOneWidget);


      command.startExecution();
      await tester.pump(); 
      await tester.pump();  //because there are two streams involded it seems we have to pump twice so that both streambuilders can work

      expect(find.byKey(AppKeys.loadingSpinner), findsOneWidget);
      expect(find.byKey(AppKeys.updateButtonDisabled), findsOneWidget);
      expect(find.byKey(AppKeys.updateButtonEnabled), findsNothing);
      expect(find.byKey(AppKeys.weatherList), findsNothing);
      expect(find.byKey(AppKeys.loaderError), findsNothing);
      expect(find.byKey(AppKeys.loaderPlaceHolder), findsNothing);

      command.endExecutionWithData(null);
      await tester.pump(); // Build after Stream delivers value

      expect(find.byKey(AppKeys.loadingSpinner), findsNothing);
      expect(find.byKey(AppKeys.updateButtonDisabled), findsNothing);
      expect(find.byKey(AppKeys.updateButtonEnabled), findsOneWidget);
      expect(find.byKey(AppKeys.weatherList), findsNothing);
      expect(find.byKey(AppKeys.loaderError), findsNothing);
      expect(find.byKey(AppKeys.loaderPlaceHolder), findsOneWidget);
    });

    testWidgets('Shows a loading spinner and disables the button while executing and shows error view due to no data', (tester) async {
      final model = new MockModel();
      final command = new MockCommand<String,List<WeatherEntry>>();
      final widget = new ModelProvider(
        model: model,
        child: new MaterialApp(home: new HomePage()),
      );

      when(model.updateWeatherCommand).thenReturn(command);

//      model.updateWeatherCommand.canExecute.listen((b) => print("Can exceute: $b"));
//      model.updateWeatherCommand.isExecuting.listen((b) => print("Is Exceuting: $b"));

      print("Start pumping");
      await tester.pumpWidget(widget);// Build initial State
      print("pumping");
      await tester.pump(); 

      expect(find.byKey(AppKeys.loadingSpinner), findsNothing);
      expect(find.byKey(AppKeys.updateButtonDisabled), findsNothing);
      expect(find.byKey(AppKeys.updateButtonEnabled), findsOneWidget);
      expect(find.byKey(AppKeys.weatherList), findsNothing);
      expect(find.byKey(AppKeys.loaderError), findsNothing);
      expect(find.byKey(AppKeys.loaderPlaceHolder), findsOneWidget);


      command.startExecution();
      await tester.pump(); 
      await tester.pump();  //because there are two streams involded it seems we have to pump twice so that both streambuilders can work

      expect(find.byKey(AppKeys.loadingSpinner), findsOneWidget);
      expect(find.byKey(AppKeys.updateButtonDisabled), findsOneWidget);
      expect(find.byKey(AppKeys.updateButtonEnabled), findsNothing);
      expect(find.byKey(AppKeys.weatherList), findsNothing);
      expect(find.byKey(AppKeys.loaderError), findsNothing);
      expect(find.byKey(AppKeys.loaderPlaceHolder), findsNothing);

      command.endExecutionWithError("Intentional");
      await tester.pump(); // Build after Stream delivers value

      expect(find.byKey(AppKeys.loadingSpinner), findsNothing);
      expect(find.byKey(AppKeys.updateButtonDisabled), findsNothing);
      expect(find.byKey(AppKeys.updateButtonEnabled), findsOneWidget);
      expect(find.byKey(AppKeys.weatherList), findsNothing);
      expect(find.byKey(AppKeys.loaderError), findsOneWidget);
      expect(find.byKey(AppKeys.loaderPlaceHolder), findsNothing);
    });


 

    testWidgets('Tapping update button updates the weather', (tester) async {
      final model = new MockModel();
     final command = new MockCommand<String,List<WeatherEntry>>();
       final widget = new ModelProvider(
        model: model,
        child: new MaterialApp(home: new HomePage()),
      );

      when(model.updateWeatherCommand).thenReturn(command);

      command.queueResultsForNextExecuteCall([CommandResult<List<WeatherEntry>>(
                  [WeatherEntry("London", 10.0, 30.0, "sunny", 12)],null, false)]);

      expect(command, emitsInOrder([ crm(null, false, false), crm([WeatherEntry("London", 10.0, 30.0, "sunny", 12)], false, false) ]));

      command.listen((data)=> print("Received: " + data.data.toString()));

      await tester.pumpWidget(widget); // Build initial State
      await tester.pump(); // Build after Stream delivers value
      await tester.tap(find.byKey(AppKeys.updateButtonEnabled));
      await tester.pump(); // Build after Stream delivers value
      await tester.pump(); // Build after Stream delivers value


    });
/*
    testWidgets('update button updates using the text filter', (tester) async {
      final model = new MockModel();
      final command = new MockCommand();
      final widget = new ModelProvider(
        model: model,
        child: new MaterialApp(home: new HomePage()),
      );

      when(command.canExecute).thenAnswer((_) => new Observable.just(true));
      when(model.updateWeatherCommand).thenReturn(command);

      await tester.pumpWidget(widget); // Build initial State
      await tester.enterText(find.byKey(AppKeys.textField), 'Berlin');
      await tester.pump(); // Build after text entered
      await tester.tap(find.byKey(AppKeys.updateButton));

      verify(model.updateWeatherCommand('Berlin'));
    });

    testWidgets('cannot tap update button when disabled', (tester) async {
      final model = new MockModel();
      final command = new MockCommand();
      final widget = new ModelProvider(
        model: model,
        child: new MaterialApp(home: new HomePage()),
      );

      when(command.canExecute).thenAnswer((_) => new Observable.just(false));
      when(model.updateWeatherCommand).thenReturn(command);

      await tester.pumpWidget(widget); // Build initial State
      await tester.pump(); // Build after Stream delivers value
      await tester.tap(find.byKey(AppKeys.updateButton));

      verifyNever(model.updateWeatherCommand(''));
    });

    testWidgets('tapping switch toggles model', (tester) async {
      final model = new MockModel();
      final updateCommand = new MockCommand();
      final switchCommand = new MockCommand();
      final widget = new ModelProvider(
        model: model,
        child: new MaterialApp(home: new HomePage()),
      );

      when(model.updateWeatherCommand).thenReturn(updateCommand);
      when(updateCommand.isExecuting)
          .thenAnswer((_) => new Observable.just(true));
      when(model.switchChangedCommand).thenReturn(switchCommand);

      await tester.pumpWidget(widget); // Build initial State
      await tester.pumpWidget(widget); // Build initial State
      await tester.tap(find.byKey(AppKeys.updateSwitch));

      // Starts out true, tapping should go false
      verify(switchCommand.call(false));
    });*/
  });
}


  StreamMatcher crm(List<WeatherEntry> data, bool hasError, bool isExceuting)
  {
      return new StreamMatcher((x) async {
                                              CommandResult<List<WeatherEntry>> event =  await x.next;
                                              if (event.data != null)
                                              {
                                                 if (!ListEquality().equals(event.data, data))
                                                 {
                                                   return "Data not equal";
                                                 }
                                              }    

                                              if (!hasError && event.error != null)
                                                return "Had error while not expected";

                                              if (hasError && !(event.error is Exception))
                                                return "Wong error type";

                                              if (event.isExecuting != isExceuting)
                                                return "Wong isExecuting $isExceuting";

                                              return null;
                                          }, "Wrong value emmited:");
  }
