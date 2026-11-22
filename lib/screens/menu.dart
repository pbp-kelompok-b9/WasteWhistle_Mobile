import 'package:material_ui/material_ui.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:google_fonts/google_fonts.dart';

import '../widgets/bottom_navigation.dart';
import 'education.dart';
import 'explore.dart';
import 'report_waste.dart';
import 'rewards.dart';
import 'waste_bank.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  // Urutannya harus sama dengan urutan di bottom navigation
  final List<Widget> _pages = const [
    HomeContent(),
    ExplorePage(),
    WasteBankPage(),
    EducationPage(),
    RewardsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // === Top bar ===
      appBar: AppBar
      (
        title: Row // buat icon dan text
        (
            mainAxisSize: MainAxisSize.min, 
            crossAxisAlignment: CrossAxisAlignment.center,
            children: 
            [
              SvgPicture.asset(
                'assets/icons/favicon.svg',
                height: 32, 
                width: 32,
              ),
              const SizedBox(width: 4),
              Text
              (
              "Waste Whistle",
              style: TextStyle
              (
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),

              ),
        ],
      ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        foregroundColor: Colors.black,
      ),
      floatingActionButton: FloatingActionButton.extended
      (
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ReportWastePage())),
          tooltip: "Lapor Sampah",
          icon: const Icon(Icons.campaign),
          label: const Text("Lapor Sampah"),
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.secondary,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      body: _pages[_currentIndex],

      // === Bottom navigation ===
      bottomNavigationBar: AppBottomNavigation(
        currentIndex: _currentIndex,
        onTap: (index) 
        {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

// Isi homepage (tab Beranda)
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.eco, size: 80, color: Theme.of(context).colorScheme.primary),
          SizedBox(height: 16),
          Text(
            'Selamat datang di Waste Whistle!',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
