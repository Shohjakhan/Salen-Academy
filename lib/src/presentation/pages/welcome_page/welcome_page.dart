import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:salen_academy/generated/l10n.dart';
import 'package:salen_academy/src/presentation/pages/home_page/home_page.dart';
import 'package:salen_academy/src/presentation/pages/sign_in/sign_in_page.dart';
import 'package:salen_academy/src/presentation/pages/sign_up/sing_up_page.dart';

class WelcomePage extends StatefulWidget {
  static const String routeName = '/welcome';
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Image.asset(
                'assets/images/logo_updated.png',
                width: 200,
              ),
            ),
            SizedBox(height: 5),
            Text(
              S.current.welcome_text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 0, 58, 158)),
            ),
            SizedBox(height: 5),
            Text(
              S.current.welcome_text_2,
              maxLines: 3,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 80),
            InkWell(
              onTap: () {
                context.pushNamed(SignUpPage.routeName);
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                        colors: [Color(0xFF4e57f6), Color(0xFFe66465)])),
                child: Center(
                  child: Text(
                    S.current.btn_get_started,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                context.pushNamed(SignInPage.routeName);
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                child: Center(
                  child: Text(
                    S.current.btn_log_in,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                context.pushNamed(HomePage.routeName);
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                child: Center(
                  child: Text(
                    "Home page",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
