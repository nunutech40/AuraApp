import 'package:equatable/equatable.dart';

class AuraEntity extends Equatable {
  final String imagePath;
  final double score;

  const AuraEntity({
    required this.imagePath,
    required this.score,
  });

  @override
  List<Object?> get props => [imagePath, score];
}
