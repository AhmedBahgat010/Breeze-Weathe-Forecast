
import 'package:dartz/dartz.dart';
import '../../../../core/error/error.dart';

import '../../../../utils/services/hive/main_box.dart';
import '../../domain/domain.dart';
import '../../domain/repositories/BMI_repository.dart';
import '../../domain/usecases/SaveBMI.dart';
import '../../domain/usecases/editBMI.dart';
import '../data.dart';
import '../datasources/bmi_remote_datasources.dart';

class BMIRepositoryImpl implements BMIRepository {
  final BMIRemoteDatasource bmiRemoteDatasource;
  final MainBoxMixin mainBoxMixin;

  const BMIRepositoryImpl(this.bmiRemoteDatasource, this.mainBoxMixin);

  @override
  Future<Either<Failure, BMIModel>> saveBMI(SaveBMIParams saveBMIParams) async {
    final response = await bmiRemoteDatasource.saveBMI(saveBMIParams);

    return response.fold(
      (failure) => Left(failure),
      (bmiModel) => Right(bmiModel),
    );
  }

  Future<Either<Failure, List<BMIModel>>> getBMIList() async {
    return await bmiRemoteDatasource.getBMIList();
  }

  @override
  Future<bool> deleteBMI(String bmiId) async {
    final result = await bmiRemoteDatasource.deleteBMI(bmiId);
    return result;
  }

  @override
  Future<Either<Failure, BMI>> editBMI(EditBMIParams editBMIParams) async {
    final result = await bmiRemoteDatasource.editBMI(editBMIParams);
    return result.fold(
      (failure) => Left(failure),
      (bmiModel) => Right(bmiModel),
    );
  }
}
