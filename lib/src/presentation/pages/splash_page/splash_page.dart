import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:isar/isar.dart';
import 'package:salen_academy/generated/l10n.dart';
import 'package:salen_academy/src/data/repositories/local_data_repository.dart';
import 'package:salen_academy/src/presentation/pages/home_page/home_page.dart';
import 'package:salen_academy/src/presentation/pages/welcome_page/welcome_page.dart';

import '../../../../injector_container.dart';

class SplashPage extends StatefulWidget {
  static const String routeName = 'splash';
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  init() async {
    await Isar.initializeIsarCore();
    await getItInit();
    String langCode = await LocalDataRepository.getLanguageCode();
    String accessToken = await LocalDataRepository.getAccessToken();
    await S.load(Locale(langCode));
    if (accessToken.isEmpty) {
      // ignore: use_build_context_synchronously
      context.goNamed(WelcomePage.routeName);
    } else {
      // ignore: use_build_context_synchronously
      context.goNamed(HomePage.routeName);
    }
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/logo.png',
          width: 150,
        ),
      ),
    );
  }
}
