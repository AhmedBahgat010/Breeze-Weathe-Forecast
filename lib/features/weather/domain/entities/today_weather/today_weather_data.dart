import 'package:breeze_weather_forecast/features/weather/domain/entities/today_weather/today_weather.dart';
import 'package:equatable/equatable.dart';

class TodayWeatherData extends Equatable {
  final List<TodayWeather> todayWeatherData;

  TodayWeatherData({required this.todayWeatherData});
  @override
  List<Object?> get props => [todayWeatherData];
}
