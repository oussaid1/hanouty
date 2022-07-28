// import 'package:hanouty/local_components.dart';
// import 'package:flutter/material.dart';

// import '../../components.dart';
// import '../price_number_zone.dart';

// class DueDebtsCard extends ConsumerWidget {
//   const DueDebtsCard({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // final debtsData = ref.watch(debtsDataStateNotifierProvider.state).state;

//     return SizedBox(
//       height: 400,
//       width: 420,
//       child: Card(
//         child: Column(
//           children: [
//             SizedBox(
//               width: 420,
//               height: 40,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     children: [
//                       const Padding(
//                         padding: EdgeInsets.all(8.0),
//                         child: Icon(FontAwesomeIcons.userClock),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 18.0, right: 18),
//                         child: Text(
//                           'Due Debts'.tr(),
//                           style: Theme.of(context)
//                               .textTheme
//                               .headline3!
//                               .copyWith(
//                                   color: Theme.of(context).colorScheme.primary),
//                         ),
//                       ),
//                     ],
//                   ),
//                   IconButton(
//                       onPressed: () {},
//                       icon: const Icon(
//                         Icons.more_vert_outlined,
//                       ))
//                 ],
//               ),
//             ),
//             Flexible(
//               fit: FlexFit.tight,
//               flex: 1,
//               child: SizedBox(
//                 height: 300,
//                 width: 420,
//                 child: ListView.builder(
//                   // itemCount: filteredDebts.overdueDebts().length,
//                   itemBuilder: (context, index) {
//                     // filteredDebts
//                     //     .overdueDebts()
//                     //     .sort((a, b) => a.deadLine.compareTo(b.deadLine));
//                     // final debt = filteredDebts.overdueDebts()[index];
//                     return Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Card(
//                         child: ExpansionTile(
//                           leading: SizedBox(
//                             width: 50,
//                             child: Row(
//                               children: const [
//                                 SizedBox(
//                                   width: 10,
//                                   height: 50,
//                                   child: Card(color: MThemeData.productColor),
//                                 ),
//                                 Icon(
//                                   Icons.person_outline_sharp,
//                                   color: MThemeData.hintTextColor,
//                                 ),
//                               ],
//                             ),
//                           ),
//                           title: Text(
//                             '{debt.clientName}',
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .bodyText2!
//                                 .copyWith(
//                                     color:
//                                         Theme.of(context).colorScheme.primary),
//                           ),
//                           trailing: PriceNumberZone(
//                             withDollarSign: true,
//                             right:
//                                 const SizedBox.shrink(), //const Text('left'),
//                             price: 0, //debt.amount,
//                             priceStyle:
//                                 Theme.of(context).textTheme.headline2!.copyWith(
//                                       color: MThemeData.productColor,
//                                     ),
//                           ),
//                           subtitle: Text(
//                             '',
//                             //debt.deadLine.ddmmyyyy(),
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .subtitle2!
//                                 .copyWith(color: MThemeData.productColor),
//                           ),
//                           children: [
//                             Row(
//                               children: [
//                                 const SizedBox(
//                                   width: 10,
//                                 ),
//                                 Row(
//                                   children: [
//                                     Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         RichText(
//                                           text: TextSpan(
//                                             text: ' Days :'.tr(),
//                                             style: Theme.of(context)
//                                                 .textTheme
//                                                 .subtitle2!,
//                                             children: [
//                                               TextSpan(
//                                                 text: '{debt.daysOverdue}',
//                                                 style: Theme.of(context)
//                                                     .textTheme
//                                                     .bodyText1!
//                                                     .copyWith(
//                                                       color: MThemeData
//                                                           .serviceColor,
//                                                     ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         RichText(
//                                           text: TextSpan(
//                                             text: 'Since :'.tr(),
//                                             style: Theme.of(context)
//                                                 .textTheme
//                                                 .subtitle2!,
//                                             children: [
//                                               TextSpan(
//                                                 text:
//                                                     '{debt.timeStamp.ddmmyyyy()}',
//                                                 style: Theme.of(context)
//                                                     .textTheme
//                                                     .bodyText1!
//                                                     .copyWith(
//                                                       color: MThemeData
//                                                           .expensesColor,
//                                                     ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         RichText(
//                                           text: TextSpan(
//                                             text: ' Product :'.tr(),
//                                             style: Theme.of(context)
//                                                 .textTheme
//                                                 .subtitle2!,
//                                             children: [
//                                               TextSpan(
//                                                   text: '{debt.type}',
//                                                   style: Theme.of(context)
//                                                       .textTheme
//                                                       .headline3!
//                                                       .copyWith(
//                                                           color: MThemeData
//                                                               .hintTextColor)),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
