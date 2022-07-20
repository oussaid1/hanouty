import '/../components.dart';
import 'package:flutter/material.dart';

final appLocalStateNotifier = ChangeNotifierProvider((
  ref,
) =>
    LocaleProvider());

class LocaleProvider with ChangeNotifier {
  Locale _locale = const Locale('en', '');
  Locale get locale => _locale;
  bool isArabic = false;

  void setLocale(Locale locale, BuildContext context) {
    _locale = locale;
    locale.languageCode == "ar" ? isArabic = true : isArabic = false;
    EasyLocalization.of(context)!.setLocale(locale);
    //if (!EasyLocalization..contains(locale)) return;

    notifyListeners();
  }
}
