
import 'package:breeze_weather_forecast/core/translations/app_language.dart';
import 'package:breeze_weather_forecast/features/auth/domain/repositories/auth_repository.dart';
import 'package:breeze_weather_forecast/features/home/domain/repositories/BMI_repository.dart';
import 'package:breeze_weather_forecast/features/weather/domain/usecases/get_weather.dart';
import 'package:get_it/get_it.dart';
import 'core/core.dart';
import 'core/location/get_lat_long.dart';
import 'core/netWork/network_info.dart';
import 'core/theme/theme_service.dart';
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
  // Register Core Services
  sl.registerLazySingleton<GetLatLong>(() => GetLatLongImpl());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // Register External Libraries
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
sl.registerFactory(() => LanguageCubit(sl()));

  // Register Weather Feature
  sl.registerFactory(() => WeatherBloc(
    getLatLong: sl(),
    getWeather: sl(),
  ));
  sl.registerLazySingleton(() => GetWeather(sl()));
  sl.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(
      weatherRemoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<WeatherRemoteDataSource>(
    () => WeatherRemoteDataSourceImpl(client: sl(), ),
  );

  // Register Auth Feature
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(),
  );

  // Register Home Feature
  sl.registerLazySingleton<BMIRepository>(
    () => BMIRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton<BMIRemoteDatasource>(
    () => BMIRemoteDatasourceImpl(),
  );

  // Register Use Cases
  sl.registerLazySingleton(() => PostLogin(sl()));
  sl.registerLazySingleton(() => PostRegister(sl()));
  sl.registerLazySingleton(() => SaveBMI(sl()));
  sl.registerLazySingleton(() => GetBMIList(sl()));
  sl.registerLazySingleton(() => DeleteBMI(sl()));
  sl.registerLazySingleton(() => EditBMI(sl()));

  // Register Cubits
  sl.registerFactory(() => AuthCubit(
    sl(),
    sl(),
  ));
  sl.registerFactory(() => ThemeCubit()); // Register ThemeCubit
}

Future<void> initServiceLocator({
  bool isUnitTest = false,
  bool isHiveEnable = true,
}) async {
  // For unit testing only: reset the service locator
  if (isUnitTest) {
    await sl.reset();
  }

  // Ensure shared preferences is initialized
  await CacheHelper.init();

  // Initialize Hive if enabled
  if (isHiveEnable) {
    await _initHiveBoxes(isUnitTest: isUnitTest);
  }
}

Future<void> _initHiveBoxes({bool isUnitTest = false}) async {
  await MainBoxMixin.initHive();
  sl.registerSingleton<MainBoxMixin>(MainBoxMixin());
}
