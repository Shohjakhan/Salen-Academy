import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:salen_academy/generated/l10n.dart';
import 'package:salen_academy/src/data/repositories/local_data_repository.dart';
import 'package:salen_academy/src/presentation/pages/chat_history/chat_history.dart';
import 'package:salen_academy/src/presentation/pages/profile_page/profile_page.dart';
import 'package:salen_academy/src/presentation/pages/video_page/video_page.dart';

import '../../../../theme/theme_provider.dart';

class HomePage extends StatefulWidget {
  static const String routeName = 'home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          children: [
            _buildNeomorphicIconThemeMode(
              Icons.sunny,
              () {
                themeProvider.toggleTheme(ThemeMode.light);
              },
            ),
            const SizedBox(width: 10),
            _buildNeomorphicIconThemeMode(
              Icons.nightlight_round_outlined,
              () {
                themeProvider.toggleTheme(ThemeMode.dark);
              },
            ),
            const Spacer(),
            _buildLanguageSelector(),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Search Tutorials Button
              Column(
                children: [
                  SizedBox(height: 30),
                  _buildNeomorphicButton(
                    S.current.btn_generate_tutorials,
                    Icons.search,
                    () {
                      context.pushNamed(VideoPage.routeName);
                    },
                  ),
                ],
              ),
              // 3D Panda Image
              Column(
                children: [
                  Container(
                    decoration: _neomorphicDecoration(),
                    padding: const EdgeInsets.all(15),
                    child: const Image(
                      height: 200,
                      width: 200,
                      image: AssetImage('assets/images/main_image.png'),
                    ),
                  ),
                  SizedBox(height: 30),
                  // Description Text
                  Text(
                    S.current.main_text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              // Bottom Navigation Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNeomorphicIcon(context, Icons.analytics, () {}),
                  _buildNeomorphicIcon(context, Icons.article, () {
                    context.pushNamed(HistoryPage.routeName);
                  }),
                  _buildNeomorphicIcon(context, Icons.person, () {
                    context.pushNamed(ProfilePage.routeName);
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNeomorphicIcon(
    BuildContext context,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return Container(
      decoration: _buttonDecoration(context),
      child: IconButton(
        icon: Icon(
          icon,
          size: 50,
        ),
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildNeomorphicIconThemeMode(IconData icon, VoidCallback onPressed) {
    return Container(
      decoration: _buttonDecoration(context),
      child: IconButton(
        icon: Icon(
          icon,
          size: 30,
        ),
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildLanguageSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: _neomorphicDecoration(),
      child: PopupMenuButton<String>(
        initialValue: S.current.language,
        child: Row(
          children: [
            Text(
              S.current.title_language,
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.language,
            ),
          ],
        ),
        onSelected: (String item) {
          setState(() {
            switch (item) {
              case 'uz':
                S.load(Locale('uz'));
                break;
              case 'ru':
                S.load(Locale('ru'));
                break;
              case 'en':
                S.load(Locale('en'));
                break;
              default:
            }
            LocalDataRepository.setLanguageCodeSync(item);
          });
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          const PopupMenuItem<String>(
            value: 'en',
            child: Text('English'),
          ),
          const PopupMenuItem<String>(
            value: 'ru',
            child: Text('Русский'),
          ),
          const PopupMenuItem<String>(
            value: 'uz',
            child: Text('O`zbekcha'),
          ),
        ],
      ),
    );
  }

  Widget _buildNeomorphicButton(
      String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: _buttonDecoration(context),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            const SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _neomorphicDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      color: Colors.white.withOpacity(0.1),
      boxShadow: [
        BoxShadow(
          offset: const Offset(-4, -4),
          color: Colors.white.withOpacity(0.1),
          blurRadius: 6,
        ),
        BoxShadow(
          offset: const Offset(4, 4),
          color: Colors.black.withOpacity(0.1),
          blurRadius: 6,
        ),
      ],
    );
  }

  BoxDecoration _buttonDecoration(BuildContext context) {
    return BoxDecoration(
      color: const Color(0xFFffa130),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.orangeAccent.withOpacity(0.5),
          offset: const Offset(4, 4),
          blurRadius: 6,
        ),
      ],
    );
  }
}
