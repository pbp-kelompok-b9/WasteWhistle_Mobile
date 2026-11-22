import 'package:material_ui/material_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/menu.dart';

const _green = Color(0x006C49);
const _background = Color(0xfff8f8fd);
const _ink = Color(0xff18232c);

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Waste Whistle',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: _green,
          secondary: _background,
        ),
        scaffoldBackgroundColor: _background, // background utama
        useMaterial3: true,
        textTheme: GoogleFonts.plusJakartaSansTextTheme()
      ),
      home: const MyHomePage(),
    );
  }
}
