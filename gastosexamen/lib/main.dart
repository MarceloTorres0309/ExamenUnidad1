import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/gastos_view_model.dart';
import 'screens/principal_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GastosViewModel(),
      child: MaterialApp(
        title: 'Control de Gastos',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          useMaterial3: true,
        ),
        home: const PrincipalScreen(),
      ),
    );
  }
}