// import 'package:hanouty/local_components.dart';
// import 'package:flutter/material.dart';
// import 'package:hanouty/components.dart';

// class DailySalesWidget extends ConsumerWidget {
//   final String? title;
//   final String? totalSales;

//   final String? leftText;

//   final String? leftNumber;

//   final String? rightText;

//   final String? rightNumber;

//   const DailySalesWidget({
//     Key? key,
//     this.title,
//     this.totalSales,
//     this.leftText,
//     this.leftNumber,
//     this.rightText,
//     this.rightNumber,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final mincrementableDate = ref.watch(incrementableDate.state);
//     return SizedBox(
//       width: 300,
//       height: 200,
//       child: Card(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//               width: 300,
//               height: 60,
//               child: Card(
//                 color: Theme.of(context).primaryColor,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                         child: IncremntableDate(
//                             incrementableDate: mincrementableDate)),
//                   ],
//                 ),
//               ),
//             ),
//             Flexible(
//               fit: FlexFit.tight,
//               flex: 2,
//               child: Padding(
//                 padding: const EdgeInsets.all(8),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Text(leftText!,
//                             textAlign: TextAlign.center,
//                             style: Theme.of(context).textTheme.subtitle2!),
//                         Text(
//                           leftNumber!,
//                           textAlign: TextAlign.center,
//                           style: Theme.of(context)
//                               .textTheme
//                               .bodyText1!
//                               .copyWith(color: MThemeData.salesColor),
//                         ),
//                       ],
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Text(
//                           rightText!,
//                           textAlign: TextAlign.center,
//                           style: Theme.of(context).textTheme.subtitle2!,
//                         ),
//                         Text(
//                           rightNumber!,
//                           textAlign: TextAlign.center,
//                           style: Theme.of(context)
//                               .textTheme
//                               .bodyText1!
//                               .copyWith(color: MThemeData.salesColor),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Flexible(
//               fit: FlexFit.tight,
//               flex: 1,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(4.0),
//                     child: Text(
//                       'Total'.tr(),
//                       style: Theme.of(context)
//                           .textTheme
//                           .bodyText1!
//                           .copyWith(color: MThemeData.serviceColor),
//                     ).tr(),
//                   ),
//                   Row(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.all(4.0),
//                         child: Text(
//                           totalSales!,
//                           style: Theme.of(context)
//                               .textTheme
//                               .bodyText2!
//                               .copyWith(color: MThemeData.hintTextColor),
//                         ),
//                       ),
//                       double.parse(totalSales!) > 0
//                           ? const Icon(
//                               Icons.arrow_upward_outlined,
//                               size: 24,
//                               color: MThemeData.serviceColor,
//                             )
//                           : const Icon(
//                               Icons.arrow_downward_outlined,
//                               size: 24,
//                               color: MThemeData.errorColor,
//                             ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class IncremntableDate extends StatelessWidget {
//   const IncremntableDate({
//     Key? key,
//     required this.incrementableDate,
//   }) : super(key: key);

//   final StateController<DateTime> incrementableDate;

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: Theme.of(context).scaffoldBackgroundColor,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           IconButton(
//               onPressed: () {
//                 incrementableDate.state =
//                     incrementableDate.state.add(const Duration(days: 1));
//               },
//               icon: const Icon(
//                 Icons.plus_one_outlined,
//                 color: MThemeData.serviceColor,
//                 size: 20,
//               )),
//           Expanded(
//               flex: 1,
//               child: Text(
//                 incrementableDate.state.formatted(),
//                 style: Theme.of(context)
//                     .textTheme
//                     .headline3!
//                     .copyWith(color: MThemeData.serviceColor),
//                 textAlign: TextAlign.center,
//               )),
//           IconButton(
//               onPressed: () {
//                 incrementableDate.state =
//                     incrementableDate.state.subtract(const Duration(days: 1));
//               },
//               icon: const Icon(
//                 Icons.exposure_minus_1_outlined,
//                 color: MThemeData.serviceColor,
//                 size: 20,
//               )),
//         ],
//       ),
//     );
//   }
// }
