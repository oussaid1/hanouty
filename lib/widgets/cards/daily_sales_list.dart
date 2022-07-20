// import 'package:hanouty/models/tagged.dart';
// import 'package:flutter/material.dart';
// import 'package:hanouty/components.dart';

// class DailySaleslistCard extends StatelessWidget {
//   final String? title;

//   final Color? mColor;

//   final Color? m2Color;

//   const DailySaleslistCard({
//     Key? key,
//     this.title,
//     this.mColor,
//     this.m2Color,
//     required this.taggedProductSalesList,
//   }) : super(key: key);
//   final List<TaggedSales> taggedProductSalesList;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SizedBox(
//           height: 400,
//           width: 420,
//           child: Card(
//             child: Column(
//               children: [
//                 SizedBox(
//                   width: 420,
//                   height: 60,
//                   child: Card(
//                     color: Theme.of(context).primaryColor,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(
//                             title!,
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .headline3!
//                                 .copyWith(color: mColor),
//                           ).tr(),
//                         ),
//                         Card(
//                           margin: const EdgeInsets.all(8),
//                           color: mColor,
//                           child: IconButton(
//                               onPressed: () {},
//                               icon: const Icon(
//                                 Icons.arrow_forward_rounded,

//                                 //color: MThemeData.accentVarient5,
//                               )),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: taggedProductSalesList.length,
//                     // separatorBuilder: (BuildContext context, int index) =>
//                     //     const Divider(),
//                     itemBuilder: (BuildContext context, int index) {
//                       final TaggedSales taggedProductSale =
//                           taggedProductSalesList[index];
//                       return ListTile(
//                         dense: true,
//                         subtitle: const Text('------'),
//                         title: Text(
//                           taggedProductSale.tagString,
//                           style: Theme.of(context)
//                               .textTheme
//                               .bodyText2!
//                               .copyWith(color: m2Color),
//                         ),
//                         trailing: Text(
//                           '${taggedProductSale.salesData.totalSoldAmount} \$',
//                           style: Theme.of(context)
//                               .textTheme
//                               .bodyText2!
//                               .copyWith(color: mColor),
//                         ),
//                         leading: Icon(
//                           Icons.local_mall_outlined,
//                           size: 18,
//                           color: m2Color,
//                         ),
//                         // subtitle: Text(
//                         //   '.....',
//                         //   style: Theme.of(context).textTheme.subtitle2!,
//                         // ),
//                         //dense: true,
//                       );
//                     },
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
