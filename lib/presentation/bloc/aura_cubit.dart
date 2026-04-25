import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/calculate_aura_usecase.dart';
import 'aura_state.dart';

class AuraCubit extends Cubit<AuraState> {
  final CalculateAuraUseCase calculateAuraUseCase;

  AuraCubit({required this.calculateAuraUseCase}) : super(AuraInitial());

  Future<void> scanImages(List<String> imagePaths) async {
    if (imagePaths.isEmpty) return;

    // Memancarkan state bahwa aplikasi sedang melakukan scanning
    emit(AuraScanning());

    try {
      // Mengeksekusi Use Case (yang secara berantai memanggil Repository -> DataSource -> Native)
      final results = await calculateAuraUseCase.execute(imagePaths);
      
      // Mengurutkan hasil dari skor tertinggi ke terendah secara descending
      results.sort((a, b) => b.score.compareTo(a.score));

      // Memancarkan state sukses beserta data yang sudah disortir
      emit(AuraSuccess(results));
    } catch (e) {
      // Jika terjadi error dari Native atau Parsing, tangkap di sini
      emit(AuraError(e.toString()));
    }
  }

  void reset() {
    emit(AuraInitial());
  }
}
