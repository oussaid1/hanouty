import 'package:flutter/material.dart';
import 'package:hanouty/blocs/filteredsalesbloc/filteredsales_bloc.dart';
import 'package:hanouty/components.dart';
import '../../local_components.dart';
import '../../localization/language.dart';
import '../../providers/localization_provider.dart';
import '../../providers/theme_provider.dart';
import '../date_pickers.dart/date_rage_picker.dart';
import '../spinners/range_filter_spinner.dart';

final selectedLang = StateProvider<String>((ref) {
  return "en";
});

class TopBarWidget extends ConsumerWidget {
  const TopBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const DateRangePicker(), const RangeFilterSpinner(),

        buildLocalSwitch(context, ref),
        myAppBarIcon(context, ref),
        // buildThemeSwitch(context, appThemeState),
        if (Responsive.isDesktop(context)) const SizedBox(width: 10),
      ],
    );
  }

  /// build notification badge
  Widget myAppBarIcon(BuildContext context, WidgetRef ref) {
    return Badge(
      alignment: Alignment.centerRight,
      animationType: BadgeAnimationType.scale,
      badgeContent: Text(
        "3",
        style: Theme.of(context).textTheme.subtitle1!.copyWith(
              color: MThemeData.white,
            ),
      ),
      position: BadgePosition.topEnd(),
      toAnimate: true,
      child: const Icon(
        Icons.notifications_none,
        size: 30,
      ),
    );
  }

  Row buildThemeSwitch(BuildContext context, AppThemeState appThemeState) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: IconButton(
            icon: Icon(
              Icons.dark_mode,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            onPressed: () {
              if (appThemeState.darkMode) {
                appThemeState.toggleChangeTheme();
              } else {
                appThemeState.toggleChangeTheme();
              }
            },
          ),
        ),
        // Text('tittle').tr(),
      ],
    );
  }
}

Widget buildLocalSwitch(BuildContext context, WidgetRef ref) {
  var appLocalState = ref.watch(appLocalStateNotifier);
  //var appLocalSwitchState = ref.watch(localSwithcProvider.state).state;
  const enLocal = Locale('en', '');
  const arLocal = Locale('ar', '');
  // const frLocal = Locale('fr', 'fr');
  // const lagCodes=['ar','en'];
  String selectedItem = ref.watch(selectedLang.state).state;
  return PopupMenuButton<String>(
    itemBuilder: (context) {
      return Language.languageList().map((str) {
        return PopupMenuItem(
          value: str.languageCode,
          child: Text(
            str.languageCode,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
        );
      }).toList();
    },
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          selectedItem,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        const Icon(Icons.arrow_drop_down),
      ],
    ),
    onSelected: (val) {
      ref.read(selectedLang.state).state = val.toString();
      switch (val) {
        case "ar":
          appLocalState.setLocale(arLocal, context);
          break;
        case "en":
          appLocalState.setLocale(enLocal, context);
          break;
        case "fr":
          appLocalState.setLocale(enLocal, context);
          break;
        default:
      }
    },
  );
}

final notificationsIconNumberProvider = StateProvider<int>((ref) {
  return 0;
});
