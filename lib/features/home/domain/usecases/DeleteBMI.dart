
import 'package:dartz/dartz.dart';

import '../../../../core/error/error.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/data.dart';

class DeleteBMI extends UseCase<bool, String> {
  final BMIRemoteDatasource repository;

  DeleteBMI(this.repository);

  @override
  Future<Either<Failure, bool>> call(String bmiId) async {
    try {
      final result = await repository.deleteBMI(bmiId);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure("Failed to delete BMI data"));
    }
  }
}
