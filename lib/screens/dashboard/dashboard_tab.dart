import 'dart:developer';

import 'package:hanouty/blocs/clientsbloc/clients_bloc.dart';
import 'package:hanouty/models/product/product.dart';
import 'package:hanouty/models/revenu/revenu.dart';
import 'package:flutter/material.dart';
import '../../blocs/debtbloc /debt_bloc.dart';
import '../../blocs/filtercubit/filter_cubit.dart';
import '../../blocs/productbloc/product_bloc.dart';
import '../../blocs/salesbloc/sales_bloc.dart';
import '../../components.dart';
import '../../models/models.dart';
import '../../utils/popup_dialogues.dart';
import '../../widgets/cards/latest_trans_list_card.dart';
import '../../widgets/cards/scares_productss_instock.dart';
import '../../widgets/charts/inventory_widget.dart';
import '../../widgets/charts/syncfusion_charts.dart';
import '../product/add_product/add_product.dart';

class DashBoardPage extends StatelessWidget {
  const DashBoardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var filterType = context.watch<FilterCubit>().state.status;
    //  var productBloc = context.watch<ProductBloc>().state;
    var clientsBloc = context.watch<ShopClientBloc>().state;
    log('filterType: $filterType');
    //  log('productBloc: ${productBloc.products.length}');
    log('clientsBloc: ${clientsBloc.clients.length}');
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80.0),
        child: FloatingActionButton.extended(
          icon: const Icon(Icons.add),
          onPressed: () {
            MDialogs.dialogSimple(
              context,
              title: Text(
                "Add Product",
                style: Theme.of(context).textTheme.headline3!,
              ),
              contentWidget: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                ),
                //  gradient: MThemeData.gradient2),
                height: 500,
                width: 420,
                child: const AddOrEditProduct(),
              ),
            );
          },
          label: const Text("Add Product").tr(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  // context
                  //     .read<ShopClientBloc>()
                  //     .add(AddShopClientEvent(ShopClientModel.client));
                  context.read<ShopClientBloc>().add(GetShopClientsEvent());
                },
              ),
              // Wrap(
              //   spacing: 20,
              //   direction: Axis.horizontal,
              //   alignment: WrapAlignment.spaceBetween,
              //   runSpacing: 20,
              //   children: const [
              //     MyInventoryWidget(),
              //     MySalesWidgetBlurred(),
              //     SizedBox(height: 20),
              //     // RadialBarCahrtCard(
              //     //   data: Revenu(
              //     //       debtData: ,
              //     //       salesData: ,
              //     //       expensesData: ,
              //     //       incomeData: ,
              //     //   ),
              //     //   title: 'Revenu',
              //     // ),
              //   ],
              // ),
              // const SizedBox(height: 40),
              // Wrap(
              //   spacing: 20,
              //   direction: Axis.horizontal,
              //   alignment: WrapAlignment.spaceBetween,
              //   children: [
              //     const LineChartCard(data: [], title: 'Inventory'),
              //     const BarChartCard(
              //       data: [],
              //       title: 'Sales',
              //     ),
              //     const SizedBox(width: 2),
              //     Wrap(
              //       direction: Axis.vertical,
              //       children: const [
              //         ScaresProductslistCard(),
              //         SizedBox(height: 20),
              //         LatestTransactionsListCard(
              //           salesList: [],
              //         ),
              //       ],
              //     ),
              //   ],
              // ),
              // // Wrap(
              // //   spacing: 20,
              // //   direction: Axis.vertical,
              // //   alignment: WrapAlignment.spaceBetween,
              // //   children: const [
              // //     ScaresProductslistCard(),
              // //     LatestTransactionsListCard(),
              // //   ],
              // // ),
            ],
          ),
        ),
      ),
    );
  }
}
