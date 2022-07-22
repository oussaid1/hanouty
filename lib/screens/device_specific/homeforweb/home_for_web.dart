import 'package:flutter/material.dart';
import 'package:hanouty/blocs/filteredsalesbloc/filteredsales_bloc.dart';

import '../../../blocs/clientsbloc/clients_bloc.dart';
import '../../../blocs/debtbloc /debt_bloc.dart';
import '../../../blocs/expensesbloc/expenses_bloc.dart';
import '../../../blocs/fullsalesbloc/fullsales_bloc.dart';
import '../../../blocs/incomebloc/income_bloc.dart';
import '../../../blocs/paymentsbloc/payments_bloc.dart';
import '../../../blocs/productbloc/product_bloc.dart';
import '../../../blocs/salesbloc/sales_bloc.dart';
import '../../../blocs/sellactionsbloc/sellactions_bloc.dart';
import '../../../blocs/suplierbloc/suplier_bloc.dart';
import '../../../blocs/techservicebloc/techservice_bloc.dart';
import '../../../components.dart';
import '../../../database/database_operations.dart';
import '../../../local_components.dart';
import '../../../widgets/sidemenu/shared_menu_items.dart';
import '../../../widgets/swithces/top_bar_widget.dart';

class HomeForAll extends ConsumerWidget {
  final Widget centreWidget;
  final String title;
  const HomeForAll({
    Key? key,
    required this.title,
    required this.centreWidget,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: const BoxDecoration(gradient: MThemeData.gradient2),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                ProductBloc(databaseOperations: GetIt.I<DatabaseOperations>())
                  ..add(GetProductsEvent()),
          ),
          BlocProvider(
            create: (context) => SellActionsBloc(GetIt.I<DatabaseOperations>()),
          ),
          BlocProvider(
            create: (context) =>
                SalesBloc(databaseOperations: GetIt.I<DatabaseOperations>())
                  ..add(GetSalesEvent()),
          ),
          BlocProvider(
            create: (context) =>
                FullSalesBloc(databaseOperations: GetIt.I<DatabaseOperations>())
                  ..add(GetFullSalesEvent()),
          ),
          BlocProvider(
            create: (context) =>
                DebtBloc(databaseOperations: GetIt.I<DatabaseOperations>())
                  ..add(GetDebtEvent()),
          ),
          BlocProvider(
            create: (context) =>
                ExpenseBloc(databaseOperations: GetIt.I<DatabaseOperations>())
                  ..add(GetExpensesEvent()),
          ),
          BlocProvider(
            create: (context) =>
                IncomeBloc(databaseOperations: GetIt.I<DatabaseOperations>())
                  ..add(GetIncomeEvent()),
          ),
          BlocProvider(
            create: (context) => ShopClientBloc(
                databaseOperations: GetIt.I<DatabaseOperations>())
              ..add(GetShopClientsEvent()),
          ),
          BlocProvider(
            create: (context) =>
                SuplierBloc(databaseOperations: GetIt.I<DatabaseOperations>())
                  ..add(GetSupliersEvent()),
          ),
          BlocProvider(
            create: (context) => TechServiceBloc(
                databaseOperations: GetIt.I<DatabaseOperations>())
              ..add(GetTechServiceEvent()),
          ),
          BlocProvider(
            create: (context) =>
                PaymentsBloc(databaseOperations: GetIt.I<DatabaseOperations>())
                  ..add(GetPaymentsEvent()),
          ),
          BlocProvider(
            create: (context) => FilteredSalesBloc(FullSalesBloc(
                databaseOperations: GetIt.I<DatabaseOperations>()))
              ..add(GetFilteredSaleDataEvent(DateFilter.all)),
          ),
        ],
        child: Scaffold(
          // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          // floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
          // floatingActionButton: FloatingActionButton.extended(
          //   isExtended: true,
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(50),
          //   ),
          //   onPressed: () {},
          //   label: Row(
          //     children: const [
          //       Icon(Icons.sell),
          //       SizedBox(width: 10),
          //       Text('Sell'),
          //     ],
          //   ),
          // ),
          backgroundColor: Colors.transparent,
          drawer: const SizedBox(width: 80, child: Drawer(child: NavMenu())),
          appBar: !Responsive.isDesktop(context)
              ? AppBar(
                  title: Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                  actions: [
                    SizedBox(
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                TopBarWidget(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : null,
          // appBar: AppBar(
          //   leading: Responsive.isDesktop(context) ? Container() : null,
          //   elevation: 0,
          //   actions: [
          //     ref.watch(rangeFilterIsCustomProvider.state).state
          //         ? const DateRangePicker()
          //         : const SizedBox.shrink(),
          //     const RangeFilterSpinner(),
          //     const AppBarContentWidget(),
          //   ],
          // ),
          body: Responsive.isDesktop(context)
              ? Row(
                  children: [
                    const Expanded(
                      flex: 0,
                      child: NavMenu(),
                    ),
                    Expanded(
                      flex: context.width > 1340 ? 10 : 12,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 50,
                              child: BluredContainer(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        title,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary),
                                      ),
                                    ),
                                    Row(
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: const [
                                        TopBarWidget(),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(child: centreWidget),
                        ],
                      ),
                    ),
                  ],
                )
              : centreWidget,
        ),
      ),
    );
  }
}
