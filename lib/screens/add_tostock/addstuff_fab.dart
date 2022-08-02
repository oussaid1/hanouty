import 'package:flutter/material.dart';
import 'package:hanouty/components.dart';
import '../../blocs/clientsbloc/clients_bloc.dart';
import '../../blocs/rechargebloc/fullrechargesales_bloc.dart';
import '../../database/database_operations.dart';
import '../client/add_client.dart';
import '../debt/add_debt.dart';
import '../debt/add_payment.dart';
import '../expenses/add_expense.dart';
import '../income/add_income.dart';
import '../product/add_product.dart';
import '../recharge/add_recharge.dart';
import '../techservice/add_service.dart';
import '../../../blocs/clientsbloc/clients_bloc.dart';
import '../../../blocs/datefilterbloc/date_filter_bloc.dart';
import '../../../blocs/debtbloc /debt_bloc.dart';
import '../../../blocs/expensesbloc/expenses_bloc.dart';
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

class AddFabWidget extends StatelessWidget {
  const AddFabWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              ProductBloc(databaseOperations: GetIt.I<DatabaseOperations>()),
        ),
        BlocProvider(
          create: (context) => SellActionsBloc(
              databaseOperations: GetIt.I<DatabaseOperations>()),
        ),
        BlocProvider(
          create: (context) =>
              SalesBloc(databaseOperations: GetIt.I<DatabaseOperations>()),
        ),
        // BlocProvider(
        //   create: (context) =>
        //       FullSalesBloc(databaseOperations: GetIt.I<DatabaseOperations>()),
        // ),
        BlocProvider(
          create: (context) =>
              RechargeBloc(databaseOperations: GetIt.I<DatabaseOperations>())
                ..add(GetFullRechargeSalesEvent()),
        ),
        BlocProvider(
          create: (context) =>
              DebtBloc(databaseOperations: GetIt.I<DatabaseOperations>()),
        ),
        BlocProvider(
          create: (context) =>
              ExpensesBloc(databaseOperations: GetIt.I<DatabaseOperations>()),
        ),
        BlocProvider(
          create: (context) =>
              IncomesBloc(databaseOperations: GetIt.I<DatabaseOperations>()),
        ),
        BlocProvider(
          create: (context) =>
              ShopClientBloc(databaseOperations: GetIt.I<DatabaseOperations>()),
        ),
        BlocProvider(
          create: (context) =>
              SuplierBloc(databaseOperations: GetIt.I<DatabaseOperations>()),
        ),
        BlocProvider(
          create: (context) => TechServiceBloc(
              databaseOperations: GetIt.I<DatabaseOperations>()),
        ),
        BlocProvider(
          create: (context) =>
              PaymentsBloc(databaseOperations: GetIt.I<DatabaseOperations>()),
        ),
        BlocProvider(
          create: (context) => DateFilterBloc(),
        ),
        BlocProvider(
            create: (context) => ShopClientBloc(
                databaseOperations: GetIt.I<DatabaseOperations>())),
      ],
      child: const AddStuffWidget(),
    );
  }
}

class AddStuffWidget extends StatelessWidget {
  const AddStuffWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildExpandedFab(context, title: "Client", child: const AddClient()),
        const SizedBox(height: 10),
        buildExpandedFab(context,
            title: "Recharge",
            child: const AddRechargeWidget(
                // recharge: RechargeModel.fakeData[1],
                )),
        const SizedBox(height: 10),

        /// commented this beacasue it's not yet implemented in the app , but it's here for future use
        /// don't forget to uncomment it when it's ready
        // buildExpandedFab(context,title: "Add Supplier",child: const AddSuplier()),
        // const SizedBox(height: 10),
        buildExpandedFab(context,
            title: "Product", child: const AddOrEditProduct()),
        const SizedBox(height: 10),
        buildExpandedFab(context, title: "Service", child: const AddService()),
        const SizedBox(height: 10),
        buildExpandedFab(context, title: "Add Debt", child: const AddDebt()),
        const SizedBox(height: 10),
        buildExpandedFab(context,
            title: "Payment",
            child: const AddPayment(payingStatus: PayingStatus.adding)),
        const SizedBox(height: 10),
        buildExpandedFab(context, title: "Expense", child: const AddExpense()),
        const SizedBox(height: 10),
        buildExpandedFab(context, title: "Income", child: const AddIncome()),
      ],
    );
  }

  FloatingActionButton buildExpandedFab(BuildContext context,
      {String? title, Widget? child}) {
    return FloatingActionButton.extended(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      extendedIconLabelSpacing: 0,
      onPressed: () {
        MDialogs.dialogSimple(
          context,
          title: Text(
            title ?? '',
            style: Theme.of(context).textTheme.headline3!,
          ),
          contentWidget: SizedBox(
            // height: 400,
            width: 410,
            child: child ?? const SizedBox.shrink(),
          ),
        );
      },
      label: SizedBox(
        width: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add, size: 18),
            const SizedBox(width: 5),
            Text(title ?? '', style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
