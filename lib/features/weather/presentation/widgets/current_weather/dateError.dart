import 'package:breeze_weather_forecast/features/weather/domain/entities/current_weather/current_weather.dart';
import 'package:breeze_weather_forecast/features/weather/domain/entities/seven_day_weather/seven_day_weather.dart';
import 'package:breeze_weather_forecast/features/weather/domain/entities/seven_day_weather/seven_day_weather_data.dart';
import 'package:breeze_weather_forecast/features/weather/domain/entities/today_weather/today_weather.dart';
import 'package:breeze_weather_forecast/features/weather/domain/entities/today_weather/today_weather_data.dart';
import 'package:breeze_weather_forecast/features/weather/presentation/widgets/current_weather/current_weather_view.dart';
import 'package:breeze_weather_forecast/features/weather/presentation/widgets/seven_day_weather/seven_day_weathet_view.dart';
import 'package:breeze_weather_forecast/features/weather/presentation/widgets/today_weather/today_weather_view.dart';
import 'package:flutter/material.dart';

Widget dataError() {
  return  SingleChildScrollView(
              child: Column(
                children: [
                  CurrentWeatherView(CurrentWeather(current: 36, name: "clean",city: "Egypt", day: "Now", wind: 57, humidity: 56, chanceRain: 5, image: "assets/images/sunny.png")),
              
                        TodaysWeatherView(TodayWeatherData(todayWeatherData:[
                        TodayWeather(current: 72, time: '08:00 AM', image: 'assets/images/sunny.png'),
                        TodayWeather(current: 75, time: '09:00 AM', image: 'assets/images/moderateorheavyrainshower.png'),
                        TodayWeather(current: 78, time: '10:00 AM', image: 'assets/images/cloudy.png'),
                        // TodayWeather(current: 81, time: '11:00 AM', image: 'assets/images/rainy.png'),
                        TodayWeather(current: 84, time: '12:00 PM', image: 'assets/images/clear.png'),
                        TodayWeather(current: 86, time: '01:00 PM', image: 'assets/images/sunny.png'),
                        TodayWeather(current: 85, time: '02:00 PM', image: 'assets/images/sunny.png'),
                        TodayWeather(current: 83, time: '03:00 PM', image: 'assets/images/moderateorheavyrainshower.png'),]
                        )),
                  SevenDaysView(SevenDayWeatherData(
                    sevenDayWeatherdata:  [
                      SevenDayWeather(max: 85, min: 70, name: 'Monday', day: 'July 26', image: 'assets/images/sunny.png'),
                      SevenDayWeather(max: 88, min: 72, name: 'Tuesday', day: 'July 27', image: 'assets/images/moderateorheavyrainshower.png'),
                      SevenDayWeather(max: 90, min: 74, name: 'Wednesday', day: 'July 28', image: 'assets/images/cloudy.png'),
                      SevenDayWeather(max: 92, min: 76, name: 'Thursday', day: 'July 29', image: 'assets/images/rainy.png'),
                      SevenDayWeather(max: 85, min: 69, name: 'Friday', day: 'July 30', image: 'assets/images/clear.png'),
                      SevenDayWeather(max: 87, min: 71, name: 'Saturday', day: 'July 31', image: 'assets/images/sunny.png'),
                      SevenDayWeather(max: 86, min: 70, name: 'Sunday', day: 'August 1', image: 'assets/images/moderateorheavyrainshower.png'),
                    ]
                  )),
                ],
              ),
            );
}