import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/core.dart';
import '../../domain/usecases/SaveBMI.dart';
import '../../domain/usecases/editBMI.dart';
import '../data.dart';

abstract class BMIRemoteDatasource {
  Future<Either<Failure, BMIModel>> saveBMI(SaveBMIParams SaveBMIParams);
  Future<Either<Failure, List<BMIModel>>> getBMIList();
  Future<bool> deleteBMI(String bmiId);
  Future<Either<Failure, BMIModel>> editBMI(EditBMIParams editBMIParams);
}

class BMIRemoteDatasourceImpl implements BMIRemoteDatasource {
  BMIRemoteDatasourceImpl();

  @override
  Future<Either<Failure, BMIModel>> saveBMI(
    SaveBMIParams SaveBMIParams,
  ) async {
    try {
      final authResult = await FirebaseFirestore.instance
          .collection('bmi_data')
          .add(SaveBMIParams.toMap());

      return Right(BMIModel(
          id: SaveBMIParams.id,
          weight: SaveBMIParams.weight,
          height: SaveBMIParams.height,
          age: SaveBMIParams.age,
          timestamp: SaveBMIParams.time));
    } catch (e) {
      return Left(ServerFailure("Registration failed"));
    }
  }

  @override
  Future<Either<Failure, List<BMIModel>>> getBMIList() async {
    try {
      String UID = await CacheHelper.getData(
        key: "uId",
      );

      final querySnapshot = await FirebaseFirestore.instance
          .collection('bmi_data')
          .where("id", isEqualTo: UID)
          .get();

      final bmiList = querySnapshot.docs
          .map((doc) => BMIModel(
                id: doc.id,
                weight: doc['weight'],
                height: doc['height'],
                age: doc['age'],
                timestamp: (doc['timestamp'] as Timestamp)
                    .toDate(), // Convert Timestamp to DateTime
              ))
          .toList();

      return Right(bmiList);
    } catch (e, stackTrace) {
      log('Error fetching BMI data: $e');
      log(stackTrace.toString());
      return Left(ServerFailure("Failed to fetch BMI data"));
    }
  }

  @override
  Future<bool> deleteBMI(String bmiId) async {
    try {
      await FirebaseFirestore.instance
          .collection('bmi_data')
          .doc(bmiId)
          .delete();
      return true;
    } catch (e) {
      print('Error deleting BMI data: $e');
      return false;
    }
  }

  @override
  Future<Either<Failure, BMIModel>> editBMI(EditBMIParams editBMIParams) async {
    try {
      await FirebaseFirestore.instance
          .collection('bmi_data')
          .doc(editBMIParams.id)
          .update(editBMIParams.toMap());
      return Right(BMIModel(
          weight: editBMIParams.weight,
          height: editBMIParams.height,
          age: editBMIParams.age,
          timestamp: editBMIParams.time));
    } catch (e) {
      print('Error editing BMI data: $e');
      return Left(ServerFailure("Registration failed"));
    }
  }
}
