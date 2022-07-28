import 'package:flutter/material.dart';
import 'package:hanouty/extensions/extensions.dart';

import 'package:hanouty/models/models.dart';

import '../../blocs/datefilterbloc/date_filter_bloc.dart';
import '../../blocs/fullsalesbloc/fullsales_bloc.dart';
import '../../components.dart';
import '../../utils/constents.dart';
import '../../utils/glasswidgets.dart';
import '../../widgets/price_number_zone.dart';

class SalesOverAllWidget extends StatelessWidget {
  const SalesOverAllWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    buildDataRow(BuildContext context, Color rowColor,
        {required String cellTitle,
        required double value1,
        required double value2,
        TextStyle? cellStyle,
        bool withDollarSign = false}) {
      return DataRow(
        // color: MaterialStateProperty.all(rowColor),
        cells: [
          DataCell(
            Text(cellTitle, style: Theme.of(context).textTheme.subtitle1),
          ),
          DataCell(
            PriceNumberZone(
              withDollarSign: true,
              right: const SizedBox.shrink(),
              price: value1.toPrecision(2),
              priceStyle: cellStyle ?? Theme.of(context).textTheme.caption!,
              // style: Theme.of(context)
              //     .textTheme
              //     .headline5!
              //     .copyWith(color: context.theme.onPrimary),
            ),
          ),
          DataCell(
            PriceNumberZone(
              withDollarSign: withDollarSign,
              right: const SizedBox.shrink(),
              price: value2.toPrecision(2),
              priceStyle: cellStyle ?? Theme.of(context).textTheme.caption,
              // style: Theme.of(context)
              //     .textTheme
              //     .headline5!
              //     .copyWith(color: context.theme.onPrimary),
            ),
          ),
        ],
      );
    }

    return BlocBuilder<FullSalesBloc, FullSalesState>(
      builder: (context, state) {
        return BlocBuilder<DateFilterBloc, DateFilterState>(
          builder: (context, filterState) {
            FilteredSales filteredSales = FilteredSales(
                sales: state.fullSales,
                selectedDateRange: filterState.dateRange,
                filterType: filterState.filterType);
            SalesData salesData =
                SalesData(sales: filteredSales.slzByFltrTp(state.fullSales));
            SalesData productSalesData = SalesData(
                sales: filteredSales.slzByFltrTp(filteredSales.productSales));
            SalesData serviceSalesData = SalesData(
                sales:
                    filteredSales.slzByFltrTp(filteredSales.techServiceSales));

            return BluredContainer(
              width: 420,
              height: 200,
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15.0, bottom: 5, top: 15),
                    child: Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.coins,
                          color: context.theme.primaryContainer,
                        ),
                        const SizedBox(width: 15),
                        Text('Sales',
                            style: Theme.of(context).textTheme.bodyMedium!),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      DataTable(
                        columnSpacing: 30,
                        dataRowHeight: 30,
                        showBottomBorder: false,
                        dividerThickness: 0.01,
                        headingRowHeight: 38,
                        columns: [
                          const DataColumn(
                            label: Text(
                              '',
                            ),
                          ),
                          DataColumn(
                            label: Text("Amount",
                                style: Theme.of(context).textTheme.subtitle2),
                          ),
                          DataColumn(
                            label: Text('Quantity',
                                style: Theme.of(context).textTheme.subtitle2),
                          ),
                        ],
                        rows: [
                          buildDataRow(
                            context,
                            AppConstants.whiteOpacity,
                            cellTitle: 'Products',
                            value1: productSalesData.totalSoldAmount,
                            value2:
                                productSalesData.totalQuantitySold as double,
                          ),
                          buildDataRow(
                            context,
                            AppConstants.whiteOpacity,
                            cellTitle: 'Services',
                            value1: serviceSalesData.totalSoldAmount,
                            value2:
                                serviceSalesData.totalQuantitySold as double,
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Divider(
                        height: 0.5,
                        thickness: 0.5,
                        color: context.theme.onPrimary,
                        endIndent: 8,
                        indent: 8,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 8.0, top: 8, right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Net Sales',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color:
                                          context.theme.onSecondaryContainer),
                            ),
                            PriceNumberZone(
                              right: const SizedBox.shrink(),
                              withDollarSign: true,
                              price: salesData.totalNetProfit,
                              priceStyle: context.textTheme.bodyLarge,
                              // style: Theme.of(context)
                              //     .textTheme
                              //     .headline2!
                              //     .copyWith(color: context.theme.primary),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
