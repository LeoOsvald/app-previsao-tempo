import 'package:json_annotation/json_annotation.dart';

part 'WeatherModel.g.dart';

@JsonSerializable(explicitToJson: true)
class WeatherModel {
  // Pega apenas o primeiro item da lista "weather" da API
  @JsonKey(name: 'weather')
  final List<WeatherInfo> info;

  @JsonKey(name: 'main')
  final MainInfo mainInfo;

  final String name;

  WeatherModel({
    required this.info,
    required this.mainInfo,
    required this.name,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherModelToJson(this);
}

@JsonSerializable()
class WeatherInfo {
  final int id;
  final String main;
  final String description;
  final String icon;

  WeatherInfo({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory WeatherInfo.fromJson(Map<String, dynamic> json) =>
      _$WeatherInfoFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherInfoToJson(this);
}

@JsonSerializable()
class MainInfo {
  final double temp;
  final double temp_min;
  final double temp_max;


  @JsonKey(name: 'feels_like')
  final double feelsLike;

  MainInfo({
    required this.temp,
    required this.feelsLike,
    required this.temp_max,
    required this.temp_min
  });

  factory MainInfo.fromJson(Map<String, dynamic> json) =>
      _$MainInfoFromJson(json);

  Map<String, dynamic> toJson() => _$MainInfoToJson(this);
}
