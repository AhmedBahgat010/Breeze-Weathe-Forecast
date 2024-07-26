
import 'package:dartz/dartz.dart';
import '../../../../core/core.dart';
import '../domain.dart';
import '../repositories/BMI_repository.dart';

class GetBMIList extends UseCase<List<BMI>, NoParams> {
  final BMIRepository repository;

  GetBMIList(this.repository);

  @override
  Future<Either<Failure, List<BMI>>> call(NoParams params) async {
    return await repository.getBMIList();
  }
}
