// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `AI orqali darslik tayyorlash`
  String get btn_ai_tutorial_generator {
    return Intl.message(
      'AI orqali darslik tayyorlash',
      name: 'btn_ai_tutorial_generator',
      desc: '',
      args: [],
    );
  }

  /// `Darsliklarni yaratish`
  String get btn_generate_tutorials {
    return Intl.message(
      'Darsliklarni yaratish',
      name: 'btn_generate_tutorials',
      desc: '',
      args: [],
    );
  }

  /// `Ro'yxatdan o'tish`
  String get btn_sign_up {
    return Intl.message(
      'Ro`yxatdan o`tish',
      name: 'btn_sign_up',
      desc: '',
      args: [],
    );
  }

  /// `Tizimga kirish`
  String get btn_sing_in {
    return Intl.message(
      'Tizimga kirish',
      name: 'btn_sing_in',
      desc: '',
      args: [],
    );
  }

  /// `Darsliklarni yaratish`
  String get hint_generate_tutorials {
    return Intl.message(
      'Darsliklarni yaratish',
      name: 'hint_generate_tutorials',
      desc: '',
      args: [],
    );
  }

  /// `uz`
  String get language {
    return Intl.message('uz', name: 'language', desc: '', args: []);
  }

  /// `Assalomu alaykum, bugun nimani oʻrganmoqchisiz?\nOʻquv qoʻllanmalarini yaratib koʻring yoki ularni qidiring.`
  String get main_text {
    return Intl.message(
      'Assalomu alaykum, bugun nimani oʻrganmoqchisiz?\nOʻquv qoʻllanmalarini yaratib koʻring yoki ularni qidiring.',
      name: 'main_text',
      desc: '',
      args: [],
    );
  }

  /// `O'zingizning videolaringizni yarating`
  String get text_generate_videos {
    return Intl.message(
      'O`zingizning videolaringizni yarating',
      name: 'text_generate_videos',
      desc: '',
      args: [],
    );
  }

  /// `O'zbekcha`
  String get title_language {
    return Intl.message(
      'O`zbekcha',
      name: 'title_language',
      desc: '',
      args: [],
    );
  }

  /// `Har qanday mavzuni o'rganishning eng yaxshi va eng samarali usuli.`
  String get welcome_text {
    return Intl.message(
      'Har qanday mavzuni o`rganishning eng yaxshi va eng samarali usuli.',
      name: 'welcome_text',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'uz'),
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
