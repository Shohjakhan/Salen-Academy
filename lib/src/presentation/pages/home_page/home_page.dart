import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salen_academy/src/domain/profile_cubit/profile_cubit.dart';
import 'package:salen_academy/src/domain/video_cubit/video_cubit.dart';
import 'package:salen_academy/src/presentation/pages/home_page/screens/main_screen/main_screen.dart';
import 'package:salen_academy/src/presentation/pages/home_page/screens/profile_screen/profile_screen.dart';
import 'package:salen_academy/src/presentation/pages/home_page/screens/tutorial_screen/tutorial_screen.dart';
import 'package:salen_academy/src/presentation/pages/home_page/screens/video_page/video_page.dart';

class HomePage extends StatefulWidget {
  static const String routeName = 'home_page';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  final PageController pageController = PageController(initialPage: 0);

  int _currentIndex = 0;
  final _pages = [MainScreen(), VideoPage(), TutorialScreen(), ProfileScreen()];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<VideoCubit>(context).socketInit();
    BlocProvider.of<ProfileCubit>(context).getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        items: <Widget>[
          Icon(Icons.home_filled, size: 30, color: Colors.black),
          Icon(Icons.chat_rounded, size: 30, color: Colors.black),
          Icon(Icons.play_arrow_rounded, size: 30, color: Colors.black),
          Icon(Icons.person_outlined, size: 30, color: Colors.black),
        ],
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 500),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            pageController.animateToPage(
              _currentIndex,
              duration: Duration(milliseconds: 500),
              curve: Curves.linear,
            );
          });
        },
        letIndexChange: (index) => true,
      ),
      body: Center(
        child: PageView(
          controller: pageController,
          onPageChanged: (value) {
            final CurvedNavigationBarState? navBarState =
                _bottomNavigationKey.currentState;
            navBarState?.setPage(value);
          },
          children: _pages,
        ),
      ),
    );
  }
}
