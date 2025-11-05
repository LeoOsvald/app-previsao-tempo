import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Coordinates.g.dart';


@JsonSerializable()
class Coordinates {
  final double lat;
  final double lon;
  final String name;

  Coordinates({required this.lat, required this.lon,required this.name});


factory Coordinates.fromJson(Map<String, dynamic> json) =>
      _$CoordinatesFromJson(json);

  Map<String, dynamic> toJson() => _$CoordinatesToJson(this);

}
