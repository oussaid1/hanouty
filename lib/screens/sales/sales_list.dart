import 'package:hanouty/blocs/fullsalesbloc/fullsales_bloc.dart';
import 'package:flutter/material.dart';
import '../../blocs/sellactionsbloc/sellactions_bloc.dart';
import '../../components.dart';
import '../../local_components.dart';
import '../../utils/global_functions.dart';
import 'charts/sales_by_date_barchart.dart';
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
        body: MultiBlocListener(
          listeners: [
            BlocListener<SellActionsBloc, SellActionsState>(
              listener: (context, state) {
                if (state.status == SellActionsStatus.sold) {
                  GlobalFunctions.showSuccessSnackBar(
                      context, 'Successfully Sold '.tr());
                }

                if (state.status == SellActionsStatus.error) {
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
                              const SizedBox(
                                width: 420,
                                height: 200,
                                child: SalesOverAllWidget(),
                              ),
                              BluredContainer(
                                width: 420,
                                height: 200,
                                child: SalesByCategoryWidget(
                                    taggedSales: salesData.salesByCategory),
                              ),
                              BluredContainer(
                                width: 420,
                                height: 200,
                                child: BySuplierBarChart(
                                    title: 'Sales by Supplier',
                                    data: salesData.salesBySupplier),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          const Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(20.0),
                              child: SalesDataTable(),
                            ),
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
