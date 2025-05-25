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
    final name = (locale.countryCode?.isEmpty ?? false)
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

  /// `← Mavjud hisobga kirish`
  String get alr_acc {
    return Intl.message(
      '← Mavjud hisobga kirish',
      name: 'alr_acc',
      desc: '',
      args: [],
    );
  }

  /// `Hisob yaratish →`
  String get btn_create_acc {
    return Intl.message(
      'Hisob yaratish →',
      name: 'btn_create_acc',
      desc: '',
      args: [],
    );
  }

  /// `Ro'yxatdan o'tish`
  String get btn_get_started {
    return Intl.message(
      'Ro\'yxatdan o\'tish',
      name: 'btn_get_started',
      desc: '',
      args: [],
    );
  }

  /// `Kirish`
  String get btn_log_in {
    return Intl.message('Kirish', name: 'btn_log_in', desc: '', args: []);
  }

  /// `Hisobdan chiqish`
  String get btn_log_out {
    return Intl.message(
      'Hisobdan chiqish',
      name: 'btn_log_out',
      desc: '',
      args: [],
    );
  }

  /// `Yangi chat`
  String get btn_new_chat {
    return Intl.message('Yangi chat', name: 'btn_new_chat', desc: '', args: []);
  }

  /// `Hisobga kirish →`
  String get btn_sign_in {
    return Intl.message(
      'Hisobga kirish →',
      name: 'btn_sign_in',
      desc: '',
      args: [],
    );
  }

  /// `Boshlash uchun hisobingizni yarating`
  String get create_account {
    return Intl.message(
      'Boshlash uchun hisobingizni yarating',
      name: 'create_account',
      desc: '',
      args: [],
    );
  }

  /// `Hisobin mavjud emas +`
  String get dont_acc {
    return Intl.message(
      'Hisobin mavjud emas +',
      name: 'dont_acc',
      desc: '',
      args: [],
    );
  }

  /// `Parolingizni tasdiqlang`
  String get error_msg_cpassword {
    return Intl.message(
      'Parolingizni tasdiqlang',
      name: 'error_msg_cpassword',
      desc: '',
      args: [],
    );
  }

  /// `Iltimos, elektron pochtangizni kiriting`
  String get error_msg_email {
    return Intl.message(
      'Iltimos, elektron pochtangizni kiriting',
      name: 'error_msg_email',
      desc: '',
      args: [],
    );
  }

  /// `Yaroqli elektron pochta manzilini kiriting`
  String get error_msg_email_2 {
    return Intl.message(
      'Yaroqli elektron pochta manzilini kiriting',
      name: 'error_msg_email_2',
      desc: '',
      args: [],
    );
  }

  /// `Iltimos, parolingizni kiriting`
  String get error_msg_password {
    return Intl.message(
      'Iltimos, parolingizni kiriting',
      name: 'error_msg_password',
      desc: '',
      args: [],
    );
  }

  /// `Parol kamida 6 ta belgidan iborat bo'lishi kerak`
  String get error_msg_password_2 {
    return Intl.message(
      'Parol kamida 6 ta belgidan iborat bo\'lishi kerak',
      name: 'error_msg_password_2',
      desc: '',
      args: [],
    );
  }

  /// `Iltimos, foydalanuvchi nomingizni kiriting`
  String get error_msg_username {
    return Intl.message(
      'Iltimos, foydalanuvchi nomingizni kiriting',
      name: 'error_msg_username',
      desc: '',
      args: [],
    );
  }

  /// `Parollar mos kelmaydi!`
  String get error_password {
    return Intl.message(
      'Parollar mos kelmaydi!',
      name: 'error_password',
      desc: '',
      args: [],
    );
  }

  /// `Parolni tasdiqlang`
  String get field_cpassword {
    return Intl.message(
      'Parolni tasdiqlang',
      name: 'field_cpassword',
      desc: '',
      args: [],
    );
  }

  /// `Elektron pochta`
  String get field_email {
    return Intl.message(
      'Elektron pochta',
      name: 'field_email',
      desc: '',
      args: [],
    );
  }

  /// `Yangi parol`
  String get field_npassword {
    return Intl.message(
      'Yangi parol',
      name: 'field_npassword',
      desc: '',
      args: [],
    );
  }

  /// `Parol`
  String get field_password {
    return Intl.message('Parol', name: 'field_password', desc: '', args: []);
  }

  /// `Soʻrovingizni shu yerga kiriting...`
  String get field_promt {
    return Intl.message(
      'Soʻrovingizni shu yerga kiriting...',
      name: 'field_promt',
      desc: '',
      args: [],
    );
  }

  /// `Foydalanuvchi nomi`
  String get field_username {
    return Intl.message(
      'Foydalanuvchi nomi',
      name: 'field_username',
      desc: '',
      args: [],
    );
  }

  /// `Parolni unutdingizmi?`
  String get forgot_password {
    return Intl.message(
      'Parolni unutdingizmi?',
      name: 'forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Salen Academyga qo'shiling`
  String get join_text {
    return Intl.message(
      'Salen Academyga qo\'shiling',
      name: 'join_text',
      desc: '',
      args: [],
    );
  }

  /// `Matematika masalalarimi?`
  String get main_screen_text {
    return Intl.message(
      'Matematika masalalarimi?',
      name: 'main_screen_text',
      desc: '',
      args: [],
    );
  }

  /// `Murakkab muammolarga bosqichma-bosqich yechim oling`
  String get main_screen_text_2 {
    return Intl.message(
      'Murakkab muammolarga bosqichma-bosqich yechim oling',
      name: 'main_screen_text_2',
      desc: '',
      args: [],
    );
  }

  /// `Tez kunlarda...`
  String get msg_tutorial {
    return Intl.message(
      'Tez kunlarda...',
      name: 'msg_tutorial',
      desc: '',
      args: [],
    );
  }

  /// `Profil sahifasi`
  String get profile_page {
    return Intl.message(
      'Profil sahifasi',
      name: 'profile_page',
      desc: '',
      args: [],
    );
  }

  /// `Meni eslab qol`
  String get rem_me {
    return Intl.message('Meni eslab qol', name: 'rem_me', desc: '', args: []);
  }

  /// `Hisobingizga kiring`
  String get sign_in_text {
    return Intl.message(
      'Hisobingizga kiring',
      name: 'sign_in_text',
      desc: '',
      args: [],
    );
  }

  /// `AI matematik masalalarni yechish`
  String get title_generator {
    return Intl.message(
      'AI matematik masalalarni yechish',
      name: 'title_generator',
      desc: '',
      args: [],
    );
  }

  /// `Video darslik`
  String get video_tutorial {
    return Intl.message(
      'Video darslik',
      name: 'video_tutorial',
      desc: '',
      args: [],
    );
  }

  /// `Qaytganingiz bilan`
  String get welcome_back {
    return Intl.message(
      'Qaytganingiz bilan',
      name: 'welcome_back',
      desc: '',
      args: [],
    );
  }

  /// `Ta'limingizni o'zgartirishga tayyormisiz?`
  String get welcome_text {
    return Intl.message(
      'Ta\'limingizni o\'zgartirishga tayyormisiz?',
      name: 'welcome_text',
      desc: '',
      args: [],
    );
  }

  /// `Salen Academy bilan aqlliroq o'rganayotgan minglab talabalarga qo'shiling.`
  String get welcome_text_2 {
    return Intl.message(
      'Salen Academy bilan aqlliroq o\'rganayotgan minglab talabalarga qo\'shiling.',
      name: 'welcome_text_2',
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
