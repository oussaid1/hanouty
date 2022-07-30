import 'package:flutter/material.dart';

import '../../widgets/cards/latest_trans_list_card.dart';
import '../../widgets/cards/scares_products_instock.dart';
import '../../widgets/fabs/expandaible_fab.dart';
import '../add_tostock/addstuff_fab.dart';
import '../product/stock_inventory.dart';
import '../sales/sales_iventory_widget.dart';
import 'dashboard_charts.dart';
import 'revenu_widget.dart';

class DashBoardPage extends StatelessWidget {
  const DashBoardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var clientbloc = context.watch<ShopClientBloc>().state;

    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: const Padding(
        padding: EdgeInsets.only(bottom: 80.0),
        child: ExpandableFab(
          distance: 0,
          children: [
            AddStuffWidget(),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            spacing: 20,
            runSpacing: 20,
            children: [
              Wrap(
                spacing: 20,
                direction: Axis.horizontal,
                alignment: WrapAlignment.spaceBetween,
                runSpacing: 20,
                children: const [
                  SalesOverAllWidget(),
                  StockInventory(),
                  RevenuWidget(),
                  // Text(' ${clientbloc.clients.length}'),
                ],
              ),
              const DashboardCharts(),
              //const SizedBox(height: 40),
              Wrap(
                spacing: 20,
                runSpacing: 20,
                direction: Axis.horizontal,
                alignment: WrapAlignment.spaceBetween,
                children: [
                  Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    direction: Axis.vertical,
                    children: const [
                      ScaresProductslistCard(),
                      LatestTransactionsListCard(),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class AddStuffWidget extends StatelessWidget {
//   const AddStuffWidget({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         buildExpandedFab(context,
//             title: "Client",
//             child: AddClient(
//               pContext: context,
//             )),
//         const SizedBox(height: 10),
//         // buildExpandedFab(context,title: "Add Supplier",child: const AddSuplier()),
//         // const SizedBox(height: 10),
//         buildExpandedFab(context,
//             title: "Product", child: const AddOrEditProduct()),
//         const SizedBox(height: 10),
//         buildExpandedFab(context, title: "Service", child: const AddService()),
//         const SizedBox(height: 10),
//         buildExpandedFab(context, title: "Add Debt", child: const AddDebt()),
//         const SizedBox(height: 10),
//         buildExpandedFab(context, title: "Expense", child: const AddExpense()),
//         const SizedBox(height: 10),
//         buildExpandedFab(context,
//             title: "Sale", child: const AddOrEditSaleWidget()),
//         const SizedBox(height: 10),
//         buildExpandedFab(context, title: "Income", child: const AddIncome()),
//       ],
//     );
//   }

//   FloatingActionButton buildExpandedFab(BuildContext context,
//       {String? title, Widget? child}) {
//     return FloatingActionButton.extended(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(50),
//       ),
//       extendedIconLabelSpacing: 0,
//       onPressed: () {
//         MDialogs.dialogSimple(
//           context,
//           title: Text(
//             title ?? '',
//             style: Theme.of(context).textTheme.headline3!,
//           ),
//           contentWidget: SizedBox(
//             // height: 400,
//             width: 410,
//             child: SingleChildScrollView(
//                 child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 child ?? const SizedBox.shrink(),
//               ],
//             )),
//           ),
//         );
//       },
//       label: SizedBox(
//         width: 100,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Icon(Icons.add, size: 18),
//             const SizedBox(width: 5),
//             Text(title ?? '',
//                 style: Theme.of(context).textTheme.headline3!.copyWith(
//                       fontSize: 12,
//                       fontWeight: FontWeight.bold,
//                     )),
//           ],
//         ),
//       ),
//     );
//   }
// }
