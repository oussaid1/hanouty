import 'package:hanouty/models/daterange.dart';
import 'package:flutter/material.dart';
import 'package:hanouty/components.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Theme
final selectedDateRangeStateNotifier =
    ChangeNotifierProvider((ref) => DateRangeState());

class DateRangeState extends ChangeNotifier {
  final String mstart = "start";
  final String mend = "end";
  final String misActive = "rangeActive";
  SharedPreferences? mpreferences;
  late bool rangeActive = false;
  late MDateRange range;
  bool get rangeStatus => rangeActive;
  // set range({required DateTime start,required DateTime end})=> range = DateRange(start:start,end:end);
  DateRangeState() {
    range = MDateRange(
        start: DateTime.now().subtract(const Duration(days: 365)),
        end: DateTime.now());
    rangeActive = false;
    mloadFromPreferences();
  }

  minitialPreferences() async {
    mpreferences = await SharedPreferences.getInstance();
  }

  msavePreferences(MDateRange mdateRange) async {
    await minitialPreferences();
    mpreferences!.setBool(misActive, rangeActive);
    mpreferences!.setString(mstart, mdateRange.start.toString());
    mpreferences!.setString(mend, mdateRange.end.toString());
  }

  mloadFromPreferences() async {
    await minitialPreferences();
    rangeActive = mpreferences!.getBool(misActive) ?? false;
    DateTime? start = DateTime.tryParse(mpreferences!.getString(mstart)!);
    DateTime? end = DateTime.tryParse(mpreferences!.getString(mend)!);
    range = MDateRange(start: start!, end: end!);
    notifyListeners();
  }

  setRangeActive(bool mactive) async {
    rangeActive = mactive;
    notifyListeners();
  }

  saveRange(MDateRange mdateRange) {
    range = mdateRange;
    msavePreferences(mdateRange);
    notifyListeners();
  }
}
