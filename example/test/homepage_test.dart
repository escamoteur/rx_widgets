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


 

    testWidgets('Tapping update button updates the weather', (tester) async {
      final model = new MockModel();
     final command = new MockCommand<String,List<WeatherEntry>>();
       final widget = new ModelProvider(
        model: model,
        child: new MaterialApp(home: new HomePage()),
      );

      when(model.updateWeatherCommand).thenReturn(command);

      // Expectation doesn't match output an exception is thwon inside Flutter. 
      // Change `Londo` to `London` and it will run again
      command.queueResultsForNextExecuteCall([CommandResult<List<WeatherEntry>>(
                  [WeatherEntry("Londo", 10.0, 30.0, "sunny", 12)],null, false)]);

      expect(command, emitsInOrder([ crm(null, false, false), crm([WeatherEntry("London", 10.0, 30.0, "sunny", 12)], false, false) ]));

      command.listen((data)=> print("Received: " + data.data.toString()));

      await tester.pumpWidget(widget); // Build initial State
      await tester.pump(); // Build after Stream delivers value
      await tester.tap(find.byKey(AppKeys.updateButtonEnabled));


    });
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
