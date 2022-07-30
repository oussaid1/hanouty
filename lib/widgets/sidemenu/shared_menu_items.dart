import 'package:hanouty/components.dart';
import 'package:hanouty/widgets/appbaruserwidget/appbar_userwidget.dart';
import 'package:flutter/material.dart';

import '../../utils/global_functions.dart';

final menuIndexProvider = StateProvider<int>((ref) {
  return 0;
});

class NavMenu extends ConsumerWidget {
  const NavMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final globalFunction = ref.read(globalFunctionsProvider);
    return LayoutBuilder(builder: (context, constraint) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraint.maxHeight),
          child: IntrinsicHeight(
            child: NavigationRail(
              backgroundColor: Colors.white.withOpacity(0.5),
              extended: false,
              onDestinationSelected: (int index) {
                ref.read(menuIndexProvider.state).state = index;
                _onTap(context, index);
              },
              selectedIndex: ref.watch(menuIndexProvider.state).state,
              elevation: 20,
              leading: const UserAvatarWidget(),
              indicatorColor:
                  Theme.of(context).colorScheme.primary.withOpacity(0.5),
              selectedIconTheme: const IconThemeData(
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              useIndicator: true,
              destinations: const <NavigationRailDestination>[
                NavigationRailDestination(
                  icon: Icon(Icons.dashboard),
                  label: Text('Dashboard'),
                ),
                NavigationRailDestination(
                  icon: Icon(FontAwesomeIcons.store),
                  label: Text('Stock'),
                ),
                NavigationRailDestination(
                  icon: Icon(FontAwesomeIcons.salesforce),
                  label: Text('Sales'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.account_balance_wallet),
                  label: Text('Debt'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.attach_money),
                  label: Text('Income'),
                ),
                NavigationRailDestination(
                  icon: Icon(
                    FontAwesomeIcons.fileInvoiceDollar,
                  ),
                  label: Text('Expenses'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.person),
                  label: Text('People'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.settings),
                  label: Text('Settings'),
                ),
              ],
              trailing: IconButton(
                icon: Icon(
                  Icons.logout,
                  size: 24,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                onPressed: () {
                  globalFunction.buildSignOut(context);
                },
              ),
            ),
          ),
        ),
      );
    });
  }
}

void _onTap(BuildContext context, int index) {
  switch (index) {
    case 0:
      GlobalFunctions.pushNamed(context, '/dashboard');
      break;
    case 1:
      GlobalFunctions.pushNamed(context, '/stock');
      break;
    case 2:
      GlobalFunctions.pushNamed(context, '/sales');
      break;
    case 3:
      GlobalFunctions.pushNamed(context, '/debts');
      break;
    case 4:
      GlobalFunctions.pushNamed(context, '/income');
      break;
    case 5:
      GlobalFunctions.pushNamed(context, '/expenses');
      break;
    case 6:
      GlobalFunctions.pushNamed(context, '/people');
      break;
    case 7:
      GlobalFunctions.pushNamed(context, '/settings');
      break;
    default:
      GlobalFunctions.pushNamed(context, '/dashboard');
  }
}

//           const SizedBox(height: 20),
//           SingleChildScrollView(
//             child: Column(
//               children: [
//                 Tooltip(
//                   message: 'Dashboard',
//                   child: Padding(
//                     padding: const EdgeInsets.only(
//                         left: 0, right: 0, top: 6, bottom: 2),
//                     child: NavBarItem(
//                       icon: Icons.dashboard,
//                       active: selected[0],
//                       text: 'Dashboard'.tr(),
//                       touched: () {
//                         select(0, ref);
//                         Navigator.pushNamed(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const HomeForAll(
//                                     title: 'Dashboard',
//                                     centreWidget: DashBoardPage(),
//                                   )),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//                 Tooltip(
//                   message: 'Sell',
//                   child: Padding(
//                     padding: const EdgeInsets.only(
//                         left: 0, right: 0, top: 0, bottom: 2),
//                     child: NavBarItem(
//                       icon: FontAwesomeIcons.moneyCheck,
//                       iconSize: 20,
//                       text: 'Sell'.tr(),
//                       active: selected[1],
//                       touched: () {
//                         select(1, ref);
//                         Navigator.pushNamed(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const HomeForAll(
//                                     title: 'Sell',
//                                     centreWidget: SellTab(),
//                                   )),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//                 Tooltip(
//                   message: 'Stock',
//                   child: Padding(
//                     padding: const EdgeInsets.only(
//                         left: 0, right: 0, top: 0, bottom: 2),
//                     child: NavBarItem(
//                       icon: Icons.store,
//                       text: 'Stock'.tr(),
//                       active: selected[2],
//                       touched: () {
//                         select(2, ref);

