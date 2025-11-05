import 'package:previsao_tempo/model/Coordinates.dart';
import 'package:previsao_tempo/model/Weathers.dart';
import 'package:previsao_tempo/service/WeatherApi.dart';
import 'package:previsao_tempo/model/WeatherModel.dart';
import 'package:previsao_tempo/util/Result.dart';


class WeatherRepositoryImpl implements WeatherRepository{

  WeatherRepositoryImpl({required this.api});

  final WeatherApi api;

  @override
  Future<Result<Weathers>> getWeatherList(List<Coordinates> coordinates) async {

     final weatherData = Weathers(WeatherList: []);

     for (var cidade in coordinates) {
        try {
          final weather = await api.getWeather(
            cidade.lat,
            cidade.lon,
          );
          print(weather);
          weatherData.WeatherList.add(weather);  
        } catch (e) {
          print('Erro ao buscar dados para ${cidade.name}: $e');
        }
      }

      return Result.ok(weatherData);

  }


  @override
  Future<Result<WeatherModel>> getWeather(lat,lon) async{
    try
    {
      var weather = await api.getWeather(lat, lon);
       if (weather is Error<WeatherModel>) {
        return Result.error(Exception('Error fetching cities'));
      }
      return Result.ok(weather);
    }
    on Exception catch(e)
    {
      return Result.error(e);
    }
    
  }
}


abstract class WeatherRepository {
  Future<Result<WeatherModel>> getWeather(lat, lon);

  Future<Result<Weathers>> getWeatherList(List<Coordinates> coordinates);
}