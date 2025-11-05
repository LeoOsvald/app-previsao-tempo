import 'package:previsao_tempo/service/WeatherApi.dart';
import 'package:previsao_tempo/model/Coordinates.dart';
import 'package:previsao_tempo/util/Result.dart';


class CoordinatesRepositoryImpl implements CoordinatesRepository{

  CoordinatesRepositoryImpl({required this.api});

  @override
  final WeatherApi api;
  Future<List<Coordinates>> getCoordinates(cityName) async{
    try
    {
      var cities = await api.getCityData(cityName);
       if (cities is Error<Coordinates>) {
        throw Exception('Error fetching cities');
      }
      return cities;
    }
    on Exception catch(e)
    {
      throw e;
    }
    
  }
}


abstract class CoordinatesRepository {
  Future<List<Coordinates>> getCoordinates(q);
}