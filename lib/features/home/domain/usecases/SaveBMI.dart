
import 'package:dartz/dartz.dart';
import '../../../../core/core.dart';
import '../domain.dart';
import '../repositories/BMI_repository.dart';

class SaveBMI extends UseCase<BMI, SaveBMIParams> {
  final BMIRepository _repo;

  SaveBMI(this._repo);

  @override
  Future<Either<Failure, BMI>> call(SaveBMIParams params) {
    return _repo.saveBMI(params);
  }
}

class SaveBMIParams {
  final int weight;
  final int height;
  final int age;
  final String id;
  final DateTime time;

  SaveBMIParams({
    required this.weight,
    required this.height,
    required this.age,
    required this.time,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      "weight": weight,
      "height": height,
      "age": age,
      "timestamp": time,
      "id": id,
    };
  }
}
