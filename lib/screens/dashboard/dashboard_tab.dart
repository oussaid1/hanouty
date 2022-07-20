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
import '../../widgets/cards/latest_trans_list_card.dart';
import '../../widgets/cards/scares_productss_instock.dart';
import '../../widgets/charts/inventory_widget.dart';
import '../../widgets/charts/syncfusion_charts.dart';

class DashBoardPage extends StatelessWidget {
  const DashBoardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var filterType = context.watch<FilterCubit>().state.status;
    return Material(
      color: Colors.transparent,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  context.read<ShopClientBloc>().add(AddShopClientEvent(
                        ShopClientModel.client,
                      ));
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
