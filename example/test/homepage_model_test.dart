import 'dart:async';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/src/mock.dart';
import 'package:quiver/testing/async.dart';
import 'package:rx_command/rx_command.dart';
import 'package:rx_widget_demo/homepage/homepage_model.dart';
import 'package:rx_widget_demo/service/weather_entry.dart';
import 'package:rx_widget_demo/service/weather_service.dart';
import 'package:test/test.dart';

import 'homepage_model_test.mocks.dart';

// class MockService extends Mock implements WeatherService {}
@GenerateMocks([WeatherService])
main() {
  group('HomePageModel', () {
    test(
        'should immediately fetch the weather with an empty string when the HomePageModel gets created',
        () async {
      final service = MockWeatherService();
      when(service.getWeatherEntriesForCity(any))
          .thenAnswer((_) => Future.sync(() => <WeatherEntry>[]));
      final model = HomePageModel(service);

      expect(model.updateWeatherCommand.results,
          emits(TypeMatcher<CommandResult>()));
    });

    test('should not fetch if switch is off', () async {
      final service = MockWeatherService();
      when(service.getWeatherEntriesForCity(any))
          .thenAnswer((_) => Future.sync(() => <WeatherEntry>[]));
      final model = HomePageModel(service);

      model.switchChangedCommand(false);
      model.updateWeatherCommand('A');
      verifyNever(service.getWeatherEntriesForCity('A'));
    });

    test('should filter after the user stops typing for 500ms', () async {
      // Use FakeAsync from the Quiver package to simulate time
      FakeAsync().run((time) {
        final service = MockWeatherService();
        when(service.getWeatherEntriesForCity(any))
            .thenAnswer((_) => Future.sync(() => <WeatherEntry>[]));
        final model = HomePageModel(service);

        model.textChangedCommand('A');
        time.elapse(Duration(milliseconds: 1000));

        verify(service.getWeatherEntriesForCity('A'));
      });
    });

    test('should not search if the user has not paused for 500ms', () async {
      // Use FakeAsync from the Quiver package to simulate time
      FakeAsync().run((time) {
        final service = MockWeatherService();
        when(service.getWeatherEntriesForCity(any))
            .thenAnswer((_) => Future.sync(() => <WeatherEntry>[]));
        final model = HomePageModel(service);

        model.textChangedCommand('A');
        time.elapse(Duration(milliseconds: 100));

        verifyNever(service.getWeatherEntriesForCity('A'));
      });
    });
  });
}
