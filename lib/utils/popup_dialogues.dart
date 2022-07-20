import 'package:hanouty/settings/themes.dart';
import 'package:flutter/material.dart';

class MDialogs {
  static Future<void> dialogSimple(
    BuildContext context, {
    List<Widget>? widgets,
    Widget? title,
    Widget? contentWidget,
  }) {
    return showDialog<void>(
        context: context,
        useSafeArea: true,
        barrierDismissible: true,
        useRootNavigator: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: title,
            actionsPadding: const EdgeInsets.only(left: 8, right: 8),
            actions: widgets,
            content: contentWidget,
          );
        });
  }

  static Future<void> botomPopUpDialog(
      BuildContext context, Widget widget) async {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 700),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 500,
            margin: const EdgeInsets.only(bottom: 50, left: 12, right: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
            ),
            child: SizedBox.expand(child: widget),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
              .animate(anim),
          child: child,
        );
      },
    );
  }

  static snackBar(String text) => SnackBar(
        content: Text(text),
        backgroundColor: MThemeData.serviceColor,
      );
  static errorSnackBar(String text) => SnackBar(
        content: Text(text),
        backgroundColor: MThemeData.errorColor,
      );
}
