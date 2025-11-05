// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Coordinates.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Coordinates _$CoordinatesFromJson(Map<String, dynamic> json) => Coordinates(
  lat: (json['lat'] as num).toDouble(),
  long: (json['long'] as num).toDouble(),
  cityName: json['cityName'] as String,
);

Map<String, dynamic> _$CoordinatesToJson(Coordinates instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'long': instance.long,
      'cityName': instance.cityName,
    };
