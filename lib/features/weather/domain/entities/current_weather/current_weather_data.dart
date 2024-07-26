import 'package:equatable/equatable.dart';
import 'current_weather.dart';

class CurrentWeatherData extends Equatable {
  final CurrentWeather currentWeatherData;

  const CurrentWeatherData({required this.currentWeatherData});

  @override
  List<Object?> get props => [currentWeatherData];
}
