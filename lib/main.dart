import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection.dart';
import 'presentation/bloc/aura_cubit.dart';
import 'presentation/pages/home_page.dart';

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
    // Membungkus aplikasi dengan MultiBlocProvider agar Cubit bisa diakses secara global
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<AuraCubit>()),
      ],
      child: MaterialApp(
        title: 'AuraMeter',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.cyanAccent, 
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
