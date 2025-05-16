import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:salen_academy/generated/l10n.dart';
import 'package:salen_academy/src/data/repositories/local_data_repository.dart';
import 'package:salen_academy/src/presentation/pages/home_page/home_page.dart';
import 'package:salen_academy/src/presentation/pages/video_page/video_page.dart';
import 'package:salen_academy/src/presentation/pages/welcome_page/welcome_page.dart';
import '../../../../theme/theme_provider.dart';

class ProfilePage extends StatefulWidget {
  static const String routeName = '/profile';
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _image;
  final _picker = ImagePicker();

  // nav‐bar state
  int _currentIndex = 2;
  final _pages = [HomePage(), VideoPage(), ProfilePage()];

  Future<void> _pickImage() async {
    final file = await _picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      setState(() => _image = File(file.path));
    }
  }

  void _onTapNav(int idx) {
    setState(() => _currentIndex = idx);
    switch (idx) {
      case 0:
        context.go(HomePage.routeName);
        break;
      case 1:
        context.go(VideoPage.routeName);
        break;
      case 2:
        context.go(ProfilePage.routeName);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProv = Provider.of<ThemeProvider>(context);
    return Scaffold(
      // ─── APP BAR ───────────────────────────────
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF4e57f6), Color(0xFFe66465)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
          ),
        ),
        title: Row(
          children: [
            // Theme toggles
            _iconToggle(
                Icons.sunny, () => themeProv.toggleTheme(ThemeMode.light)),
            const SizedBox(width: 10),
            _iconToggle(Icons.nightlight_round_outlined,
                () => themeProv.toggleTheme(ThemeMode.dark)),
            const Spacer(),
            // Language selector
            _languageMenu(),
          ],
        ),
      ),

      // ─── BODY ──────────────────────────────────
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.grey.shade200,
                backgroundImage: _image != null ? FileImage(_image!) : null,
                child: _image == null
                    ? const Icon(Icons.person, size: 60, color: Colors.grey)
                    : null,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              S.current.profile_header, // e.g. “John Doe”
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'email', // e.g. user’s email
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: ElevatedButton.icon(
                onPressed: () async {
                  await LocalDataRepository.logout();
                  context.go(WelcomePage.routeName);
                },
                icon: const Icon(Icons.logout),
                label: Text('logout'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF4e57f6),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),

      // ─── BOTTOM NAVIGATION BAR ─────────────────
      bottomNavigationBar: Transform.translate(
        offset: const Offset(0, -10),
        child: Container(
          height: 80,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF4e57f6), Color(0xFFe66465)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(3, (i) {
                final icons = [
                  Icons.home_filled,
                  Icons.play_arrow_rounded,
                  Icons.person_outline,
                ];
                final labels = ['Home', 'Tutorial', 'Profile'];
                final active = _currentIndex == i;
                return GestureDetector(
                  onTap: () => _onTapNav(i),
                  child: Transform.translate(
                    offset: active ? const Offset(0, -25) : Offset.zero,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: active ? 70 : 40,
                          height: active ? 70 : 40,
                          decoration: BoxDecoration(
                            color: active ? Colors.white : Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            icons[i],
                            size: active ? 40 : 30,
                            color: active
                                ? Theme.of(context).primaryColor
                                : Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          labels[i],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: active ? 14 : 12,
                            fontWeight:
                                active ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  Widget _iconToggle(IconData icon, VoidCallback onTap) => Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child:
            IconButton(icon: Icon(icon, color: Colors.white), onPressed: onTap),
      );

  Widget _languageMenu() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: PopupMenuButton<String>(
        initialValue: LocalDataRepository.getLanguageCodeSync(),
        icon: const Icon(Icons.language, color: Colors.white),
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
