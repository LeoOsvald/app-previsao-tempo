// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WeatherModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherModel _$WeatherModelFromJson(Map<String, dynamic> json) => WeatherModel(
  info: (json['weather'] as List<dynamic>)
      .map((e) => WeatherInfo.fromJson(e as Map<String, dynamic>))
      .toList(),
  mainInfo: MainInfo.fromJson(json['main'] as Map<String, dynamic>),
  name: json['name'] as String,
);

Map<String, dynamic> _$WeatherModelToJson(WeatherModel instance) =>
    <String, dynamic>{
      'weather': instance.info.map((e) => e.toJson()).toList(),
      'main': instance.mainInfo.toJson(),
      'name': instance.name,
    };

WeatherInfo _$WeatherInfoFromJson(Map<String, dynamic> json) => WeatherInfo(
  id: (json['id'] as num).toInt(),
  main: json['main'] as String,
  description: json['description'] as String,
  icon: json['icon'] as String,
);

Map<String, dynamic> _$WeatherInfoToJson(WeatherInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'main': instance.main,
      'description': instance.description,
      'icon': instance.icon,
    };

MainInfo _$MainInfoFromJson(Map<String, dynamic> json) => MainInfo(
  temp: (json['temp'] as num).toDouble(),
  feelsLike: (json['feels_like'] as num).toDouble(),
  temp_max: (json['temp_max'] as num).toDouble(),
  temp_min: (json['temp_min'] as num).toDouble(),
);

Map<String, dynamic> _$MainInfoToJson(MainInfo instance) => <String, dynamic>{
  'temp': instance.temp,
  'temp_min': instance.temp_min,
  'temp_max': instance.temp_max,
  'feels_like': instance.feelsLike,
};
