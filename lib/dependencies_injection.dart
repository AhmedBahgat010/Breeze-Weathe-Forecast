
import 'package:breeze_weather_forecast/features/auth/domain/repositories/auth_repository.dart';
import 'package:breeze_weather_forecast/features/home/domain/repositories/BMI_repository.dart';
import 'package:breeze_weather_forecast/features/weather/domain/usecases/get_weather.dart';
import 'package:get_it/get_it.dart';
import 'core/core.dart';
import 'core/location/get_lat_long.dart';
import 'core/netWork/network_info.dart';
import 'features/auth/auth.dart';
import 'features/home/data/datasources/bmi_remote_datasources.dart';
import 'features/home/data/repositories/auth_repository_impl.dart';
import 'features/home/domain/usecases/DeleteBMI.dart';
import 'features/home/domain/usecases/SaveBMI.dart';
import 'features/home/domain/usecases/editBMI.dart';
import 'features/home/domain/usecases/getBMi.dart';
import 'features/weather/data/datasources/weather_remote_data_source.dart';
import 'features/weather/data/repositories/weather_repository_impl.dart';
import 'features/weather/domain/repositories/weather_repository.dart';
import 'features/weather/presentation/bloc/weather_bloc.dart';
import 'utils/services/hive/main_box.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  // features - Weather
  sl.registerFactory(() => WeatherBloc(
    getLatLong: sl(),
    getWeather: sl(),
  ));

  // Use cases
  sl.registerLazySingleton(() => GetWeather(sl()));
  // Repository

  sl.registerLazySingleton<WeatherRepository>(
        () => WeatherRepositoryImpl(
      weatherRemoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data Sources
  sl.registerLazySingleton<WeatherRemoteDataSource>(
          () => WeatherRemoteDataSourceImpl(client: sl()));

  // Core-
  sl.registerLazySingleton<GetLatLong>(() => GetLatLongImpl());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}


Future<void> serviceLocator({
  bool isUnitTest = false,
  bool isHiveEnable = true,
}) async {
  /// For unit testing only
  if (isUnitTest) {
    await sl.reset();
  }
  _dataSources();
  _repositories();
  _useCase();
  _cubit();
  await CacheHelper.init(); // Ensure sharedPreferences is initialized

  if (isHiveEnable) await _initHiveBoxes(isUnitTest: isUnitTest);
}

Future<void> _initHiveBoxes({bool isUnitTest = false}) async {
  await MainBoxMixin.initHive();

  sl.registerSingleton<MainBoxMixin>(MainBoxMixin());
}

/// Register repositories
void _repositories() {
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton<BMIRepository>(
    () => BMIRepositoryImpl(sl(), sl()),
  );
}

/// Register dataSources
void _dataSources() {
  sl.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(),
  );
  sl.registerLazySingleton<BMIRemoteDatasource>(
    () => BMIRemoteDatasourceImpl(),
  );
}

void _useCase() {
  sl.registerLazySingleton(() => PostLogin(sl()));
  sl.registerLazySingleton(() => PostRegister(sl()));
  sl.registerLazySingleton(() => SaveBMI(sl()));
  sl.registerLazySingleton(() => GetBMIList(sl()));
  sl.registerLazySingleton(() => DeleteBMI(sl()));
  sl.registerLazySingleton(() => EditBMI(sl()));
}

void _cubit() {
  sl.registerFactory(() => AuthCubit(
        sl(),
        sl(),
      ));
}
