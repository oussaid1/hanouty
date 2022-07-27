import 'package:flutter/material.dart';
import 'package:hanouty/components.dart';
import '../../blocs/clientsbloc/clients_bloc.dart';
import '../../database/database_operations.dart';
import '../../utils/popup_dialogues.dart';
import '../client/add_client.dart';
import '../debt/add_debt.dart';
import '../debt/add_payment.dart';
import '../expenses/add_expense.dart';
import '../income/add_income.dart';
import '../product/add_product.dart';
import '../techservice/add_service.dart';
import '../sales/edit_sale.dart';

class AddStuffWidget extends StatelessWidget {
  const AddStuffWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ShopClientBloc(databaseOperations: GetIt.I<DatabaseOperations>()),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildExpandedFab(context, title: "Client", child: AddClient()),
          const SizedBox(height: 10),

          /// commented this beacasue it's not yet implemented in the app , but it's here for future use
          /// don't forget to uncomment it when it's ready
          // buildExpandedFab(context,title: "Add Supplier",child: const AddSuplier()),
          // const SizedBox(height: 10),
          buildExpandedFab(context,
              title: "Product", child: const AddOrEditProduct()),
          const SizedBox(height: 10),
          buildExpandedFab(context,
              title: "Service", child: const AddService()),
          const SizedBox(height: 10),
          buildExpandedFab(context, title: "Add Debt", child: AddDebt()),
          const SizedBox(height: 10),
          buildExpandedFab(context,
              title: "Payment",
              child: const AddPayment(payingStatus: PayingStatus.adding)),
          const SizedBox(height: 10),
          buildExpandedFab(context,
              title: "Expense", child: const AddExpense()),
          const SizedBox(height: 10),
          buildExpandedFab(context, title: "Income", child: const AddIncome()),
        ],
      ),
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
            child: SingleChildScrollView(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                child ?? const SizedBox.shrink(),
              ],
            )),
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
