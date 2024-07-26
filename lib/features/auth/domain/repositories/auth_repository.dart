import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../features.dart';


abstract class AuthRepository {
  Future<Either<Failure, User>> login(LoginParams loginParams);
  Future<Either<Failure, User>> register(RegisterParams registerParams);

}
