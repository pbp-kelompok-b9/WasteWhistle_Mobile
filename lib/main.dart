import 'package:material_ui/material_ui.dart';
import 'screens/menu.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Waste Whistle',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          secondary: Colors.lightGreen,
        ),
        scaffoldBackgroundColor: const Color(0xFFEEF6F1), // background utama
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}
