import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../auth.dart';
import '../repositories/auth_repository.dart';

class PostLogin extends UseCase<User, LoginParams> {
  final AuthRepository _repo;

  PostLogin(this._repo);

  @override
  Future<Either<Failure, User>> call(LoginParams params) => _repo.login(params);
}

class LoginParams {
  final String email;
  final String password;
  LoginParams({required this.email, required this.password});

  toMap() => {
        "email": email,
        "password": password,
      };
}
