import 'package:flutter/material.dart';
import 'package:rx_widget_demo/homepage/weather_list_view.dart';
import 'package:rx_widget_demo/keys.dart';
import 'package:rx_widget_demo/model_provider.dart';
import 'package:rx_widget_demo/service/weather_entry.dart';
import 'package:rx_widgets/rx_widgets.dart';

// ignore_for_file: deprecated_member_use

const noResultsText = 'No matching city data found. Try refining search.';

class HomePage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homePageModel = ModelProvider.of(context);
    /*return Scaffold(
      appBar: AppBar(title: AppBar(title: Text('WeatherDemo'))),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                key: AppKeys.textField,
                autocorrect: false,
                controller: _controller,
                decoration: InputDecoration(
                  hintText: "Filter cities",
                ),
                style: TextStyle(
                  fontSize: 20.0,
                ),
                onChanged: (s) => homePageModel.textChangedCommand(s),
                // onChanged: ModelProvider.of(context).textChangedCommand,
              ),
            ),
            Text('My Message'),
          ],
        ),
      ),
    );*/
    return Scaffold(
      appBar: AppBar(title: Text("WeatherDemo")),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                key: AppKeys.textField,
                autocorrect: false,
                controller: _controller,
                decoration: InputDecoration(hintText: "Filter cities"),
                style: TextStyle(
                  fontSize: 20.0,
                ),
                onChanged: (s) => homePageModel.textChangedCommand(s),
              ),
            ),
            Expanded(
              child: RxLoader<List<WeatherEntry>>(
                spinnerKey: AppKeys.loadingSpinner,
                radius: 25.0,
                commandResults: homePageModel.updateWeatherCommand.results,
                dataBuilder: (_, data) {
                  if (data.isEmpty) return Center(child: Text(noResultsText));
                  return WeatherListView(data, key: AppKeys.weatherList);
                },
                placeHolderBuilder: (_) => Center(
                    key: AppKeys.loaderPlaceHolder, child: Text("No Data")),
                errorBuilder: (_, ex) => Center(
                    key: AppKeys.loaderError,
                    child: Text("Error: ${ex.toString()}")),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    // This might be solved with a StreamBuilder to but it should show `WidgetSelector`
                    child: WidgetSelector(
                      key: AppKeys.widgetSelector,
                      buildEvents:
                          homePageModel.updateWeatherCommand.canExecute,
                      //We access our ViewModel through the inherited Widget
                      onTrue: RaisedButton(
                        key: AppKeys.updateButtonEnabled,
                        child: Text("Update"),
                        onPressed: () {
                          _controller.clear();
                          homePageModel.updateWeatherCommand('');
                        },
                      ),
                      onFalse: RaisedButton(
                        key: AppKeys.updateButtonDisabled,
                        child: Text("Please Wait"),
                        onPressed: null,
                      ),
                    ),
                  ),
                  StateFullSwitch(
                    state: true,
                    onChanged: (b) => homePageModel.switchChangedCommand(b),
                    // onChanged: homePageModel.switchChangedCommand,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// As the normal switch does not even remember and display its current state
/// we us this one
class StateFullSwitch extends StatefulWidget {
  final bool state;
  final ValueChanged<bool> onChanged;

  StateFullSwitch({required this.state, required this.onChanged});

  @override
  StateFullSwitchState createState() {
    return StateFullSwitchState(state, onChanged);
  }
}

class StateFullSwitchState extends State<StateFullSwitch> {
  bool state;
  ValueChanged<bool> handler;

  StateFullSwitchState(this.state, this.handler);

  @override
  Widget build(BuildContext context) {
    return Switch(
      key: AppKeys.updateSwitch,
      value: state,
      onChanged: (b) {
        setState(() => state = b);
        handler(b);
      },
    );
  }
}
