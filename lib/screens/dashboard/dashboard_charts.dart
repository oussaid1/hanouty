import 'package:flutter/material.dart';

import '../../blocs/datefilterbloc/date_filter_bloc.dart';
import '../../blocs/fullsalesbloc/fullsales_bloc.dart';
import '../../components.dart';
import '../../local_components.dart';
import '../sales/sales_line_chart.dart';
import '../sales/sales_barchart.dart';

class DashboardCharts extends StatelessWidget {
  const DashboardCharts({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DateFilterBloc, DateFilterState>(
      builder: (context, filterState) {
        return BlocBuilder<FullSalesBloc, FullSalesState>(
          builder: (context, state) {
            FilteredSales fltrdSlz = FilteredSales(
                sales: state.fullSales,
                filterType: filterState.filterType,
                selectedDateRange: filterState.dateRange);
            SalesData pSlzDta =
                SalesData(sales: fltrdSlz.slzByFltrTp(fltrdSlz.productSales));
            SalesData sSlzDta = SalesData(
                sales: fltrdSlz.slzByFltrTp(fltrdSlz.techServiceSales));
            SalesData allslzDta =
                SalesData(sales: fltrdSlz.slzByFltrTp(state.fullSales));
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
                        dta: allslzDta.chartDataDDMMYY,
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
                      dta: allslzDta.chartDataDDMMYY,
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
