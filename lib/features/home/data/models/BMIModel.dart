import '../../domain/domain.dart';

class BMIModel extends BMI {
  BMIModel({
    super.id,
    required super.weight,
    required super.height,
    required super.age,
    required super.timestamp,
  });

  factory BMIModel.fromJson(Map<String, dynamic> json) {
    return BMIModel(
      id: json['id'],
      weight: json['weight'].toDouble(),
      height: json['height'].toDouble(),
      age: json['age'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'weight': weight,
      'height': height,
      'age': age,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
