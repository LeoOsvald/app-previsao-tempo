import 'WeatherModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Weathers.g.dart';

@JsonSerializable()
class Weathers {
  final List<WeatherModel> WeatherList;

  Weathers({required this.WeatherList});

  factory Weathers.fromJson(Map<String, dynamic> json) =>
      _$WeathersFromJson(json);

  Map<String, dynamic> toJson() => _$WeathersToJson(this);
}
