// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Weathers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Weathers _$WeathersFromJson(Map<String, dynamic> json) => Weathers(
  WeatherList: (json['WeatherList'] as List<dynamic>)
      .map((e) => WeatherModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$WeathersToJson(Weathers instance) => <String, dynamic>{
  'WeatherList': instance.WeatherList,
};
