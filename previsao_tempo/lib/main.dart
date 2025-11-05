import 'package:flutter/material.dart';
import 'package:previsao_tempo/viewmodel/WeatherAppViewModelModel.dart';
import 'package:previsao_tempo/repository/CoordinatesRepository.dart';
import 'package:previsao_tempo/repository/WeatherRepository.dart';
import 'package:previsao_tempo/service/WeatherApi.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

void main() {
  final dio = Dio();
  final weatherApi = WeatherApi(dio);

  runApp(
    MultiProvider(
      providers: [
        Provider<WeatherApi>.value(value: weatherApi),
        Provider<CoordinatesRepository>(
          create: (context) => CoordinatesRepositoryImpl(api: weatherApi),
        ),
        Provider<WeatherRepository>(
          create: (context) => WeatherRepositoryImpl(api: weatherApi),
        ),
        ChangeNotifierProvider(
          create: (context) => WeatherAppViewModelModel(
            weatherRepository: context.read<WeatherRepository>(),
            coordinatesRepository: context.read<CoordinatesRepository>(),
          ),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<WeatherAppViewModelModel>();
    String horaAtual = DateFormat('HH:mm').format(DateTime.now());

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFF1C5875),
        body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1C5875), Color(0xFF3A7CA5)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            horaAtual,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Icon(Icons.location_on, color: Colors.white, size: 18),
                        ],
                      ),
                      const Row(
                        children: [
                          Icon(Icons.signal_cellular_alt, color: Colors.white, size: 18),
                          SizedBox(width: 4),
                          Icon(Icons.wifi, color: Colors.white, size: 18),
                          SizedBox(width: 4),
                          Icon(Icons.battery_full, color: Colors.white, size: 18),
                        ],
                      ),
                    ],
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Tempo",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: viewModel.weatherData == null
                        ? const Center(child: CircularProgressIndicator(color: Colors.white))
                        : ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: viewModel.weatherData!.WeatherList.length,
                            itemBuilder: (context, index) {
                              final cidade = viewModel.weatherData!.WeatherList[index];

                              return Container(
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: const LinearGradient(
                                    colors: [Color(0x66FFFFFF), Color(0x33FFFFFF)],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            cidade.name,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Row(
                                            children:  [
                                              SizedBox(width: 4),
                                              Text(
                                                cidade.info[0].description,
                                                style: TextStyle(
                                                  color: Colors.white70,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            " Máx: ${cidade.mainInfo.temp_max.round()}° Mín: ${cidade.mainInfo.temp_max.round()}" ,
                                            style: const TextStyle(
                                              color: Colors.white70,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "${cidade.mainInfo.temp.round()}°",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 48,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 15),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Buscar cidade',
                        hintStyle: const TextStyle(color: Colors.white70),
                        prefixIcon: const Icon(Icons.search, color: Colors.white70),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onSubmitted: (valor) {
                        viewModel.getCityWeather(valor);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
