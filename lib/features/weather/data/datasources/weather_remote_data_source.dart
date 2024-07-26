import 'dart:convert';
import 'dart:developer';
import 'package:breeze_weather_forecast/core/usecase/weather_usecase/lat_long.dart';
import 'package:http/http.dart' as http;
import '../../../../core/error/exceptions.dart';
import '../../../../core/resources/constats.dart';
import '../models/weather_model.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getWeather(LatLong latLong);
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final http.Client client;

  WeatherRemoteDataSourceImpl({required this.client});

  @override
  Future<WeatherModel> getWeather(LatLong latLong) async {
    final response = await http.get(
      Uri.parse(
        "https://samples.openweathermap.org/data/2.5/forecast?lat=${latLong.lat}&lon=${latLong.long}&appid=$API_KEY"
      ),   );
  log("https://samples.openweathermap.org/data/2.5/forecast?lat=${latLong.lat}&lon=${latLong.long}&appid=$API_KEY");
    log("Response body: ${response.body}"); 
    if (response.statusCode == 200) {
  final Map<String, dynamic> jsonResponse = json.decode(response.body);
    return WeatherModel.fromJson(jsonResponse);    } else {
      throw ServerException("Failed to load weather data: ${response.body}");
    }
  }
}
