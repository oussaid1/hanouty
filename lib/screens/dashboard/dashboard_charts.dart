import 'package:flutter/material.dart';

import '../../blocs/datefilterbloc/date_filter_bloc.dart';
import '../../blocs/fullsalesbloc/fullsales_bloc.dart';
import '../../components.dart';
import '../../local_components.dart';
import '../sales/charts/sales_by_date_line_chart.dart';
import '../sales/charts/sales_by_date_barchart.dart';

class DashboardCharts extends StatelessWidget {
  const DashboardCharts({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DateFilterBloc, DateFilterState>(
      builder: (context, filterState) {
        return BlocBuilder<FullSalesBloc, FullSalesState>(
          builder: (context, state) {
            ///////////////////////////////////////////
            /// all sales /////////////
            FilteredSales allSalesFiltered = FilteredSales(
                sales: state.fullSales,
                filterType: filterState.filterType,
                selectedDateRange: filterState.dateRange);
            SalesData allSalesData =
                SalesData(sales: allSalesFiltered.slzByFltrTp);

            ////////////////////////////////////
            /// filtered product sales ///////////////
            List<SaleModel> productSales = allSalesFiltered.productSales;
            SalesData pSlzDta = SalesData(sales: productSales);

            /////////////////////////////////////////////
            /// filtered service sales ///////////////
            List<SaleModel> serviceSales = allSalesFiltered.techServiceSales;
            SalesData sSlzDta = SalesData(sales: serviceSales);
            return Wrap(
              spacing: 20,
              direction: Axis.horizontal,
              alignment: WrapAlignment.spaceBetween,
              runSpacing: 20,
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    minWidth: 600,
                    minHeight: 400,
                  ),
                  child: BluredContainer(
                      width: 600,
                      height: 400,
                      child: DashboardLineChart(
                        dta: allSalesData.chartDataDDMMYY,
                        sdta: sSlzDta.chartDataDDMMYY,
                        pdta: pSlzDta.chartDataDDMMYY,
                        title: 'Inventory',
                      )),
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    minWidth: 600,
                    minHeight: 400,
                  ),
                  child: BluredContainer(
                    width: 600,
                    height: 400,
                    child: DashboardBarChart(
                      dta: allSalesData.chartDataDDMMYY,
                      sdta: sSlzDta.chartDataDDMMYY,
                      pdta: pSlzDta.chartDataDDMMYY,
                      title: 'Sales',
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
