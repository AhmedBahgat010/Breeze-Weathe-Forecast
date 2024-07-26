import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/core.dart';
import '../../auth.dart';


abstract class AuthRemoteDatasource {
  Future<Either<Failure, UserModel>> register(
    RegisterParams registerParams,
  );

  Future<Either<Failure, UserModel>> login(LoginParams loginParams);

}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  AuthRemoteDatasourceImpl();

  @override
  Future<Either<Failure, UserModel>> register(
      RegisterParams registerParams,
      ) async {
    try {
      final authResult = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: registerParams.email, password: registerParams.password);
      UserModel userModel = UserModel(userId: authResult.user!.uid, registeredEmail: registerParams.email, name:registerParams.name );
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(authResult.user!.uid)
          .set(userModel.toJson());
      CacheHelper.saveData(key: "uId", value: authResult.user!.uid);

      return Right(UserModel(userId: authResult.user!.uid, registeredEmail: registerParams.email, name: registerParams.name));
    } catch (e) {
      return Left(ServerFailure("Registration failed"));
    }
  }

  @override
  Future<Either<Failure, UserModel>> login(LoginParams loginParams) async {
    try {
        final authResult = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: loginParams.email, password: loginParams.password);
        final userSnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(authResult.user!.uid)
          .get();
        CacheHelper.saveData(key: "uId", value: authResult.user!.uid);

        final response = UserModel.fromJson(userSnapshot.data()!);
      // Return UserModel if login is successful
      return Right(response);
    } catch (e) {
      // Return Failure if an error occurs during login
      return Left(ServerFailure("Login failed"));
    }
  }
}





