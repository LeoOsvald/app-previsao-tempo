import 'package:previsao_tempo/model/WeatherModel.dart';
import 'package:previsao_tempo/model/Coordinates.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'WeatherApi.g.dart';

@RestApi(baseUrl: 'https://api.openweathermap.org')
abstract class WeatherApi {
  factory WeatherApi(Dio dio, {String baseUrl}) = _WeatherApi;

  @GET('/data/2.5/weather')
  Future<WeatherModel> getWeather(
    @Query('lat') double lat,
    @Query('lon') double lon,
    {
    @Query('appid') String appid = '8328e237e336644e5fba089728b5ad36',
    @Query('lang') String lang = 'pt_br',
    @Query('units') String units = 'metric',
    }
  );

  
  @GET('/geo/1.0/direct')
  Future<List<Coordinates>> getCityData(
    @Query('q') String cityName,{
    @Query('limit') String limit = '1',
    @Query('appid') String appid = '8328e237e336644e5fba089728b5ad36',
  }
  );
}