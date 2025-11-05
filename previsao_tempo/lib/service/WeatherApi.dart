import 'package:previsao_tempo/model/WeatherModel.dart';
import 'package:previsao_tempo/model/Coordinates.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'WeatherApi.g.dart';

@RestApi(baseUrl: 'http://api.openweathermap.org/geo/1.0')
abstract class WeatherApi {
  factory WeatherApi(Dio dio, {String baseUrl}) = _WeatherApi;

  @GET('/direct')
  Future<List<Coordinates>> getCityData(
    @Query('q') String cityName,
    @Query('limit') int limit,
    @Query('appid') String apiKey,
  );
}