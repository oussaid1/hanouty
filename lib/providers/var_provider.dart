import 'package:flutter/material.dart';
import 'package:hanouty/components.dart';
import 'package:shared_preferences/shared_preferences.dart';

//number of scares products variables
final scareceVaflueProvider = StateProvider<int>((ref) {
  return 4;
});
// select or add product variables
final selectedSelectOrAddCat = StateProvider<String?>((ref) {
  return null;
});
// final isNewSelectOrmkAddCat = StateProvider<bool>((ref) {
//   return false;
// });
// final isNewSelekctOrAmddClient = StateProvider<bool>((ref) {
//   return false;
// });
final selectedSelectOrAddSuplier = StateProvider<String?>((ref) {
  return;
});
final isNewSelectOrAddSuplier = StateProvider<bool>((ref) {
  return false;
});
final selectedExpenseCat = StateProvider<String?>((ref) {
  return null;
});
final selectedItemProvider = StateProvider<String?>((ref) {
  return null;
});

final incrementableDate = StateProvider<DateTime>((ref) {
  return DateTime.now();
});

// currency provider to all app like dollar sign dh, euro sign eu, etc
final currencyProvider = Provider<CurrencyStringProvider>((ref) {
  const String defaultValue = 'DH';
  // const String rial = 'RL';
  // const String dollar = '\$';

  return CurrencyStringProvider(defaultValue);
});

class CurrencyStringProvider extends ChangeNotifier {
  CurrencyStringProvider(
    String state,
  ) {
    _currency = dollar;
    _loadFromPreferences();
  }
  final String key = "currency";
  SharedPreferences? _preferences;
  //set the state to a value
  void setState(String value) {
    _currency = value;
    _saveToPreferences();
  }

  late String _currency;
  final String defaultValue = 'DH';
  final String rial = 'RL';
  final String dollar = '\$';

  _initialPreferences() async {
    _preferences = await SharedPreferences.getInstance();
  }

  _saveToPreferences() async {
    await _initialPreferences();
    _preferences!.setString(key, _currency);
  }

  _loadFromPreferences() async {
    await _initialPreferences();
    _currency = _preferences!.getString(key) ?? defaultValue;
    // notifyListeners();
  }
}
