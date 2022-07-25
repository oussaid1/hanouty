import 'package:flutter/material.dart';
import 'package:hanouty/blocs/filteredsalesbloc/filteredsales_bloc.dart';
import '../../blocs/fullsalesbloc/fullsales_bloc.dart';
import '../../blocs/productbloc/product_bloc.dart';
import '../../components.dart';
import '../../local_components.dart';
import '../../models/Sale/product_sales_data.dart';
import '../../models/Sale/service_sales_data.dart';
import '../table_iventory_widget.dart';

class MyInventoryWidget extends StatelessWidget {
  const MyInventoryWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const BluredContainer(height: 320, width: 420, child: MyStock());
  }
}

class MyInventoryWidgetNoBlurr extends StatelessWidget {
  const MyInventoryWidgetNoBlurr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 320, width: 420, child: MyStock());
  }
}

class MyStock extends StatelessWidget {
  const MyStock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final productStock =ref.watch(productsStockDataStateNotifierProvider.state).state;
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state.status == ProductStatus.loaded) {
          var filteredProducts = FilteredProduct(products: state.products);
          var productStock =
              ProductStockData(products: filteredProducts.products);
          return MyInventoryTable(
            data: {
              'iconData': FontAwesomeIcons.store,
              'wedgetTitle': 'Stock'.tr(),
              'bottomText': 'Capital'.tr(),
              'bottomValue': productStock.totalPriceInInStock,
              'column1': 'Products',
              'column2': 'Services',
              'row1Title': 'Amount',
              'row1Value1': productStock.totalPriceInInStock,
              'row1Value2': 0,
              'row2Title': 'Items',
              'row2Value1': productStock.productCountInStock,
              'row2Value2': 0,
              'row3Title': 'Total Quantity',
              'row3Value1': productStock.totalProductQuantityInStock,
              'row3Value2': 0,
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class MySalesWidgetBlurred extends StatelessWidget {
  const MySalesWidgetBlurred({super.key});

  @override
  Widget build(BuildContext context) {
    return const BluredContainer(
        height: 320, width: 420, child: MySalesWidget());
  }
}

class MySalesWidget extends StatelessWidget {
  const MySalesWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FullSalesBloc, FullSalesState>(
      builder: (context, state) {
        if (state.status == FullSalesStatus.loaded) {
          /// all sales data
          SalesData salesData = SalesData(sales: state.fullSales);

          /// techserviceSales Data
          TechServiceSalesData techServiceSalesData =
              salesData.serviceSalesData;

          /// productSales Data
          ProductSalesData productSalesData = salesData.productSalesData;

          return MyInventoryTable(
            data: {
              'iconData': FontAwesomeIcons.coins,
              'wedgetTitle': 'Sales'.tr(),
              'bottomText': 'Net Profit'.tr(),
              'bottomValue': salesData.totalNetProfit,
              'column1': 'Products',
              'column2': 'Services',
              'row1Title': 'Amount',
              'row1Value1': productSalesData.totalProductSalesFor,
              'row1Value2': 0,
              'row2Title': 'Quantity Sold',
              'row2Value1': productSalesData.totalProductSalesCount,
              'row2Value2': 0,
              'row3Title': 'Total Sold',
              'row3Value1': salesData.totalSoldAmount,
              'row3Value2': techServiceSalesData.totalServiceSalesFor,
            },
          );
        } else {
          return Center(
            child: Column(
              children: [
                Text('Loading...${state.toString()}'),
                const CircularProgressIndicator(),
              ],
            ),
          );
        }
      },
    );
  }
}

// class SalesByCategoryWidgetBlurred extends StatelessWidget {
//   const SalesByCategoryWidgetBlurred({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const BluredContainer(
//         height: 320, width: 420, child: SalesByCategoryWidget([]));
//   }
// }

// class SalesByCategoryWidget extends StatelessWidget {
//   final SalesData salesData;
//   const SalesByCategoryWidget({
//     Key? key,
//     required this.salesData,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MyInventoryTable(
//       endWidget: DropDownButton(
//         dropDownItems: [],
//         onChanged: (value) {},
//         initialValue: null,
//       ),
//       data: {
//         'iconData': FontAwesomeIcons.phone,
//         'wedgetTitle': 'Categories'.tr(),
//         'bottomText': 'Net Profit'.tr(),
//         'bottomValue': salesData.totalNetProfit,
//         'column1': '',
//         'column2': '',
//         'row1Title': 'Amount',
//         'row1Value1': null,
//         'row1Value2': salesData.totalSoldAmount,
//         'row2Title': 'Quantity Sold',
//         'row2Value1': null,
//         'row2Value2': salesData.totalQuantitySold,
//         'row3Title': '',
//         'row3Value1': null,
//         'row3Value2': null,
//       },
//     );
//   }
// }

// class DropDownButton extends StatelessWidget {
//   final List<String> dropDownItems;
//   final Function(String?) onChanged;
//   final Function(String)? onInit;
//   final String? initialValue;
//   const DropDownButton({
//     Key? key,
//     required this.dropDownItems,
//     required this.onChanged,
//     this.onInit,
//     this.initialValue,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//       child: Container(
//         width: 120,
//         height: 32,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(8),
//           color: const Color.fromARGB(61, 255, 255, 255),
//         ),
//         child: DropdownButtonHideUnderline(
//           child: DropdownButton<String>(
//             isExpanded: true,
//             isDense: true,
//             alignment: Alignment.center,
//             borderRadius: BorderRadius.circular(8),
//             value: initialValue,
//             icon: const Icon(Icons.arrow_drop_down),
//             iconSize: 24,
//             elevation: 16,
//             style: const TextStyle(color: Colors.deepPurple),
//             underline: Container(
//               height: 2,
//               color: const Color.fromARGB(255, 77, 175, 255),
//             ),
//             onChanged: (String? newValue) {
//               onChanged(newValue);
//             },
//             items: dropDownItems.map<DropdownMenuItem<String>>((String value) {
//               return DropdownMenuItem<String>(
//                 value: value,
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                   child: Text(
//                     value,
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               );
//             }).toList(),
//           ),
//         ),
//       ),
//     );
//   }
// }
// class My13SalesWidget extends ConsumerWidget {
//   const My13SalesWidget({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     var salesData13 = ref.watch(salesDataStateNotifierProvider);
//     var productSalesData13 = ref.watch(productSalesDataStateNotifierProvider);
//     var serviceSalesData13 =
//         ref.watch(serviceSalesDataStateNotifierProvider.state).state;
//     return SizedBox(
//       height: 200,
//       width: 420,
//       child: Card(
//         child: Column(
//           children: [
//             SizedBox(
//               height: 40,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       children: [
//                         const FaIcon(FontAwesomeIcons.coins),
//                         const SizedBox(width: 8),
//                         Text(
//                           'Sales :'.tr(),
//                           style: Theme.of(context)
//                               .textTheme
//                               .headline3!
//                               .copyWith(
//                                   color: Theme.of(context).colorScheme.primary),
//                         ),
//                         Text(
//                           ' ${SelectedDateRange.customRange.start.ddmmyyyy()} to ${SelectedDateRange.customRange.end.ddmmyyyy()}'
//                               .tr(),
//                           style: Theme.of(context)
//                               .textTheme
//                               .subtitle2!
//                               .copyWith(
//                                   color: Theme.of(context).colorScheme.primary),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const Icon(Icons.more_vert),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 100,
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(left: 8.0, right: 8),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Products Sold'.tr(),
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .caption!
//                                   .copyWith(
//                                       color: Theme.of(context)
//                                           .colorScheme
//                                           .onPrimary),
//                             ),
//                             buildTextOnValue(context,
//                                 withDollarSign: true,
//                                 text: 'Amount'.tr(),
//                                 value: productSalesData13
//                                     .salesByDateRange13.totalSoldAmount),
//                             buildTextOnValue(context,
//                                 withDollarSign: false,
//                                 text: 'Quantity'.tr(),
//                                 value: productSalesData13
//                                     .salesByDateRange13.totalQuantitySold
//                                     .toDouble()),
//                           ],
//                         ),
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Services Sold'.tr(),
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .caption!
//                                   .copyWith(
//                                       color: Theme.of(context)
//                                           .colorScheme
//                                           .onPrimary),
//                             ),
//                             buildTextOnValue(context,
//                                 text: 'Amount'.tr(),
//                                 withDollarSign: true,
//                                 value: serviceSalesData13
//                                     .salesByDateRange13.totalSoldAmount),
//                             buildTextOnValue(context,
//                                 withDollarSign: false,
//                                 text: 'Quantity'.tr(),
//                                 value: 0.toDouble()),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 40,
//               child: Column(
//                 children: [
//                   Divider(
//                     height: 0.5,
//                     thickness: 0.5,
//                     color: Theme.of(context).colorScheme.onPrimary,
//                     endIndent: 8,
//                     indent: 8,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 8.0, top: 8, right: 8),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Total Net Profit'.tr(),
//                           style: Theme.of(context).textTheme.caption!.copyWith(
//                               color: Theme.of(context).colorScheme.onPrimary),
//                         ),
//                         PriceNumberZone(
//                           withDollarSign: true,
//                           right: const SizedBox.shrink(),
//                           price: salesData13.salesByDateRange13.totalNetProfit,
//                           style: Theme.of(context)
//                               .textTheme
//                               .headline2!
//                               .copyWith(
//                                   color: Theme.of(context).colorScheme.primary),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class MyIncomeWidget extends ConsumerWidget {
//   const MyIncomeWidget({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     var incomesData = ref.watch(incomesDataStateNotifierProvider);
//     return SizedBox(
//       height: 200,
//       width: 210,
//       child: Card(
//         child: Column(
//           children: [
//             SizedBox(
//               height: 40,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       children: [
//                         const Icon(FontAwesomeIcons.handHoldingDollar),
//                         const SizedBox(width: 8),
//                         Text(
//                           'Income'.tr(),
//                           style: Theme.of(context)
//                               .textTheme
//                               .headline3!
//                               .copyWith(
//                                   color: Theme.of(context).colorScheme.primary),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const Icon(Icons.more_vert),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 100,
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         buildTextOnValue(context,
//                             text: 'Highest'.tr(),
//                             withDollarSign: true,
//                             value: incomesData
//                                 .filterIncomesData.highestIncomeAmount),
//                         buildTextOnValue(context,
//                             text: 'Lowest'.tr(),
//                             withDollarSign: true,
//                             value: incomesData
//                                 .filterIncomesData.lowestIncomeAmount),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 40,
//               child: Column(
//                 children: [
//                   Divider(
//                     height: 0.5,
//                     thickness: 0.5,
//                     color: Theme.of(context).colorScheme.onPrimary,
//                     endIndent: 8,
//                     indent: 8,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 8.0, top: 8, right: 8),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Total'.tr(),
//                           style: Theme.of(context).textTheme.caption!.copyWith(
//                               color: Theme.of(context).colorScheme.onPrimary),
//                         ),
//                         PriceNumberZone(
//                           withDollarSign: true,
//                           right: const SizedBox.shrink(),
//                           price:
//                               incomesData.filterIncomesData.totalIncomeAmount,
//                           style: Theme.of(context)
//                               .textTheme
//                               .headline2!
//                               .copyWith(
//                                   color: Theme.of(context).colorScheme.primary),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class MyExpensesWidget extends ConsumerWidget {
//   const MyExpensesWidget({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     var expensesData = ref.watch(expensesDataStateNotifierProvider.state);

//     return SizedBox(
//       height: 200,
//       width: 210,
//       child: Card(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//               height: 40,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       children: [
//                         const Icon(FontAwesomeIcons.fileInvoiceDollar),
//                         const SizedBox(width: 8),
//                         Text(
//                           'Expenses'.tr(),
//                           style: Theme.of(context)
//                               .textTheme
//                               .headline3!
//                               .copyWith(
//                                   color: Theme.of(context).colorScheme.primary),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const Icon(Icons.more_vert),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 100,
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       LinearPercentIndicator(
//                         width: 120,
//                         animation: true,
//                         lineHeight: 5.0,
//                         animationDuration: 2000,
//                         percent:
//                             expensesData.state.filterExpensesData.unitInterval,
//                         progressColor: Theme.of(context).colorScheme.primary,
//                         backgroundColor:
//                             Theme.of(context).colorScheme.onPrimary,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(right: 8.0),
//                         child: Text(
//                             "${expensesData.state.filterExpensesData.totalDifferencePercentage} %",
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .subtitle2!
//                                 .copyWith(
//                                     color: Theme.of(context)
//                                         .colorScheme
//                                         .onPrimary)),
//                       ),
//                     ],
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         buildTextOnValue(context,
//                             text: 'Highest'.tr(),
//                             withDollarSign: true,
//                             value: expensesData
//                                 .state.filterExpensesData.highestExpenseAmount),
//                         buildTextOnValue(context,
//                             text: 'Lowest'.tr(),
//                             withDollarSign: true,
//                             value: expensesData
//                                 .state.filterExpensesData.lowestExpenseAmount),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(
//                       left: 8.0,
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Unpaid',
//                           style: Theme.of(context).textTheme.caption!.copyWith(
//                               color: Theme.of(context).colorScheme.onPrimary),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(right: 8.0),
//                           child: PriceNumberZone(
//                             withDollarSign: true,
//                             right: const SizedBox.shrink(),
//                             price: expensesData.state.filterExpensesData
//                                 .totalUnPaidExpensesAmount,
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .headline4!
//                                 .copyWith(
//                                     color: Theme.of(context)
//                                         .colorScheme
//                                         .onPrimary),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 40,
//               child: Column(
//                 children: [
//                   Divider(
//                     height: 0.5,
//                     thickness: 0.5,
//                     color: Theme.of(context).colorScheme.onPrimary,
//                     endIndent: 8,
//                     indent: 8,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 8.0, top: 8, right: 8),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Total Paid '.tr(),
//                           style: Theme.of(context).textTheme.caption!.copyWith(
//                               color: Theme.of(context).colorScheme.onPrimary),
//                         ),
//                         PriceNumberZone(
//                           withDollarSign: true,
//                           right: const SizedBox.shrink(),
//                           price: expensesData
//                               .state.filterExpensesData.totalExpensesAmount,
//                           style: Theme.of(context)
//                               .textTheme
//                               .headline2!
//                               .copyWith(
//                                   color: Theme.of(context).colorScheme.primary),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class MyDebtsWidget extends ConsumerWidget {
//   const MyDebtsWidget({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     var debtsData = ref.watch(debtsDataStateNotifierProvider);
//     return SizedBox(
//       height: 200,
//       width: 210,
//       child: Card(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//               height: 40,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       children: [
//                         const Icon(FontAwesomeIcons.moneyCheck),
//                         const SizedBox(width: 8),
//                         Text(
//                           'Debts'.tr(),
//                           style: Theme.of(context)
//                               .textTheme
//                               .headline3!
//                               .copyWith(
//                                   color: Theme.of(context).colorScheme.primary),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const Icon(Icons.more_vert),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 100,
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       LinearPercentIndicator(
//                         width: 120,
//                         animation: true,
//                         lineHeight: 5.0,
//                         animationDuration: 2000,
//                         percent: debtsData.filterDebts.unitInterval,
//                         progressColor: Theme.of(context).colorScheme.primary,
//                         backgroundColor:
//                             Theme.of(context).colorScheme.onPrimary,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(right: 8.0),
//                         child: Text(
//                             "${debtsData.filterDebts.totalDifferencePercentage} %",
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .subtitle2!
//                                 .copyWith(
//                                     color: Theme.of(context)
//                                         .colorScheme
//                                         .onPrimary)),
//                       ),
//                     ],
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         buildTextOnValue(context,
//                             withDollarSign: true,
//                             text: 'Highest'.tr(),
//                             value: debtsData.filterDebts.highestDebtAmount),
//                         buildTextOnValue(context,
//                             withDollarSign: true,
//                             text: 'Lowest'.tr(),
//                             value: debtsData.filterDebts.lowestDebtAmount),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(
//                       left: 8.0,
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Paid',
//                           style: Theme.of(context).textTheme.caption!.copyWith(
//                               color: Theme.of(context).colorScheme.onPrimary),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(right: 8.0),
//                           child: PriceNumberZone(
//                             withDollarSign: true,
//                             right: const SizedBox.shrink(),
//                             price: debtsData.filterDebts.totalPaidDebtAmount
//                                 .toPrecision()
//                                 .toPrecision(),
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .headline4!
//                                 .copyWith(
//                                     color: Theme.of(context)
//                                         .colorScheme
//                                         .onPrimary),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 40,
//               child: Column(
//                 children: [
//                   Divider(
//                     height: 0.5,
//                     thickness: 0.5,
//                     color: Theme.of(context).colorScheme.onPrimary,
//                     endIndent: 8,
//                     indent: 8,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 8.0, top: 8, right: 8),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Total Unaid '.tr(),
//                           style: Theme.of(context).textTheme.caption!.copyWith(
//                               color: Theme.of(context).colorScheme.onPrimary),
//                         ),
//                         PriceNumberZone(
//                           withDollarSign: true,
//                           right: const SizedBox.shrink(),
//                           price: debtsData.filterDebts.totalDebtAmountLeft,
//                           style: Theme.of(context)
//                               .textTheme
//                               .headline2!
//                               .copyWith(
//                                   color: Theme.of(context).colorScheme.primary),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // CircularPercentIndicator(
// //                 radius: 60.0,
// //                 lineWidth: 2.0,
// //                 animation: true,
// //                 percent: 0.7,
// //                 center:  Text(
// //                   "70.0%",
// //                   style:
// //                        Theme.of(context).textTheme.subtitle2!.copyWith(
// //                           color: Theme.of(context).colorScheme.onPrimary),
// //                 ),

// //                 circularStrokeCap: CircularStrokeCap.round,
// //                 progressColor: Theme.of(context).colorScheme.primary,
// //               ),

// buildTextOnValue(BuildContext context,
//     {required double value, String? text, required bool withDollarSign}) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Text(
//         '$text'.tr(),
//         style: Theme.of(context)
//             .textTheme
//             .subtitle2!
//             .copyWith(color: Theme.of(context).colorScheme.onPrimary),
//       ),
//       PriceNumberZone(
//         withDollarSign: withDollarSign,
//         right: const SizedBox.shrink(),
//         price: value,
//         style: Theme.of(context)
//             .textTheme
//             .headline4!
//             .copyWith(color: Theme.of(context).colorScheme.onPrimary),
//       ),
//     ],
//   );
// }
