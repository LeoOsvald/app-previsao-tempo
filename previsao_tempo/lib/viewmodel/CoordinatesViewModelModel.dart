// import 'package:flutter/material.dart';
// import 'package:previsao_tempo/repository/CoordinatesRepository.dart';
// import 'package:previsao_tempo/util/command.dart';
// import 'package:previsao_tempo/util/result.dart';
// import 'package:previsao_tempo/model/Coordinates.dart';

// class CoordinatesViewModel extends ChangeNotifier {
//   CoordinatesViewModel({
//     required CoordinatesRepository coordinatesRepository,
//   }) : _coordinatesRepository = coordinatesRepository {
//     getCoordinates = Command3<Result<List<Coordinates>>, String, int, String>(_getCoordinates);
//   }

//   final CoordinatesRepository _coordinatesRepository;

//   List<Coordinates>? _coordinates;
//   List<Coordinates>? get coordinates => _coordinates;

// late final Command3<Result<List<Coordinates>>, String, int, String> getCoordinates;

//   Future<Result<List<Coordinates>>> _getCoordinates(String cityName, int limit, String apiKey) async {
//     try {
//       final result = await _coordinatesRepository.getCoordinates(cityName, limit, apiKey);
      
//       if (result is Ok<List<Coordinates>>) {
//         _coordinates = (result as Ok<List<Coordinates>>).value;
//         print('Loaded coordinates: ${_coordinates?.length}');
//       } else if (result is Error<List<Coordinates>>) {
//         print('Failed to load coordinates: ${result.error}');
//       }
      
//       return result;
//     } finally {
//       notifyListeners();
//     }
//   }
// }
