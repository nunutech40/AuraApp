import '../../domain/entities/aura_entity.dart';

class AuraModel extends AuraEntity {
  const AuraModel({
    required super.imagePath,
    required super.score,
  });

  factory AuraModel.fromJson(Map<String, dynamic> json) {
    return AuraModel(
      imagePath: json['imagePath'] as String,
      score: (json['score'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imagePath': imagePath,
      'score': score,
    };
  }
}
