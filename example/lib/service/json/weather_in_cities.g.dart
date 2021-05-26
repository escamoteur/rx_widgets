// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_in_cities.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherInCities _$WeatherInCitiesFromJson(Map<String, dynamic> json) {
  return WeatherInCities(
    json['cnt'] as int,
    (json['calctime'] as num).toDouble(),
    json['cod'] as int,
    (json['list'] as List<dynamic>)
        .map((e) => City.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$WeatherInCitiesToJson(WeatherInCities instance) =>
    <String, dynamic>{
      'cnt': instance.cnt,
      'calctime': instance.calctime,
      'cod': instance.cod,
      'list': instance.cities,
    };

City _$CityFromJson(Map<String, dynamic> json) {
  return City(
    json['id'] as int,
    Coord.fromJson(json['coord'] as Map<String, dynamic>),
    Clouds.fromJson(json['clouds'] as Map<String, dynamic>),
    json['dt'] as int,
    json['name'] as String,
    Main.fromJson(json['main'] as Map<String, dynamic>),
    json['rain'] == null
        ? null
        : Rain.fromJson(json['rain'] as Map<String, dynamic>),
    (json['weather'] as List<dynamic>)
        .map((e) => Weather.fromJson(e as Map<String, dynamic>))
        .toList(),
    Wind.fromJson(json['wind'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CityToJson(City instance) => <String, dynamic>{
      'id': instance.id,
      'coord': instance.coord,
      'clouds': instance.clouds,
      'dt': instance.dt,
      'name': instance.name,
      'main': instance.main,
      'rain': instance.rain,
      'weather': instance.weather,
      'wind': instance.wind,
    };

Coord _$CoordFromJson(Map<String, dynamic> json) {
  return Coord(
    (json['Lat'] as num).toDouble(),
    (json['Lon'] as num).toDouble(),
  );
}

Map<String, dynamic> _$CoordToJson(Coord instance) => <String, dynamic>{
      'Lat': instance.lat,
      'Lon': instance.lon,
    };

Clouds _$CloudsFromJson(Map<String, dynamic> json) {
  return Clouds(
    json['today'] as int,
  );
}

Map<String, dynamic> _$CloudsToJson(Clouds instance) => <String, dynamic>{
      'today': instance.today,
    };

Main _$MainFromJson(Map<String, dynamic> json) {
  return Main(
    (json['sea_level'] as num?)?.toDouble(),
    json['humidity'] as int,
    (json['grnd_level'] as num?)?.toDouble(),
    (json['pressure'] as num).toDouble(),
    (json['temp_max'] as num).toDouble(),
    (json['temp'] as num).toDouble(),
    (json['temp_min'] as num).toDouble(),
  );
}

Map<String, dynamic> _$MainToJson(Main instance) => <String, dynamic>{
      'sea_level': instance.seaLevel,
      'humidity': instance.humidity,
      'grnd_level': instance.grndLevel,
      'pressure': instance.pressure,
      'temp_max': instance.tempMax,
      'temp': instance.temp,
      'temp_min': instance.tempMin,
    };

Rain _$RainFromJson(Map<String, dynamic> json) {
  return Rain(
    (json['3h'] as num).toDouble(),
  );
}

Map<String, dynamic> _$RainToJson(Rain instance) => <String, dynamic>{
      '3h': instance.threeH,
    };

Weather _$WeatherFromJson(Map<String, dynamic> json) {
  return Weather(
    json['icon'] as String,
    json['description'] as String,
    json['id'] as int,
    json['main'] as String,
  );
}

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
      'icon': instance.icon,
      'description': instance.description,
      'id': instance.id,
      'main': instance.main,
    };

Wind _$WindFromJson(Map<String, dynamic> json) {
  return Wind(
    (json['deg'] as num).toDouble(),
    (json['speed'] as num).toDouble(),
  );
}

Map<String, dynamic> _$WindToJson(Wind instance) => <String, dynamic>{
      'deg': instance.deg,
      'speed': instance.speed,
    };
