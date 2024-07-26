import 'package:breeze_weather_forecast/features/weather/domain/entities/seven_day_weather/seven_day_weather.dart';
import 'package:equatable/equatable.dart';

class SevenDayWeatherData extends Equatable {
  final List<SevenDayWeather> sevenDayWeatherdata;

  const SevenDayWeatherData({required this.sevenDayWeatherdata});

  @override
  List<Object?> get props => [sevenDayWeatherdata];
}
