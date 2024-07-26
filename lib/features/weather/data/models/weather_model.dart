import 'package:intl/intl.dart';

import '../../../../core/usecase/weather_usecase/find_icon.dart';
import '../../domain/entities/current_weather/current_weather.dart';
import '../../domain/entities/current_weather/current_weather_data.dart';
import '../../domain/entities/seven_day_weather/seven_day_weather.dart';
import '../../domain/entities/seven_day_weather/seven_day_weather_data.dart';
import '../../domain/entities/today_weather/today_weather.dart';
import '../../domain/entities/today_weather/today_weather_data.dart';
import '../../domain/entities/weather.dart';

class WeatherModel extends Weather {
  WeatherModel({
    required CurrentWeatherData currentWeatherData,
    required SevenDayWeatherData sevenDayWeatherData,
    required TodayWeatherData todayWeatherData,
  }) : super(
          currentWeatherData: currentWeatherData,
          sevenDayWeatherData: sevenDayWeatherData,
          todayWeatherData: todayWeatherData,
        );

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    DateTime date = DateTime.now();
    var list = json["list"] as List<dynamic>;

    // Assuming the first entry in the list is the current weather
    var current = list[0];

    CurrentWeather currentWeather = CurrentWeather(
      current: (current["main"]["temp"] - 273.15).round(), // Convert Kelvin to Celsius
      name: current["weather"][0]["main"].toString(),
      day: DateFormat("EEEE dd MMMM").format(date),
      wind: (current["wind"]["speed"] as double).round(),
      humidity: (current["main"]["humidity"] as int).round(),
      chanceRain: 0, // Rain data is not provided in this response
      image: findIcon(current["weather"][0]["main"].toString(), true),
    );

    List<TodayWeather> todayWeather = [];
    int hour = int.parse(DateFormat("hh").format(date));
    for (var i = 0; i < 4 && i < list.length; i++) {
      var temp = list[i];
      var hourly = TodayWeather(
        current: (temp["main"]["temp"] - 273.15).round(), // Convert Kelvin to Celsius
        image: findIcon(temp["weather"][0]["main"].toString(), false),
        time: DateFormat("HH:mm").format(DateTime.parse(temp["dt_txt"])),
      );
      todayWeather.add(hourly);
    }

    List<SevenDayWeather> sevenDay = [];
    for (var i = 0; i < list.length; i++) {
      var temp = list[i];
      String day = DateFormat("EEEE")
          .format(DateTime.parse(temp["dt_txt"]))
          .substring(0, 3);
      var sevenDayWeather = SevenDayWeather(
        max: (temp["main"]["temp_max"] - 273.15).round(), // Convert Kelvin to Celsius
        min: (temp["main"]["temp_min"] - 273.15).round(), // Convert Kelvin to Celsius
        image: findIcon(temp["weather"][0]["main"].toString(), false),
        name: temp["weather"][0]["main"].toString(),
        day: day,
      );
      sevenDay.add(sevenDayWeather);
    }

    return WeatherModel(
        currentWeatherData: CurrentWeatherData(currentWeatherData: currentWeather),
        sevenDayWeatherData: SevenDayWeatherData(sevenDayWeatherdata: sevenDay),
        todayWeatherData: TodayWeatherData(todayWeatherData: todayWeather));
  }
}