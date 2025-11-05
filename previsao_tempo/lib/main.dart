import 'package:flutter/material.dart';
import 'package:previsao_tempo/viewmodel/WeatherAppViewModelModel.dart';
import 'package:previsao_tempo/repository/CoordinatesRepository.dart';
import 'package:previsao_tempo/repository/WeatherRepository.dart';
import 'package:previsao_tempo/service/WeatherApi.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: viewModel.weatherData == null
                  ? const Center(child: CircularProgressIndicator(color: Colors.white))
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        const Text(
                          "Tempo",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 38,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: ListView.builder(
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
                                            children: [
                                              const Icon(Icons.warning_amber_rounded, color: Colors.white, size: 18),
                                              const SizedBox(width: 4),
                                              const Text(
                                                "Tempestade",
                                                style: TextStyle(
                                                  color: Colors.white70,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            "Máx.: ${cidade.mainInfo.temp_max.round()}°  Mín.: ${cidade.mainInfo.temp_min.round()}°",
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
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
