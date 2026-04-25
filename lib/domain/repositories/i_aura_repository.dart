import '../entities/aura_entity.dart';

abstract class IAuraRepository {
  Future<List<AuraEntity>> calculateAuraScores(List<String> imagePaths);
}
