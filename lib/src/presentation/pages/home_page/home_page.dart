import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:salen_academy/generated/l10n.dart';
import 'package:salen_academy/src/data/repositories/local_data_repository.dart';
import 'package:salen_academy/src/domain/video_cubit/video_cubit.dart';
import 'package:salen_academy/src/presentation/pages/profile_page/profile_page.dart';
import 'package:salen_academy/src/presentation/pages/video_page/video_page.dart';
import '../../../../theme/theme_provider.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final _pages = [HomeContent(), VideoPage(), ProfilePage()];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<VideoCubit>(context).socketInit();
  }

  void _onTapNav(int index) {
    setState(() => _currentIndex = index);
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 2:
        context.goNamed(VideoPage.routeName);
        break;
      case 3:
        context.goNamed(ProfilePage.routeName);
        break;
    }
  }

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
      body: _pages[_currentIndex],
      bottomNavigationBar: Transform.translate(
        offset: const Offset(0, -10), // lift the bar by 10px
        child: Container(
          height: 80,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF4e57f6), Color(0xFFe66465)],
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) {
                final icons = [
                  Icons.home_filled,
                  Icons.play_arrow_rounded,
                  Icons.chat_rounded,
                  Icons.person_outlined
                ];
                final labels = ['Home', 'Tutorial', 'Chat', 'Profile'];
                final isActive = _currentIndex == index;
                return GestureDetector(
                  onTap: () => _onTapNav(index),
                  child: Transform.translate(
                    offset: isActive ? const Offset(0, -25) : Offset.zero,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: isActive ? 70 : 40,
                          height: isActive ? 70 : 40,
                          decoration: BoxDecoration(
                            color: isActive ? Colors.white : Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            icons[index],
                            size: isActive ? 40 : 30,
                            color: isActive
                                ? Theme.of(context).primaryColor
                                : Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          labels[index],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isActive ? 14 : 12,
                            fontWeight:
                                isActive ? FontWeight.bold : FontWeight.normal,
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
            Text(S.current.title_language,
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

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                  children: const [
                    Text('Math Problems',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text('Get step-by-step solutions to complex equations',
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
    );
  }
}
