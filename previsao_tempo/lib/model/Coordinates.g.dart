// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Coordinates.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Coordinates _$CoordinatesFromJson(Map<String, dynamic> json) => Coordinates(
  lat: (json['lat'] as num).toDouble(),
  lon: (json['lon'] as num).toDouble(),
  name: json['name'] as String,
);

Map<String, dynamic> _$CoordinatesToJson(Coordinates instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lon': instance.lon,
      'name': instance.name,
    };
