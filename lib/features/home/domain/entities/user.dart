import 'package:equatable/equatable.dart';
import '../../data/models/models.dart';

class BMI extends Equatable implements Comparable<BMIModel> {
  final String? id;
  final int weight;
  final int height;
  final int age;
  final DateTime timestamp;

  const BMI({
    this.id,
    required this.weight,
    required this.height,
    required this.age,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [id, weight, height, age, timestamp];

  @override
  int compareTo(BMI other) {
    return timestamp.compareTo(other.timestamp);
  }
}
