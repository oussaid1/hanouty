// import 'package:flutter/material.dart';

// import 'package:hanouty/components.dart';

// import '../price_number_zone.dart';

// class Top10SalesListCard extends ConsumerWidget {
//   const Top10SalesListCard({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {

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
//                   Padding(
//                     padding: const EdgeInsets.only(left: 18.0, right: 18),
//                     child: Text(
//                       'Top 10 Sold '.tr(),
//                       style: Theme.of(context).textTheme.headline3!.copyWith(
//                           color: Theme.of(context).colorScheme.primary),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: SizedBox(
//                 height: 400,
//                 width: 400,
//                 child: ListView.separated(
//                   itemCount: 0,
//                   separatorBuilder: (BuildContext context, int index) =>
//                       const Divider(),
//                   itemBuilder: (BuildContext context, int index) {
//                     //     .sort((b, a) => a.dateSold.compareTo(b.dateSold));
//                     //final sale = [];
//                     return ListTile(
//                       leading: Icon(Icons.tour_sharp,
//                           color: Theme.of(context).colorScheme.secondary),
//                       title: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Expanded(
//                             flex: 2,
//                             child: Text(
//                               "",
//                               overflow: TextOverflow.ellipsis,
//                               softWrap: true,
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .bodyText2!
//                                   .copyWith(
//                                       color: Theme.of(context)
//                                           .colorScheme
//                                           .primary),
//                             ),
//                           ),
//                           Expanded(
//                             flex: 0,
//                             child: PriceNumberZone(
//                               withDollarSign: true,
//                               right: const SizedBox.shrink(),
//                               price: 8,
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .headline2!
//                                   .copyWith(
//                                       color: Theme.of(context)
//                                           .colorScheme
//                                           .primary),
//                             ),
//                           ),
//                         ],
//                       ),
//                       subtitle: Text(
//                         '{sale.}',
//                         style: Theme.of(context).textTheme.subtitle2!,
//                       ),
//                       dense: true,
//                     );
//                   },
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
