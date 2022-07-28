// import 'package:hanouty/models/product/product.dart';
// import 'package:hanouty/providers/auth/databaseproviders.dart';
// import 'package:hanouty/providers/var_provider.dart';
// import 'package:hanouty/screens/product/add_product/add_product.dart';
// import 'package:hanouty/screens/sell/sell_product/sell_product_dialogue.dart';
// import 'package:hanouty/settings/themes.dart';
// import 'package:hanouty/utils/glasswidgets.dart';
// import 'package:flutter/material.dart';

// import '../../components.dart';
// import '../dialogues/popup_dialogues.dart';

// final sizeProvider = StateProvider<double>((ref) {
//   return 80;
// });

// class ProductListCard extends ConsumerWidget {
//   final Color? mScarecColor;

//   const ProductListCard({Key? key, required this.product, this.mScarecColor})
//       : super(key: key);
//   final ProductModel product;
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Slidable(
//       startActionPane: ActionPane(
//         motion: const ScrollMotion(),
//         children: [
//           SlidableAction(
//             onPressed: (context) {
//               ref.read(sellCounterProvider.notifier).state = (product.quantity);
//               ref.read(priceSoldForProvider.state).state = product.priceOut;
//               ref.read(pickedDateTime.state).state = DateTime.now();
//               MDialogs.dialogSimple(context,
//                   title: Text(
//                     "Sell : ".tr() + product.productName,
//                     style: Theme.of(context)
//                         .textTheme
//                         .headline3!
//                         .copyWith(color: MThemeData.productColor),
//                     textAlign: TextAlign.center,
//                   ),
//                   contentWidget: SizedBox(
//                     height: 420,
//                     width: 400,
//                     child: SellProductDialoge(
//                       product: product,
//                     ),
//                   ));
//             },
//             backgroundColor: const Color.fromARGB(0, 33, 182, 202),
//             foregroundColor: Colors.white,
//             icon: Icons.price_check_rounded,
//             label: 'Sell'.tr(),
//           ),
//         ],
//       ),
//       endActionPane: ActionPane(
//         motion: const ScrollMotion(),
//         children: [
//           SlidableAction(
//             onPressed: (context) {
//               // ref.read(pickedDateTime.state).state = product.dateIn;
//               // ref.read(quantityProvider.state).state = product.quantity;
//               // ref.read(selectedSelectOrAddCat.state).state = product.category!;
//               // ref.read(selectedSelectOrAddSuplier.state).state =
//               //     product.suplier!;

//               MDialogs.dialogSimple(
//                 context,
//                 title: Text(
//                   "Edit product".tr(),
//                   style: Theme.of(context).textTheme.headline3!,
//                 ),
//                 contentWidget: SizedBox(
//                   height: 400,
//                   width: 400,
//                   child: AddOrEditProduct(
//                     product: product,
//                   ),
//                 ),
//               );
//             },
//             backgroundColor: const Color.fromARGB(0, 33, 182, 202),
//             foregroundColor: Colors.white,
//             icon: Icons.edit_outlined,
//             label: "Edit product".tr(),
//           ),
//           SlidableAction(
//             onPressed: (context) {
//               MDialogs.dialogSimple(
//                 context,
//                 title: Text(
//                   " ${product.productName}",
//                   style: Theme.of(context).textTheme.headline3!,
//                 ),
//                 contentWidget: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     ElevatedButton(
//                       style: MThemeData.raisedButtonStyleSave,
//                       child: Text(
//                         'Delete'.tr(),
//                         style: Theme.of(context).textTheme.bodyText1!,
//                       ),
//                       onPressed: () {
//                         ref
//                             .read(databaseProvider)!
//                             .deleteProduct(product)
//                             .then((value) {
//                           if (value) {
//                             ScaffoldMessenger.of(context)
//                                 .showSnackBar(MDialogs.snackBar('Done !'));

//                             Navigator.of(context).pop();
//                           } else {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                                 MDialogs.errorSnackBar('Error !'));
//                           }
//                         });
//                       },
//                     ),
//                     ElevatedButton(
//                       style: MThemeData.raisedButtonStyleCancel,
//                       child: Text(
//                         'Cancel'.tr(),
//                         style: Theme.of(context).textTheme.bodyText1!,
//                       ),
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                     ),
//                   ],
//                 ),
//               );
//             },
//             backgroundColor: const Color.fromARGB(0, 33, 182, 202),
//             foregroundColor: const Color.fromARGB(255, 253, 77, 77),
//             icon: Icons.remove_circle_outline,
//             label: "Delete product".tr(),
//           ),
//         ],
//       ),
//       child: GlassContainer(
//         child: Row(
//           children: [
//             Expanded(
//               child: Container(
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     color: product.color,
//                     width: 0.6,
//                   ),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: ExpansionTile(
//                   onExpansionChanged: (value) {
//                     value ? ref.read(sizeProvider.state).state = 124 : 80;
//                   },
//                   leading: CircleAvatar(
//                     backgroundColor: MThemeData.primaryColor,
//                     child: Text(
//                       product.productName.substring(0, 1),
//                       style: Theme.of(context).textTheme.headline3!,
//                     ),
//                   ),
//                   title: Text(
//                     product.productName,
//                   ),
//                   subtitle: Text(
//                     '${product.suplier} ${product.dateIn.ddmmyyyy()}',
//                     style: Theme.of(context).textTheme.subtitle2!,
//                   ),
//                   trailing: Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Text(
//                         product.quantity.toString(),
//                         style: Theme.of(context)
//                             .textTheme
//                             .headline3!
//                             .copyWith(color: product.color),
//                       ),
//                       Text(
//                         product.category.toString(),
//                         style: Theme.of(context).textTheme.subtitle2!,
//                       ),
//                     ],
//                   ),
//                   children: [
//                     Row(
//                       children: [
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             RichText(
//                               text: TextSpan(
//                                 text: ' Price-in :',
//                                 style: Theme.of(context).textTheme.subtitle2!,
//                                 children: [
//                                   TextSpan(
//                                     text: ' ${product.priceIn}',
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .bodyText1!
//                                         .copyWith(
//                                           color: MThemeData.serviceColor,
//                                         ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             RichText(
//                               text: TextSpan(
//                                 text: ' Price-out :',
//                                 style: Theme.of(context).textTheme.subtitle2!,
//                                 children: [
//                                   TextSpan(
//                                     text: ' ${product.priceOut}',
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .bodyText1!
//                                         .copyWith(
//                                           color: MThemeData.expensesColor,
//                                         ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Text(
//                               '${product.description}',
//                               style: Theme.of(context).textTheme.subtitle2!,
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
