
import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../data/data.dart';
import '../domain.dart';
import '../usecases/editBMI.dart';

abstract class BMIRepository {
  Future<Either<Failure, BMI>> saveBMI(SaveBMIParams SaveBMIParams);
  Future<Either<Failure, List<BMIModel>>> getBMIList();
  Future<Either<Failure, BMI>> editBMI(EditBMIParams editBMIParams);
}
