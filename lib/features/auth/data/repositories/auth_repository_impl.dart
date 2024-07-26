import 'package:dartz/dartz.dart';
import '../../../../core/core.dart';
import '../../../../utils/utils.dart';
import '../../../features.dart';
import '../../domain/repositories/auth_repository.dart';



class AuthRepositoryImpl implements AuthRepository {
  /// Data Source
  final AuthRemoteDatasource authRemoteDatasource;
  final MainBoxMixin mainBoxMixin;

  const AuthRepositoryImpl(this.authRemoteDatasource, this.mainBoxMixin);

  @override
  Future<Either<Failure, User>> login(LoginParams loginParams) async {
    final response = await authRemoteDatasource.login(loginParams);

    return response.fold(
      (failure) => Left(failure),
      (loginResponse) {
        return Right(loginResponse);
      },
    );
  }

  @override
  Future<Either<Failure, User>> register(
    RegisterParams registerParams,
  ) async {
    final response = await authRemoteDatasource.register(registerParams);
    return response.fold(
      (failure) => Left(failure),
      (registerResponse) {
        return Right(registerResponse);
      },
    );
  }


}
