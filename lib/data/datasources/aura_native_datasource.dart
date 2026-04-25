import 'package:flutter/services.dart';
import '../models/aura_model.dart';

abstract class IAuraNativeDataSource {
  Future<List<AuraModel>> calculateAura(List<String> imagePaths);
}

class AuraNativeDataSourceImpl implements IAuraNativeDataSource {
  static const MethodChannel _channel = MethodChannel('com.nunu.auraapp/engine');

  @override
  Future<List<AuraModel>> calculateAura(List<String> imagePaths) async {
    try {
      // Mengirim list string (image paths) ke OS Native
      final List<dynamic>? result = await _channel.invokeMethod('calculateAura', {
        'imagePaths': imagePaths,
      });

      if (result != null) {
        // Parsing balasan array dari Native Swift menjadi List<AuraModel>
        return result.map((item) {
          final map = Map<String, dynamic>.from(item as Map);
          return AuraModel.fromJson(map);
        }).toList();
      }
      return [];
    } on PlatformException catch (e) {
      throw Exception("Gagal memproses perhitungan Aura di Native: ${e.message}");
    } catch (e) {
      throw Exception("Terjadi kesalahan tak terduga: $e");
    }
  }
}
