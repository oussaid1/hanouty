// import 'package:hanouty/models/Sale/sale.dart';
// import 'package:hanouty/models/client/shop_client.dart';
// import 'package:hanouty/models/techservice/techservice.dart';
// import 'package:hanouty/providers/client_crud.dart';
// import 'package:hanouty/providers/sell_action.dart';
// import 'package:hanouty/providers/var_provider.dart';
// import 'package:hanouty/settings/themes.dart';
// import 'package:hanouty/widgets/date_pickers.dart/date_picker.dart';
// import 'package:hanouty/widgets/dialogues/popup_dialogues.dart';
// import 'package:hanouty/widgets/spinners/client_spinner.dart';
// import 'package:flutter/services.dart';
// import '/../components.dart';
// import 'package:flutter/material.dart';

// class SellTechServiceDialoge extends ConsumerStatefulWidget {
//   const SellTechServiceDialoge(
//       {Key? key, required this.isUpdate, this.sale, required this.techService})
//       : super(key: key);
//   final TechServiceModel techService;
//   final SaleModel? sale;
//   final bool isUpdate;
//   @override
//   AddTechServiceState createState() => AddTechServiceState();
// }

// class AddTechServiceState extends ConsumerState<SellTechServiceDialoge> {
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   //bool isProduct = false;
//   final TextEditingController priceOutController = TextEditingController();
//   // ignore: prefer_final_fields
//   void clear() {
//     priceOutController.clear();
//   }

//   @override
//   void initState() {
//     priceOutController.text = widget.techService.priceOut.toString();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     clear();
//     super.dispose();
//   }

//   @override
//   Widget build(
//     BuildContext context,
//   ) {
//     // ignore: unused_local_variable
//     // final dBTechServices = ref.watch(techServicesProvider.state).state;

//     final clientList = ref.watch(shopClientsProvider.state).state;
//     //final number = ref.watch(incrementedNumber);
//     //final sellDate = ref.watch(pickedDateTime.state).state;
//     return SizedBox(
//       width: 300,
//       height: 460,
//       child: SingleChildScrollView(
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(6),
//             //color: Theme.of(context).colorScheme.onBackground,
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 // Responsive.isMobile(context)
//                 //     ? const InStockWidget()
//                 //     : const SizedBox.shrink(),
//                 const SizedBox(height: 10),
//                 // widget.isUpdate
//                 //     ? buildType(_isProduct)
//                 //     : const SizedBox.shrink(),
//                 Form(
//                   key: formKey,
//                   child: Column(
//                     children: [
//                       buildClientName(ref, clientList),
//                       const SizedBox(height: 8),
//                       buildQuantity(context, ref),
//                       const SizedBox(height: 8),
//                       SizedBox(
//                           width: 220.0,
//                           child: buildPriceIn(priceOutController, ref)),
//                       const SizedBox(height: 8),
//                       buildDate(),
//                       const SizedBox(height: 40),
//                     ],
//                   ),
//                 ),

