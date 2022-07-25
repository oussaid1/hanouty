import 'package:hanouty/components.dart';
import 'package:flutter/material.dart';
import 'package:hanouty/utils/constents.dart';

import '../local_components.dart';
import 'price_number_zone.dart';

class MyInventoryTable extends StatelessWidget {
  /// feilds required for this widget
  ///  [IconData iconData],String wedgetTitle,String bottomText,double bottomValue,
  ///  column1, column2,
  /// String row1Title,double row1Value1,double row1Value2,
  /// String row2Title,double row2Value1,double row2Value2,
  /// String row3Title,double row3Value1,double row3Value2]
  final Map<String, dynamic> data;

  final Widget? endWidget;

  const MyInventoryTable({
    Key? key,
    required this.data,
    this.endWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(
                      data['iconData'] ?? FontAwesomeIcons.circleDot,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      data['wedgetTitle'] ?? '',
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ],
                ),
              ),
              endWidget ?? Container(),
            ],
          ),
        ),
        Column(
          children: [
            buildTable(
              context,
              rows: [
                buildDataRow(
                  context,
                  AppConstants.whiteOpacity,
                  cellTitle: data['row1Title'] ?? '',
                  value1: data['row1Value1'] ?? 0,
                  value2: data['row1Value2'] ?? 0,
                ),
                buildDataRow(
                  context,
                  AppConstants.whiteOpacity,
                  cellTitle: data['row2Title'] ?? '',
                  value1: data['row2Value1'] ?? 0,
                  value2: data['row2Value2'] ?? 0,
                ),
                buildDataRow(
                  context,
                  AppConstants.whiteOpacity,
                  cellTitle: data['row3Title'] ?? '',
                  value1: data['row3Value1'] ?? 0,
                  value2: data['row3Value2'] ?? 0,
                )
              ],
              label1: data['column1'] ?? '',
              label2: data['column2'] ?? '',
            ),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(height: 15),
            Divider(
              height: 0.5,
              thickness: 0.5,
              color: Theme.of(context).colorScheme.onPrimary,
              endIndent: 8,
              indent: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    data['bottomText'] ?? '',
                    style: Theme.of(context).textTheme.caption!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                  PriceNumberZone(
                    right: const SizedBox.shrink(),
                    withDollarSign: false,
                    price: data['bottomValue'] ?? 0,
                    // style: Theme.of(context)
                    //     .textTheme
                    //     .headline2!
                    //     .copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

buildDataRow(BuildContext context, Color rowColor,
    {required String cellTitle,
    required double value1,
    required double value2,
    bool withDollarSign = false}) {
  return DataRow(
    color: MaterialStateProperty.all(rowColor),
    cells: [
      DataCell(
        Text(
          cellTitle,
          style: Theme.of(context).textTheme.caption!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
        ),
      ),
      DataCell(
        PriceNumberZone(
          withDollarSign: withDollarSign,
          right: const SizedBox.shrink(),
          price: value1.toPrecision(2),
          // style: Theme.of(context)
          //     .textTheme
          //     .headline5!
          //     .copyWith(color: Theme.of(context).colorScheme.onPrimary),
        ),
      ),
      DataCell(
        PriceNumberZone(
          withDollarSign: withDollarSign,
          right: const SizedBox.shrink(),
          price: value2.toPrecision(2),
          // style: Theme.of(context)
          //     .textTheme
          //     .headline5!
          //     .copyWith(color: Theme.of(context).colorScheme.onPrimary),
        ),
      ),
    ],
  );
}

buildTable(BuildContext context,
    {required List<DataRow> rows,
    required String label1,
    required String label2}) {
  return DataTable(
    columnSpacing: 30,
    dataRowHeight: 30,
    showBottomBorder: true,
    headingRowHeight: 38,
    columns: [
      DataColumn(
        label: Text(
          '',
          style: Theme.of(context).textTheme.caption!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
        ),
      ),
      DataColumn(
        label: Text(
          label1,
          style: Theme.of(context).textTheme.caption!.copyWith(
                color: MThemeData.productColor,
              ),
        ),
      ),
      DataColumn(
        label: Text(
          label2,
          style: Theme.of(context).textTheme.caption!.copyWith(
                color: MThemeData.serviceColor,
              ),
        ),
      ),
    ],
    rows: rows,
  );
}
