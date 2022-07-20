import 'package:hanouty/blocs/loginbloc/login_bloc.dart';
import 'package:hanouty/settings/themes.dart';
import 'package:hanouty/utils/constents.dart';
import 'package:flutter/material.dart';

import '../components.dart';

final globalFunctionsProvider = Provider<GlobalFunctions>((ref) {
  return GlobalFunctions(ref);
});

class GlobalFunctions {
  GlobalFunctions(this.ref);
  final ProviderRef ref;
  // this is shown in case of success
  static void showSuccessSnackBar(BuildContext context, String message) {
    toast(message);
  }

  /// this is shown in normal case
  static void showSnackBar(BuildContext context, String message) {
    toast(message);
  }

// this is shown in case of error
  static void showErrorSnackBar(BuildContext context, String message) {
    toast(message);
  }

  // /// show ios style dialoge
  // static void showIosStyleDialog(BuildContext context, String message) {
  //   showOverlay((_, t) {
  //     return Theme(
  //       data: Theme.of(context),
  //       child: Opacity(
  //         opacity: t,
  //         child: IosStyleToast(),
  //       ),
  //     );
  //   }, key: ValueKey('hello'));
  // }

  /// loading snackbar
  static void showLoadingSnackBar(BuildContext context, String message) {
    toast(message);
  }

  // build Bottomsheet for edit profile
  static void myBottomSheet(BuildContext context,
      {AnimationController? controller, required Widget child}) {
    showModalBottomSheet(
        transitionAnimationController: controller,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        // backgroundColor: Colors.black,
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        builder: (_) {
          return child;
        });
  }

  /// url launcher for opening the url in browser

  static void launchURL({String url = ''}) async {
    if (!await launchUrl(Uri.parse(url))) throw 'Could not launch $url';
  }

  optionsMenu(
    BuildContext context,
  ) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        switch (value) {
          case 'logout':
            break;
          case 'change_theme':
            break;
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 'info',
          child: Text('Logout'),
        ),
        const PopupMenuItem(
          value: 'logout',
          child: Text('Logout'),
        ),
      ],
    );
  }

  Future<void> buildSignOut(
    BuildContext context,
  ) {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: AppConstants.whiteOpacity,
            title: const Text('Log-out !?').tr(),
            titleTextStyle: Theme.of(context).textTheme.headline6,
            actionsPadding: const EdgeInsets.only(left: 8, right: 8),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 120,
                    child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: MThemeData.raisedButtonStyleCancel,
                        child: Text('Cancel'.tr())),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    width: 120,
                    child: TextButton(
                        onPressed: () {
                          context.read<LoginBloc>().add(LogOutRequestedEvent());
                        },
                        style: MThemeData.raisedButtonStyleSave,
                        child: Text(
                          'Exit'.tr(),
                        )),
                  ),
                ],
              ),
            ],
          );
        });
  }

  /// push the page to the top of the stack
  static void push(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  /// pushNamed the page to the top of the stack
  static void pushNamed(BuildContext context, String page) {
    Navigator.pushNamed(
      context,
      page,
    );
  }
}
