import 'package:hanouty/local_components.dart';
import 'package:hanouty/components.dart';
import 'package:shared_preferences/shared_preferences.dart';

// // login variables
// final passwordObscurekProvider = StateProvider<bool>((ref) {
//   return true;
// });
// final regPasswordObscureProvider = StateProvider<bool>((ref) {
//   return true;
// });

// final regConfirmPassObscureProvider = StateProvider<bool>((ref) {
//   return true;
// });
// // side menu variables
// final itemMenuSelectedProvider = StateProvider<List<bool>>((ref) {
//   //List<bool> list = ;
//   // for (int i = 0; i < 8; i++) {
//   //   if (i != index) {
//   //     list[i] = false;
//   //   } else {
//   //     list[i] = true;
//   //   }
//   // }
//   return [true, false, false, false, false, false, false, false];
// });
// // search sell variables
// final searkchProductCategoryListProvider = StateProvider<List<String>>((ref) {
//   return [
//     'Barcode',
//     'Name',
//     'Category',
//     'date',
//     'Quantity',
//   ];
// });
// final searchServiCategoryListProvider = StateProvider<List<String>>((ref) {
//   return [
//     'Barcode',
//     'Name',
//     'Category',
//     'date',
//   ];
// // });
// final selectedSearchProvider = StateProvider<String?>((ref) {
//   return 'Barcode';
// // });
// //incrementable number variables
// final incrementedNumber = StateProvider<int>((ref) {
//   return 0;
// });
//number of scares products variables
final scareceValueProvider = StateProvider<int>((ref) {
  return 4;
});
// select or add product variables
final selectedSelectOrAddCat = StateProvider<String?>((ref) {
  return null;
});
final expenseCategoryListProvder = Provider<List<String>>((ref) {
  return ExpenseCategory.values.map((e) => e.value).toList();
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

// dateTime pickers variables
final pickedDateTime = StateProvider<DateTime>((ref) {
  return DateTime.now();
});
final pickedDueDateTime = StateProvider<DateTime>((ref) {
  return DateTime.now();
});
final incrementableDate = StateProvider<DateTime>((ref) {
  return DateTime.now();
});

// final pickerDateRangeProvider = StateProvider<PickerDateRange>((ref) {
//   return PickerDateRange(
//     DateTime.now(),
//     DateTime.now().add(const Duration(days: 30)),
//   );
// });
// error variables

// sell action  variables
final priceSoldForProvider = StateProvider<double>((ref) {
  return 1.0;
});

// class SellCounter extends StateNotifier<int> {
//   SellCounter(int state) : super(state);

//   //set the state to a value
//   void setState(int value) {
//     state = value;
//   }

// // increment as long as less than value
//   void increment(int value) {
//     if (state < value) {
//       state++;
//     }
//   }

// // check if is greater than zero the decrement by one
//   void decrement() {
//     if (state > 1) {
//       state--;
//     }
//   }
// }

// currency provider to all app like dollar sign dh, euro sign eu, etc
final currencyProvider = StateProvider<String>((ref) {
  const String defaultValue = 'DH';
  // const String rial = 'RL';
  // const String dollar = '\$';

  return defaultValue;
});

class CurrencyStringProvider extends StateNotifier<String> {
  CurrencyStringProvider(
    String state,
  ) : super(state) {
    _currency = dollar;
    _loadFromPreferences();
  }
  final String key = "currency";
  SharedPreferences? _preferences;
  //set the state to a value
  void setState(String value) {
    state = value;
  }

  late String _currency;
  final String defaultValue = 'DH';
  final String rial = 'RL';
  final String dollar = '\$';

  _initialPreferences() async {
    _preferences = await SharedPreferences.getInstance();
  }

  _savePreferences() async {
    await _initialPreferences();
    _preferences!.setString(key, _currency);
  }

  _loadFromPreferences() async {
    await _initialPreferences();
    _currency = _preferences!.getString(key) ?? defaultValue;
    // notifyListeners();
  }

  toggleChangeTheme() {
    _savePreferences();
  }
}
