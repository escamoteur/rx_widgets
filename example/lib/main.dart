import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rx_widget_demo/homepage/home_page.dart';
import 'package:rx_widget_demo/homepage/homepage_model.dart';
import 'package:rx_widget_demo/model_provider.dart';
import 'package:rx_widget_demo/service/weather_service.dart';

void main() {
  final weatherService = WeatherService(http.Client());
  final homePageModel = HomePageModel(weatherService);

  runApp(
    MyApp(model: homePageModel),
  );
}

class MyApp extends StatelessWidget {
  final HomePageModel model;

  const MyApp({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ModelProvider(
      model: model,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          disabledColor: Colors.white12,
          primaryColor: Color(0xFF1C262A),
          buttonColor: Color(0xFF1C262A),
          accentColor: Color(0xFFA7D9D5),
          scaffoldBackgroundColor: Color.fromRGBO(38, 50, 56, 1.0),
        ),
        home: HomePage(),
      ),
    );
  }
}
