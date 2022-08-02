import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:hanouty/screens/recharge/reachrge_tab.dart';

import '../screens/add_tostock/stock_screen_tab.dart';
import '../screens/client/people_tab.dart';
import '../screens/dashboard/dashboard.dart';
import '../screens/debt/deb_list.dart';
import '../screens/device_specific/homeforweb/home_for_web.dart';
import '../screens/expenses/expenses_tab.dart';
import '../screens/income/income_tab.dart';
import '../screens/sales/sales_tab.dart';
import '../screens/splash/splash_login_signup.dart';
import '../settings/settings.dart';

class RouteGenerator {
  static const String root = "/";
  static const String splash = "/splash";
  static const String dashboard = "/dashboard";
  static const String stock = "/stock";
  static const String sales = "/sales";
  static const String debts = "/debts";
  static const String recharges = "/recharges";
  static const String income = "/income";
  static const String expenses = "/expenses";
  static const String people = "/people";
  static const String settingsPage = "/settings";

  static Route<T> fadeThrough<T>(RouteSettings settings, WidgetBuilder page,
      {int duration = 300}) {
    return PageRouteBuilder<T>(
      settings: settings,
      transitionDuration: Duration(milliseconds: duration),
      pageBuilder: (context, animation, secondaryAnimation) => page(context),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeScaleTransition(animation: animation, child: child);
      },
    );
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    // final args = settings.arguments;
    return fadeThrough(settings, (context) {
      switch (settings.name) {
        case root:
          //menuIndexProvider;
          return const SplashPage();

        case dashboard:
          return const HomeForAll(
            title: 'dashboard',
            centreWidget: DashBoardPage(),
          );
        case stock:
          return const HomeForAll(
            title: 'stock',
            centreWidget: StockTab(),
          );
        case sales:
          return const HomeForAll(
            title: 'sales',
            centreWidget: SalesTab(),
          );
        case recharges:
          return const HomeForAll(
            title: 'recharges',
            centreWidget: RechargeTab(),
          );
        case debts:
          return const HomeForAll(
            title: 'debts',
            centreWidget: DebtsView(),
          );
        case income:
          return const HomeForAll(
            title: 'income',
            centreWidget: IncomeTab(),
          );
        case expenses:
          return const HomeForAll(
            title: 'expenses',
            centreWidget: ExpensesTab(),
          );
        case people:
          return const HomeForAll(
            title: 'people',
            centreWidget: PeopleTab(),
          );
        case settingsPage:
          return const HomeForAll(
            title: 'settings',
            centreWidget: SettingsPage(),
          );
        default:
          return const HomeForAll(
            title: 'dashboard',
            centreWidget: DashBoardPage(),
          );
        //return _errorRoute();
      }
    });
  }

  static errorRoute() {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: const Center(
        child: Text('ERROR'),
      ),
    );
  }
}
