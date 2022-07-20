class Language {
  final int id;
  final String flag;
  final String name;
  final String languageCode;
  String get nameFlag => "$name   $flag";
  Language(this.id, this.flag, this.name, this.languageCode);

  static List<Language> languageList() {
    return <Language>[
      Language(1, "🇫🇷", "francais", "fr"),
      Language(2, "🇺🇸", "English", "en"),
      Language(3, "🇸🇦", "العربية", "ar"),
    ];
  }
}
