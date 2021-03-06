// Mocks generated by Mockito 5.0.5 from annotations
// in rx_widget_demo/test/homepage_test.dart.
// Do not manually edit this file.

import 'package:mockito/mockito.dart' as _i1;
import 'package:rx_command/rx_command.dart' as _i3;
import 'package:rx_widget_demo/homepage/homepage_model.dart' as _i4;
import 'package:rx_widget_demo/service/weather_entry.dart' as _i5;
import 'package:rx_widget_demo/service/weather_service.dart' as _i2;

// ignore_for_file: comment_references
// ignore_for_file: unnecessary_parenthesis

class _FakeWeatherService extends _i1.Fake implements _i2.WeatherService {}

class _FakeRxCommand<TParam, TResult> extends _i1.Fake
    implements _i3.RxCommand<TParam, TResult> {}

/// A class which mocks [HomePageModel].
///
/// See the documentation for Mockito's code generation for more information.
class MockHomePageModel extends _i1.Mock implements _i4.HomePageModel {
  MockHomePageModel() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.WeatherService get service =>
      (super.noSuchMethod(Invocation.getter(#service),
          returnValue: _FakeWeatherService()) as _i2.WeatherService);
  @override
  _i3.RxCommand<String, List<_i5.WeatherEntry>> get updateWeatherCommand =>
      (super.noSuchMethod(Invocation.getter(#updateWeatherCommand),
              returnValue: _FakeRxCommand<String, List<_i5.WeatherEntry>>())
          as _i3.RxCommand<String, List<_i5.WeatherEntry>>);
  @override
  _i3.RxCommand<bool, bool> get switchChangedCommand => (super.noSuchMethod(
      Invocation.getter(#switchChangedCommand),
      returnValue: _FakeRxCommand<bool, bool>()) as _i3.RxCommand<bool, bool>);
  @override
  _i3.RxCommand<String, String> get textChangedCommand =>
      (super.noSuchMethod(Invocation.getter(#textChangedCommand),
              returnValue: _FakeRxCommand<String, String>())
          as _i3.RxCommand<String, String>);
}
