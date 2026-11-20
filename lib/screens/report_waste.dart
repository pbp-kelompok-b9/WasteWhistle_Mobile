import 'package:material_ui/material_ui.dart';

import '../widgets/bottom_navigation.dart';

const _green = Color(0xff05664e);
const _background = Color(0xfff8f8fd);
const _ink = Color(0xff18232c);

class ReportWastePage extends StatelessWidget {
  const ReportWastePage({super.key, this.tabIndex = 0});

  final int tabIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: _background,
        title: const Row(
          children: [
            Icon(Icons.eco, color: _green),
            SizedBox(width: 8),
            Text(
              'Waste Whistle',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavigation(
        currentIndex: tabIndex,
        onTap: (index) => Navigator.pop(context, index),
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
          children: [
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 540),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton.icon(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back, size: 18),
                        label: const Text('Kembali'),
                        style: TextButton.styleFrom(foregroundColor: _green),
                      ),
                    ),
                    const _ReportHeader(),
                    const SizedBox(height: 16),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const _ReportField(
                              label: 'Judul Laporan *',
                              hint: 'Contoh: Tumpukan sampah di pinggir kali',
                              limit: 120,
                            ),
                            const SizedBox(height: 20),
                            const Row(
                              children: [
                                Icon(
                                  Icons.pin_drop_outlined,
                                  size: 18,
                                  color: _green,
                                ),
                                SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    'Titik Lokasi Sampah *',
                                    style: _labelStyle,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const _MapPreview(),
                            const SizedBox(height: 12),
                            const _ReportField(
                              label: 'Patokan Lokasi / Catatan Landmark',
                              hint: 'Contoh: Di dekat jembatan penyeberangan',
                              limit: 200,
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'Unggah Foto Bukti Sampah',
                              style: _labelStyle,
                            ),
                            const SizedBox(height: 8),
                            const _InfoPanel(
                              color: Color(0xfff2f2fc),
                              icon: Icons.add_a_photo_outlined,
                              text: 'Belum ada foto bukti',
                            ),
                            const SizedBox(height: 20),
                            const _ReportField(
                              label: 'Deskripsi Tambahan *',
                              hint: 'Ceritakan kondisi sampah di lokasi.',
                              lines: 3,
                              limit: 2000,
                            ),
                            const SizedBox(height: 16),
                            const _InfoPanel(
                              color: Color(0xffd7faeb),
                              icon: Icons.eco_outlined,
                              text: '+10 Eco-Points per laporan baru',
                            ),
                            const SizedBox(height: 16),
                            FilledButton.icon(
                              onPressed: null,
                              icon: const Icon(Icons.send_outlined),
                              label: const Text('Kirim Laporan Sampah'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Batal'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const _labelStyle = TextStyle(
  color: _ink,
  fontSize: 15,
  fontWeight: FontWeight.w600,
);

class _ReportHeader extends StatelessWidget {
  const _ReportHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xff0a3025), Color(0xff10704f)],
        ),
      ),
      child: Stack(
        children: [
          const Positioned(
            right: -22,
            bottom: -24,
            child: Icon(Icons.radar, size: 144, color: Color(0x224de3a4)),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'LAPOR TITIK SAMPAH',
                  style: TextStyle(
                    color: Color(0xffa4efd2),
                    letterSpacing: 1,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                Semantics(
                  header: true,
                  child: const Text(
                    'Lapor Timbunan Sampah',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Pratinjau formulir · Pengiriman belum tersedia',
                  style: TextStyle(color: Color(0xffd5f2e7), fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ReportField extends StatelessWidget {
  const _ReportField({
    required this.label,
    required this.hint,
    required this.limit,
    this.lines = 1,
  });

  final String label, hint;
  final int lines, limit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(label, style: _labelStyle),
        const SizedBox(height: 6),
        Semantics(
          label: label,
          child: TextField(
            maxLines: lines,
            maxLength: limit,
            decoration: InputDecoration(
              hintText: hint,
              counterText: '',
              filled: true,
              fillColor: _background,
              hintStyle: const TextStyle(
                color: Color(0xff646973),
                fontSize: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _MapPreview extends StatelessWidget {
  const _MapPreview();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: SizedBox(
        height: 180,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/reporting/jakarta.png',
              fit: BoxFit.cover,
              excludeFromSemantics: true,
            ),
            const Align(
              alignment: Alignment(0.72, 0.2),
              child: Icon(
                Icons.location_on,
                size: 38,
                color: Color(0xffa52f2f),
              ),
            ),
            const Positioned(
              left: 8,
              top: 8,
              child: _MapCaption('Pratinjau lokasi · Jakarta'),
            ),
            const Positioned(
              right: 4,
              bottom: 4,
              child: _MapCaption('© OpenStreetMap contributors'),
            ),
          ],
        ),
      ),
    );
  }
}

class _MapCaption extends StatelessWidget {
  const _MapCaption(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
        child: Text(text, style: const TextStyle(fontSize: 11, color: _ink)),
      ),
    );
  }
}

class _InfoPanel extends StatelessWidget {
  const _InfoPanel({
    required this.color,
    required this.icon,
    required this.text,
  });

  final Color color;
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: _green),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: _green,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
