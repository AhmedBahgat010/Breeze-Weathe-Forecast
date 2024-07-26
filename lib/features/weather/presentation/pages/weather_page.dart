import 'package:breeze_weather_forecast/features/weather/domain/entities/seven_day_weather/seven_day_weather_data.dart';
import 'package:breeze_weather_forecast/features/weather/domain/entities/today_weather/today_weather_data.dart';
import 'package:breeze_weather_forecast/features/weather/presentation/widgets/current_weather/dateError.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/resources/size_config.dart';
import '../../../../dependencies_injection.dart';
import '../../../map/presentation/pages/map_page.dart';
import '../../domain/entities/current_weather/current_weather.dart';
import '../../domain/entities/seven_day_weather/seven_day_weather.dart';
import '../../domain/entities/today_weather/today_weather.dart';
import '../bloc/weather_bloc.dart';
import '../widgets/current_weather/current_weather_view.dart';
import '../widgets/empty_or_loading.dart';
import '../widgets/seven_day_weather/seven_day_weathet_view.dart';
import '../widgets/today_weather/today_weather_view.dart';


class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override

  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => MapPage(),
            ),
          );
        },
        child: Icon(
          Icons.map,
          size: getProportionateScreenHeight(30),
          color: Colors.white,
        ),
      ),
      body: buildBody(context),
    );
  }

  BlocProvider<WeatherBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl(),
      child: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is Empty) {
            context.read<WeatherBloc>().add(GetWeatherForLatLong());
            return const EmptyOrLoading();
          } else if (state is Loading) {
            return const EmptyOrLoading();
          } else if (state is Loaded) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  CurrentWeatherView(
                      state.weather.currentWeatherData.currentWeatherData),
                  TodaysWeatherView(state.weather.todayWeatherData),
                  SevenDaysView(state.weather.sevenDayWeatherData),
                ],
              ),
            );
          } else {
            return  dataError();

          }
        },
      ),
    );
  }
}
