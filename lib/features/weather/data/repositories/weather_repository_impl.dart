
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/netWork/network_info.dart';
import '../../../../core/usecase/weather_usecase/lat_long.dart';
import '../../domain/entities/weather.dart';
import '../../domain/repositories/weather_repository.dart';
import '../datasources/weather_remote_data_source.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  final WeatherRemoteDataSource weatherRemoteDataSource;
  final NetworkInfo networkInfo;

  WeatherRepositoryImpl({
    required this.weatherRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Weather>> getWeather(LatLong latLong) async {
    if (await networkInfo.isConnected) {
      try {
        final weatherRemoteData =
            await weatherRemoteDataSource.getWeather(latLong);
        return Right(weatherRemoteData);
      } on ServerException {
        return Left(ServerFailure(""));
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
