import 'package:flutter/material.dart';
import 'package:hanouty/extensions/extensions.dart';

import 'package:hanouty/models/models.dart';

import '../../blocs/datefilterbloc/date_filter_bloc.dart';
import '../../blocs/fullsalesbloc/fullsales_bloc.dart';
import '../../blocs/productbloc/product_bloc.dart';
import '../../components.dart';
import '../../utils/constents.dart';
import '../../utils/glasswidgets.dart';
import '../price_number_zone.dart';

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
            SalesData salesData = SalesData(
                sales:
                    filteredSales.filteredSalesByFilterType(state.fullSales));
            SalesData productSalesData = SalesData(
                sales: filteredSales
                    .filteredSalesByFilterType(filteredSales.productSales));
            SalesData serviceSalesData = SalesData(
                sales: filteredSales
                    .filteredSalesByFilterType(filteredSales.techServiceSales));

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

class StockInventory extends StatelessWidget {
  const StockInventory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    buildOneItem(
            {required String label,
            required num value,
            bool withDollarsign = false}) =>
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Text(label, style: Theme.of(context).textTheme.bodySmall),
            ),
            PriceNumberZone(
              withDollarSign: withDollarsign,
              right: const SizedBox.shrink(),
              price: value,
              priceStyle: Theme.of(context).textTheme.caption,
              // style: Theme.of(context)
              //     .textTheme
              //     .headline5!
              //     .copyWith(color: context.theme.onPrimary),
            ),
          ],
        );
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        ProductStockData productStockData = ProductStockData(
          products: state.products,
        );
        return BluredContainer(
          width: 420,
          height: 200,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0, bottom: 5, top: 15),
                child: Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.solidPenToSquare,
                      color: context.theme.primaryContainer,
                    ),
                    const SizedBox(width: 15),
                    Text('Stock',
                        style: Theme.of(context).textTheme.bodyMedium!),
                  ],
                ),
              ),
              Column(
                children: [
                  const SizedBox(height: 21),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      buildOneItem(
                        label: 'Price In',
                        value: productStockData.totalPriceInInStock,
                        withDollarsign: true,
                      ),
                      const SizedBox(width: 21),
                      buildOneItem(
                        label: 'Price Out',
                        value: productStockData.totalPriceOutInStock,
                        withDollarsign: true,
                      ),
                      const SizedBox(width: 21),
                      buildOneItem(
                        label: 'Items',
                        value: productStockData.productCountInStock,
                        withDollarsign: false,
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Total Product Quantity".tr(),
                                style: Theme.of(context).textTheme.bodySmall),
                            Text("you have Products with zero quantity".tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(
                                        fontSize: 10,
                                        color: Color.fromARGB(
                                            131, 255, 255, 255))),
                          ],
                        ),
                        PriceNumberZone(
                          withDollarSign: false,
                          right: const SizedBox.shrink(),
                          price: productStockData.totalProductQuantityInStock,
                          priceStyle: Theme.of(context).textTheme.caption,

                          // style: Theme.of(context)
                          //     .textTheme
                          //     .headline5!
                          //     .copyWith(color: context.theme.onPrimary),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 0.5,
                    thickness: 0.5,
                    color: context.theme.onPrimary,
                    endIndent: 8,
                    indent: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8, right: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Capital',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: context.theme.onSecondaryContainer),
                        ),
                        PriceNumberZone(
                          right: const SizedBox.shrink(),
                          withDollarSign: true,
                          price: productStockData.totalCapitalInStock,
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
  }
}
