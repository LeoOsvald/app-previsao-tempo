import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Coordinates.g.dart';


@JsonSerializable()
class Coordinates {
  final double lat;
  final double long;
  final String cityName;

  Coordinates({required this.lat, required this.long,required this.cityName});


factory Coordinates.fromJson(Map<String, dynamic> json) =>
      _$CoordinatesFromJson(json);

  Map<String, dynamic> toJson() => _$CoordinatesToJson(this);

}
