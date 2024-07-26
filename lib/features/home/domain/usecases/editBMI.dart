
import 'package:dartz/dartz.dart';
import '../../../../core/core.dart';
import '../domain.dart';
import '../repositories/BMI_repository.dart';

class EditBMI extends UseCase<BMI, EditBMIParams> {
  final BMIRepository _repo;

  EditBMI(this._repo);

  @override
  Future<Either<Failure, BMI>> call(EditBMIParams params) {
    return _repo.editBMI(params);
  }
}

class EditBMIParams {
  final int weight;
  final int height;
  final int age;
  final String id;
  final String Uid;

  final DateTime time;

  EditBMIParams({
    required this.weight,
    required this.height,
    required this.age,
    required this.Uid,
    required this.time,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      "weight": weight,
      "height": height,
      "age": age,
      "timestamp": time,
      "id": Uid,
    };
  }
}
