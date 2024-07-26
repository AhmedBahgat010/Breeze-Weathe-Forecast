import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../auth.dart';
import '../repositories/auth_repository.dart';


class PostRegister extends UseCase<User, RegisterParams> {
  final AuthRepository _repo;

  PostRegister(this._repo);

  @override
  Future<Either<Failure, User>> call(RegisterParams params) =>
      _repo.register(params);
}

class RegisterParams {
  final String email;
  final String password;
  final String name;
  final String phone;
  RegisterParams(
      {required this.email,
      required this.password,
      required this.name,
      required this.phone});

  toMap() => {
        "firstName": name.split(' ').first,
        "lastName": name.split(' ').last,
        "email": email,
        "phone": phone,
        "password": password,
        "refer_user": ""
      };
}
