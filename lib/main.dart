import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection.dart';
import 'presentation/bloc/aura_cubit.dart';

void main() async {
  // Wajib dipanggil untuk inisialisasi binding Flutter sebelum memanggil method async (seperti injection)
  WidgetsFlutterBinding.ensureInitialized();
  
  // Menjalankan Dependency Injection
  await initInjection();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Membungkus aplikasi dengan MultiBlocProvider agar Cubit bisa diakses secara global (kalau dibutuhkan)
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<AuraCubit>()),
      ],
      child: MaterialApp(
        title: 'BidadariMeter',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple, 
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
        ),
        home: const Scaffold(
          body: Center(
            child: Text('AuraApp Phase 4 Completed: DI & State Ready'),
          ),
        ),
      ),
    );
  }
}
