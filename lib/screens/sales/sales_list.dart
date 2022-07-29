import 'dart:developer';

import 'package:hanouty/blocs/fullsalesbloc/fullsales_bloc.dart';
import 'package:hanouty/widgets/price_number_zone.dart';
import 'package:flutter/material.dart';
import '../../blocs/salesbloc/sales_bloc.dart';
import '../../blocs/sellactionsbloc/sellactions_bloc.dart';
import '../../components.dart';
import '../../local_components.dart';
import '../../utils/global_functions.dart';
import 'sales_by_category_widget.dart';
import 'sales_dt_tbl.dart';
import 'sales_iventory_widget.dart';

class SalesList extends StatelessWidget {
  const SalesList({
    Key? key,
    this.sale,
  }) : super(key: key);
  final List<SaleModel>? sale;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // floatingActionButton: Padding(
        //   padding: const EdgeInsets.only(bottom: 80.0),
        //   child: FloatingActionButton.extended(
        //     icon: const Icon(Icons.add),
        //     onPressed: () {
        //       MDialogs.dialogSimple(
        //         context,
        //         title: Text(
        //           "Add Sale",
        //           style: Theme.of(context).textTheme.headline3!,
        //         ),
        //         contentWidget: Container(
        //           decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(6),
        //           ),
        //           height: 500,
        //           width: 420,
        //           child: const AddOrEditSaleWidget(
        //               // sale: null,
        //               // product: null,
        //               // initialDate: null,
        //               // initialQuantity: null,
        //               ),
        //         ),
        //       );
        //     },
        //     label: const Text("Add Sale").tr(),
        //   ),
        // ),
        body: MultiBlocListener(
          listeners: [
            BlocListener<SellActionsBloc, SellActionsState>(
              listener: (context, state) {
                if (state is SellingSuccessfulState) {
                  GlobalFunctions.showSuccessSnackBar(
                      context, 'Successfully Sold '.tr());
                }

                if (state is SellingFailedState) {
                  GlobalFunctions.showErrorSnackBar(
                      context, 'Error selling Sale'.tr());
                }
              },
            ),
          ],
          child: BlocBuilder<FullSalesBloc, FullSalesState>(
            builder: (context, fullSalesState) {
              if (fullSalesState.status == FullSalesStatus.loaded) {
                //  var productList = fullSalesState.products;
                //var dbSalesList = fullSalesState.dbSales;
                var fullSales = fullSalesState.fullSales;
                // FilteredSales filteredSales = FilteredSales(
                //   sales: fullSales,
                // );
                SalesData salesData = SalesData(sales: fullSales);

                return Builder(builder: (context) {
                  return SingleChildScrollView(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        children: [
                          Wrap(
                            direction: Axis.horizontal,
                            spacing: 20,
                            runSpacing: 20,
                            alignment: WrapAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 8.0),
                                child: SalesOverAllWidget(),
                              ),
                              SizedBox(
                                width: 420,
                                height: 200,
                                child: SalesByCategoryWidget(
                                    taggedSales: salesData.salesByCategory),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          const Expanded(
                            child: SalesDataTable(),
                          ),
                        ],
                      ),
                    ),
                  );
                });
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Loading Products ${fullSalesState.status}'.tr(),
                          style: Theme.of(context).textTheme.headline3!),
                      const CircularProgressIndicator(),
                    ],
                  ),
                );
              }
            },
          ),
        ));
  }
}
