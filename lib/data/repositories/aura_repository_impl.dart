import '../../domain/entities/aura_entity.dart';
import '../../domain/repositories/i_aura_repository.dart';
import '../datasources/aura_native_datasource.dart';

class AuraRepositoryImpl implements IAuraRepository {
  final IAuraNativeDataSource nativeDataSource;

  AuraRepositoryImpl({required this.nativeDataSource});

  @override
  Future<List<AuraEntity>> calculateAuraScores(List<String> imagePaths) async {
    try {
      // Meminta data mentah dari Native Data Source
      final models = await nativeDataSource.calculateAura(imagePaths);
      
      // Mengembalikan data sebagai List<AuraEntity> ke Domain Layer
      return models;
    } catch (e) {
      // Menangkap error untuk nantinya bisa dirender oleh UI/Cubit
      throw Exception("Gagal mendapatkan skor aura dari repository: $e");
    }
  }
}