//                 buildSaveButton(
//                   context,
//                   ref,
//                 ),
//                 const SizedBox(
//                   height: 100,
//                 ) //but
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Row buildSaveButton(
//     BuildContext context,
//     WidgetRef ref,
//   ) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: [
//         ElevatedButton(
//           style: MThemeData.raisedButtonStyleSave,
//           child: Text(
//             'Sell'.tr(),
//           ),
//           onPressed: () {
//             if (formKey.currentState!.validate()) {
//               SaleModel sell = SaleModel(
//                 shopClientId: ref.read(selectedShopClient.state).state!.id!,
//                 priceSoldFor: (ref.read(priceSoldForProvider.state).state),
//                 type: SaleType.service,
//                 priceIn: widget.techService.priceIn,
//                 priceOut: widget.techService.priceOut,
//                 quantitySold: ref.read(sellCounterProvider.state).state,
//                 dateSold: ref.read(pickedDateTime.state).state,
//                 itemSoldTitle: widget.techService.title,
//                 soldItemId: widget.techService.id!,
//               );
//               ref
//                   .read(sellActionsProvider)
//                   .sellService(sale: sell, service: widget.techService)
//                   .then((mReturnValue) {
//                 if (mReturnValue.success) {
//                   ScaffoldMessenger.of(context)
//                       .showSnackBar(MDialogs.snackBar(mReturnValue.message!));

//                   clear();
//                   Navigator.pop(context);
//                 } else {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                       MDialogs.errorSnackBar(mReturnValue.message!));
//                 }
//               });
//             }
//           },
//         ),
//         const SizedBox(
//           width: 10,
//         ),
//         ElevatedButton(
//           style: MThemeData.raisedButtonStyleCancel,
//           child: Text(
//             'Cancel'.tr(),
//           ),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ],
//     );
//   }

//   Widget buildClientName(
//     WidgetRef ref,
//     List<ShopClientModel> list,
//   ) {
//     return ClientSpinnerWidget(
//       list: list,
//     );
//   }

//   Container buildDate() {
//     return Container(
//       margin: const EdgeInsets.only(left: 4, right: 4),
//       decoration: BoxDecoration(
//           border: Border.all(color: MThemeData.hintTextColor),
//           borderRadius: BorderRadius.circular(6)),
//       height: 50,
//       width: 220,
//       child: const SelectDate(),
//     );
//   }

//   Widget buildQuantity(BuildContext context, WidgetRef ref) {
//     var count = ref.watch(sellCounterProvider.state);
//     return SizedBox(
//       width: 220.0,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Text(
//             'Quantity'.tr(),
//             style: Theme.of(context).textTheme.bodyText1!,
//           ),
//           Container(
//             margin: const EdgeInsets.all(4),
//             decoration: BoxDecoration(
//                 border: Border.all(color: Theme.of(context).bottomAppBarColor),
//                 borderRadius: BorderRadius.circular(6)),
//             height: 50,
//             width: 140,
//             child: Row(
//               children: [
//                 IconButton(
//                     icon: const Icon(
//                       Icons.exposure_minus_1_outlined,
//                       color: MThemeData.accentColor,
//                     ),
//                     onPressed: () {
//                       if (count.state > 1) {
//                         ref.read(sellCounterProvider.state).state--;
//                       }

//                       //widget.onSaved(_number);
//                     }),
//                 Expanded(
//                     child: Text(
//                   '${count.state}',
//                   textAlign: TextAlign.center,
//                   style: Theme.of(context).textTheme.headline1,
//                 )),
//                 IconButton(
//                     icon: const Icon(Icons.plus_one,
//                         color: MThemeData.accentColor),
//                     color: MThemeData.accentColor,
//                     onPressed: () {
//                       ref.read(sellCounterProvider.state).state++;

//                       //widget.onSaved(_number);
//                     }),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   TextFormField buildPriceIn(TextEditingController textEditingController, ref) {
//     return TextFormField(
//       onChanged: (value) {
//         if (value.isNotEmpty) {
//           ref.read(priceSoldForProvider.state).state = double.parse(value);
//           textEditingController.text = value;
//         }
//       },
//       controller: textEditingController,
//       validator: (text) {
//         if (text!.trim().isEmpty) {
//           return "error".tr();
//         }
//         return null;
//       },
//       keyboardType: const TextInputType.numberWithOptions(decimal: true),
//       inputFormatters: [
//         FilteringTextInputFormatter.allow(RegExp('[0-9.]+')),
//       ],
//       textAlign: TextAlign.center,
//       decoration: InputDecoration(
//         labelText: 'Price'.tr(),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(6.0),
//           borderSide: const BorderSide(),
//         ),
//         hintText: '1234 \$',
//         hintStyle: Theme.of(context).textTheme.subtitle2!,
//         contentPadding: const EdgeInsets.only(top: 4),
//         prefixIcon: const Icon(Icons.monetization_on_outlined),
//         filled: true,
//       ),
//     );
//   }
// }
