import '../entities/aura_entity.dart';
import '../repositories/i_aura_repository.dart';

class CalculateAuraUseCase {
  final IAuraRepository repository;

  CalculateAuraUseCase(this.repository);

  Future<List<AuraEntity>> execute(List<String> imagePaths) async {
    return await repository.calculateAuraScores(imagePaths);
  }
}
