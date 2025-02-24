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

  /// `Profil rasmini o'zgartirish`
  String get btn_change_pic {
    return Intl.message(
      'Profil rasmini o\'zgartirish',
      name: 'btn_change_pic',
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

  /// `O'zgarishlarni saqlash`
  String get btn_save_changes {
    return Intl.message(
      'O\'zgarishlarni saqlash',
      name: 'btn_save_changes',
      desc: '',
      args: [],
    );
  }

  /// `Tizimga kirish`
  String get btn_sign_in_2 {
    return Intl.message(
      'Tizimga kirish',
      name: 'btn_sign_in_2',
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

  /// `Ro'yxatdan o'tish`
  String get btn_sign_up_2 {
    return Intl.message(
      'Ro\'yxatdan o\'tish',
      name: 'btn_sign_up_2',
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

  /// `Profil rasmini o'zgartirish`
  String get change_pic {
    return Intl.message(
      'Profil rasmini o\'zgartirish',
      name: 'change_pic',
      desc: '',
      args: [],
    );
  }

  /// `Darslik tarixi`
  String get chat_history {
    return Intl.message(
      'Darslik tarixi',
      name: 'chat_history',
      desc: '',
      args: [],
    );
  }

  /// `Profil rasmini o'zgartirish`
  String get edit_profile {
    return Intl.message(
      'Profil rasmini o\'zgartirish',
      name: 'edit_profile',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get field_confirm_password {
    return Intl.message(
      'Confirm Password',
      name: 'field_confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Parolingizni tasdiqlang`
  String get field_confirm_password_text {
    return Intl.message(
      'Parolingizni tasdiqlang',
      name: 'field_confirm_password_text',
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

  /// `Yaroqli elektron pochta manzilini kiriting`
  String get field_email_text {
    return Intl.message(
      'Yaroqli elektron pochta manzilini kiriting',
      name: 'field_email_text',
      desc: '',
      args: [],
    );
  }

  /// `Parol`
  String get field_password {
    return Intl.message('Parol', name: 'field_password', desc: '', args: []);
  }

  /// `Parol`
  String get field_password_2 {
    return Intl.message('Parol', name: 'field_password_2', desc: '', args: []);
  }

  /// `Iltimos, parolingizni kiriting`
  String get field_password_2_text {
    return Intl.message(
      'Iltimos, parolingizni kiriting',
      name: 'field_password_2_text',
      desc: '',
      args: [],
    );
  }

  /// `Iltimos, parolingizni kiriting`
  String get field_password_text {
    return Intl.message(
      'Iltimos, parolingizni kiriting',
      name: 'field_password_text',
      desc: '',
      args: [],
    );
  }

  /// `Parol kamida 6 ta belgidan iborat bo'lishi kerak`
  String get field_password_text_2 {
    return Intl.message(
      'Parol kamida 6 ta belgidan iborat bo\'lishi kerak',
      name: 'field_password_text_2',
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

  /// `Foydalanuvchi nomi`
  String get field_username_2 {
    return Intl.message(
      'Foydalanuvchi nomi',
      name: 'field_username_2',
      desc: '',
      args: [],
    );
  }

  /// `Пожалуйста, введите ваше имя пользователя`
  String get field_username_2_text {
    return Intl.message(
      'Пожалуйста, введите ваше имя пользователя',
      name: 'field_username_2_text',
      desc: '',
      args: [],
    );
  }

  /// `Iltimos, foydalanuvchi nomingizni kiriting`
  String get field_username_text {
    return Intl.message(
      'Iltimos, foydalanuvchi nomingizni kiriting',
      name: 'field_username_text',
      desc: '',
      args: [],
    );
  }

  /// `To'liq ism`
  String get full_name {
    return Intl.message('To\'liq ism', name: 'full_name', desc: '', args: []);
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

  /// `Ko'rildi`
  String get history_info {
    return Intl.message('Ko\'rildi', name: 'history_info', desc: '', args: []);
  }

  /// `rasm`
  String get image {
    return Intl.message('rasm', name: 'image', desc: '', args: []);
  }

  /// `uz`
  String get language {
    return Intl.message('uz', name: 'language', desc: '', args: []);
  }

  /// `Hisobdan chiqish`
  String get log_out {
    return Intl.message(
      'Hisobdan chiqish',
      name: 'log_out',
      desc: '',
      args: [],
    );
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

  /// `Tomosha tarixi yo'q`
  String get no_history {
    return Intl.message(
      'Tomosha tarixi yo\'q',
      name: 'no_history',
      desc: '',
      args: [],
    );
  }

  /// `Profil`
  String get profile_header {
    return Intl.message('Profil', name: 'profile_header', desc: '', args: []);
  }

  /// `Foydalanuvchi nomi`
  String get profile_username {
    return Intl.message(
      'Foydalanuvchi nomi',
      name: 'profile_username',
      desc: '',
      args: [],
    );
  }

  /// `Hisobingizga kirish uchun quyidagi ma'lumotlarni to'ldiring.`
  String get sign_in_info {
    return Intl.message(
      'Hisobingizga kirish uchun quyidagi ma\'lumotlarni to\'ldiring.',
      name: 'sign_in_info',
      desc: '',
      args: [],
    );
  }

  /// `Bizning o'quv hamjamiyatimizga qo'shiling va o'z potentsialingizni oching!`
  String get sign_up_text {
    return Intl.message(
      'Bizning o\'quv hamjamiyatimizga qo\'shiling va o\'z potentsialingizni oching!',
      name: 'sign_up_text',
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

  /// `Qaytib kelganingizdan xursandmiz`
  String get welcome_back {
    return Intl.message(
      'Qaytib kelganingizdan xursandmiz',
      name: 'welcome_back',
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

  /// `Hisobingizni yarating`
  String get welcome_text_2 {
    return Intl.message(
      'Hisobingizni yarating',
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
