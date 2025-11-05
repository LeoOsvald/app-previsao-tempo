import 'package:previsao_tempo/service/WeatherApi.dart';
import 'package:previsao_tempo/model/Coordinates.dart';
import 'package:previsao_tempo/util/Result.dart';


class CoordinatesRepositoryImpl implements CoordinatesRepository{

  CoordinatesRepositoryImpl({required this.api});

  @override
  final WeatherApi api;
  Future<Result<List<Coordinates>>> getCoordinates(cityName) async{
    try
    {
      var cities = await api.getCityData(cityName);
       if (cities is Error<Coordinates>) {
        return Result.error(Exception('Error fetching cities'));
      }
      return Result.ok(cities);
    }
    on Exception catch(e)
    {
      return Result.error(e);
    }
    
  }
}


abstract class CoordinatesRepository {
  Future<Result<List<Coordinates>>> getCoordinates(q);
}