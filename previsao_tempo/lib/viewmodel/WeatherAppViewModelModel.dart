import 'package:previsao_tempo/model/Coordinates.dart';
import 'package:previsao_tempo/model/Weathers.dart';
import 'package:previsao_tempo/repository/CoordinatesRepository.dart';
import 'package:previsao_tempo/repository/WeatherRepository.dart';
import 'package:previsao_tempo/util/Result.dart';
import 'package:flutter/material.dart';
import 'package:previsao_tempo/util/command.dart';

class WeatherAppViewModelModel extends ChangeNotifier {

  WeatherAppViewModelModel(
    {
     required WeatherRepository weatherRepository,
     required CoordinatesRepository coordinatesRepository
     }
  ):
      _weatherRepository = weatherRepository,
      _coordinatesRepository = coordinatesRepository 
  {
      _getWeatherList();
  }

  final WeatherRepository _weatherRepository;
  final CoordinatesRepository _coordinatesRepository;

  List<Coordinates> cidades = [Coordinates(lat: -28.2628, lon: -52.4067,name: "Passo Fundo"), Coordinates(lat: -30.0331,lon: -51.2300, name: "Porto Alegre"),Coordinates(lat: -27.5945,lon: -48.5477,name: "Florianopolis"),Coordinates(lat: -25.4284,lon: -49.2733,name: "Curitiba"),Coordinates(lat: -23.5506507,lon:-46.6333824,name: "Sao Paulo"),];

  Weathers? _weatherData;
  Weathers? get weatherData => _weatherData;

  late final Command0 getWeatherList;

  Future<Result> _getWeatherList() async  {
    try {
      final result = await _weatherRepository.getWeatherList(cidades);
      switch (result) {
        case Ok<Weathers>():
          _weatherData = result.value;
          print('Loaded user');
        case Error<Weathers>():
          print('Failed to load user ${result.error}');
      }

      return result;
    } finally {
      notifyListeners();
    }
  }

  Future<void> getCityWeather(city) async 
  {
    try
    {
      final coordinates = await _coordinatesRepository.getCoordinates(city);

      if(cidades.isNotEmpty)
        cidades.clear();
      
      for(var coordinate in coordinates)
        cidades.add(coordinate);

      final result = _getWeatherList();

    } 
    catch (e) 
    {
      throw e;
    }
    finally
    {
      notifyListeners();
    }
}
}