//                         Navigator.pushNamed(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const HomeForAll(
//                                     title: 'Stock',
//                                     centreWidget: AddScreenTab(),
//                                   )),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//                 Tooltip(
//                   message: 'Sales',
//                   child: Padding(
//                     padding: const EdgeInsets.only(
//                         left: 0, right: 0, top: 0, bottom: 2),
//                     child: NavBarItem(
//                       icon: FontAwesomeIcons.coins,
//                       text: 'Sales'.tr(),
//                       active: selected[3],
//                       touched: () {
//                         select(3, ref);
//                         Navigator.pushNamed(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const HomeForAll(
//                                     title: 'Sales',
//                                     centreWidget: ListTab(),
//                                   )),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//                 Tooltip(
//                   message: 'Debt',
//                   child: Padding(
//                     padding: const EdgeInsets.only(
//                         left: 0, right: 0, top: 0, bottom: 2),
//                     child: NavBarItem(
//                       icon: FontAwesomeIcons.moneyCheck,
//                       iconSize: 20,
//                       text: 'Debts'.tr(),
//                       active: selected[4],
//                       touched: () {
//                         select(4, ref);
//                         Navigator.pushNamed(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const HomeForAll(
//                                     title: 'Debts',
//                                     centreWidget: DebtTab(),
//                                   )),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//                 Tooltip(
//                   message: 'Income',
//                   child: Padding(
//                     padding: const EdgeInsets.only(
//                         left: 0, right: 0, top: 0, bottom: 2),
//                     child: NavBarItem(
//                       icon: FontAwesomeIcons.handHoldingDollar,
//                       iconSize: 22,
//                       text: 'Income'.tr(),
//                       active: selected[5],
//                       touched: () {
//                         select(5, ref);
//                         Navigator.pushNamed(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const HomeForAll(
//                                     title: 'Income',
//                                     centreWidget: IncomeTab(),
//                                   )),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//                 Tooltip(
//                   message: 'Expenses',
//                   child: Tooltip(
//                     message: 'Expenses',
//                     child: Padding(
//                       padding: const EdgeInsets.only(
//                           left: 0, right: 0, top: 0, bottom: 2),
//                       child: NavBarItem(
//                         icon: FontAwesomeIcons.fileInvoiceDollar,
//                         iconSize: 22,
//                         text: 'Expenses'.tr(),
//                         active: selected[6],
//                         touched: () {
//                           select(6, ref);
//                           Navigator.pushNamed(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => const HomeForAll(
//                                       title: 'Expenses',
//                                       centreWidget: ExpensesTab(),
//                                     )),
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//                 Tooltip(
//                   message: 'Settings',
//                   child: Padding(
//                     padding: const EdgeInsets.only(
//                         left: 0, right: 0, top: 0, bottom: 2),
//                     child: NavBarItem(
//                       icon: Icons.settings,
//                       text: 'Settings'.tr(),
//                       active: selected[7],
//                       touched: () {
//                         select(7, ref);
//                         Navigator.pushNamed(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const HomeForAll(
//                                   title: 'Settings',
//                                   centreWidget: SettingsPage())),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: Padding(
//               padding:
//                   const EdgeInsets.only(left: 0, right: 0, top: 50, bottom: 2),
//               child: IconButton(
//                 icon: Icon(
//                   Icons.logout,
//                   size: 24,
//                   color: Theme.of(context).colorScheme.onPrimary,
//                 ),
//                 onPressed: () {
//                   globalFunction.buildSignOut(context);
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
