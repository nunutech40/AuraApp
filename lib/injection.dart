import 'package:get_it/get_it.dart';

import 'data/datasources/aura_native_datasource.dart';
import 'data/repositories/aura_repository_impl.dart';
import 'domain/repositories/i_aura_repository.dart';
import 'domain/usecases/calculate_aura_usecase.dart';
import 'presentation/bloc/aura_cubit.dart';

final sl = GetIt.instance; // Service Locator

Future<void> initInjection() async {
  // 1. Blocs / Cubits
  // Didaftarkan sebagai Factory karena Cubit bisa di-recreate berulang kali di UI jika dibutuhkan
  sl.registerFactory(() => AuraCubit(calculateAuraUseCase: sl()));

  // 2. Use Cases
  // Didaftarkan sebagai LazySingleton karena statis dan hanya memegang reference Repository
  sl.registerLazySingleton(() => CalculateAuraUseCase(sl()));

  // 3. Repositories
  sl.registerLazySingleton<IAuraRepository>(
    () => AuraRepositoryImpl(nativeDataSource: sl()),
  );

  // 4. Data Sources
  sl.registerLazySingleton<IAuraNativeDataSource>(
    () => AuraNativeDataSourceImpl(),
  );
}
