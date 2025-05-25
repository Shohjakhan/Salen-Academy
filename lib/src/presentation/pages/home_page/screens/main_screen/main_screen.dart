import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salen_academy/generated/l10n.dart';
import 'package:salen_academy/theme/theme_provider.dart';

import '../../../../../data/repositories/local_data_repository.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF4e57f6), Color(0xFFe66465)],
              ),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
        ),
        title: Row(
          children: [
            _buildToggleIcon(
                Icons.sunny, () => themeProvider.toggleTheme(ThemeMode.light)),
            const SizedBox(width: 10),
            _buildToggleIcon(Icons.nightlight_round_outlined,
                () => themeProvider.toggleTheme(ThemeMode.dark)),
            const Spacer(),
            _buildLanguageSelector(),
          ],
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Text(S.current.main_screen_text,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      const Text(
                          'Get step-by-step solutions to complex equations',
                          textAlign: TextAlign.center),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Image.asset('assets/images/main_image.png',
                    width: 200, height: 200),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildToggleIcon(IconData icon, VoidCallback onTap) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconButton(
        icon: Icon(icon, size: 30, color: Colors.white),
        onPressed: onTap,
      ),
    );
  }

  Widget _buildLanguageSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: PopupMenuButton<String>(
        initialValue: LocalDataRepository.getLanguageCodeSync(),
        child: Row(
          children: [
            Text("Til",
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w600)),
            const SizedBox(width: 10),
            const Icon(Icons.language, color: Colors.white),
          ],
        ),
        onSelected: (code) {
          S.load(Locale(code));
          LocalDataRepository.setLanguageCodeSync(code);
          setState(() {});
        },
        itemBuilder: (_) => const [
          PopupMenuItem(value: 'en', child: Text('English')),
          PopupMenuItem(value: 'ru', child: Text('Русский')),
          PopupMenuItem(value: 'uz', child: Text("O'zbekcha")),
        ],
      ),
    );
  }
}
