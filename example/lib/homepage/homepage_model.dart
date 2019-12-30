
import 'package:rx_command/rx_command.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rx_widget_demo/service/weather_service.dart';
import 'package:rx_widget_demo/service/weather_entry.dart';

class HomePageModel {
  final WeatherService service;
  final RxCommand<String, List<WeatherEntry>> updateWeatherCommand;
  final RxCommand<bool, bool> switchChangedCommand;
  final RxCommand<String, String> textChangedCommand;

  HomePageModel._(
    this.updateWeatherCommand,
    this.switchChangedCommand,
    this.textChangedCommand,
    this.service,
  );

  factory HomePageModel(WeatherService service ) {
    // Command expects a bool value when executed and issues the value on it's
    // result Observable (stream)
    final _switchChangedCommand = RxCommand.createSync<bool, bool>((b) => b);

    // We pass the result of switchChangedCommand as canExecute Observable to
    // the updateWeatherCommand
    final _updateWeatherCommand =
        RxCommand.createAsync<String, List<WeatherEntry>>(
            service.getWeatherEntriesForCity, canExecute:  _switchChangedCommand);

    // Will be called on every change of the search field
    final _textChangedCommand = RxCommand.createSync<String, String>((s) => s);

    // When the user starts typing
    _textChangedCommand
        // Wait for the user to stop typing for 500ms
        .debounceTime( Duration(milliseconds: 500))
        // Then call the updateWeatherCommand
        .listen(_updateWeatherCommand);

    // Update data on startup
    _updateWeatherCommand('');

    return  HomePageModel._(
      _updateWeatherCommand,
      _switchChangedCommand,
      _textChangedCommand,
      service,
    );
  }
}
