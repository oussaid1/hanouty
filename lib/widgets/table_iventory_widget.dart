import 'package:hanouty/components.dart';
import 'package:flutter/material.dart';

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
                  cellTitle: data['row1Title'] ?? '',
                  value1: data['row1Value1'] ?? 0,
                  value2: data['row1Value2'] ?? 0,
                ),
                buildDataRow(
                  context,
                  cellTitle: data['row2Title'] ?? '',
                  value1: data['row2Value1'] ?? 0,
                  value2: data['row2Value2'] ?? 0,
                ),
                buildDataRow(
                  context,
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
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(color: Theme.of(context).colorScheme.primary),
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

buildDataRow(BuildContext context,
    {required String cellTitle,
    required double value1,
    required double value2,
    bool withDollarSign = false}) {
  return DataRow(
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
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(color: Theme.of(context).colorScheme.onPrimary),
        ),
      ),
      DataCell(
        PriceNumberZone(
          withDollarSign: withDollarSign,
          right: const SizedBox.shrink(),
          price: value2.toPrecision(2),
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(color: Theme.of(context).colorScheme.onPrimary),
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
    dataRowColor: MaterialStateProperty.all(
        const Color.fromARGB(255, 60, 228, 234).withOpacity(0.1)),
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
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: MThemeData.productColor,
              ),
        ),
      ),
      DataColumn(
        label: Text(
          label2,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: MThemeData.serviceColor,
              ),
        ),
      ),
    ],
    rows: rows,
  );
}

// buildTextOnValue(BuildContext context,
//     {required double value, String? text, required bool withDollarSign}) {
//   return SizedBox(
//     //color: Color.fromARGB(34, 255, 255, 255).withOpacity(0.1),
//     child: Padding(
//       padding: const EdgeInsets.only(left: 8.0, top: 8, bottom: 8, right: 8),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Text(
//             '$text',
//             style: Theme.of(context)
//                 .textTheme
//                 .caption!
//                 .copyWith(color: Theme.of(context).colorScheme.onPrimary),
//           ),
//           PriceNumberZone(
//             withDollarSign: withDollarSign,
//             right: const SizedBox.shrink(),
//             price: value,
//             style: Theme.of(context)
//                 .textTheme
//                 .headline6!
//                 .copyWith(color: Theme.of(context).colorScheme.onPrimary),
//           ),
//           PriceNumberZone(
//             withDollarSign: withDollarSign,
//             right: const SizedBox.shrink(),
//             price: value,
//             style: Theme.of(context)
//                 .textTheme
//                 .headline6!
//                 .copyWith(color: Theme.of(context).colorScheme.onPrimary),
//           ),
//         ],
//       ),
//     ),
//   );
// }
