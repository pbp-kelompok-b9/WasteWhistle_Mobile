import 'package:material_ui/material_ui.dart';

class WasteBankPage extends StatefulWidget {
  const WasteBankPage({super.key});

  @override
  State<WasteBankPage> createState() => _WasteBankPageState();
}

class _WasteBankPageState extends State<WasteBankPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Direktori Bank Sampah',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}