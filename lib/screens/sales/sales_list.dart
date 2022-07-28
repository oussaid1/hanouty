import 'dart:developer';

import 'package:hanouty/blocs/fullsalesbloc/fullsales_bloc.dart';
import 'package:hanouty/widgets/price_number_zone.dart';
import 'package:flutter/material.dart';
import '../../blocs/salesbloc/sales_bloc.dart';
import '../../blocs/sellactionsbloc/sellactions_bloc.dart';
import '../../components.dart';
import '../../local_components.dart';
import '../../utils/global_functions.dart';
import 'sales_dt_tbl.dart';
import 'sales_iventory_widget.dart';

class SalesList extends StatelessWidget {
  const SalesList({
    Key? key,
    this.sale,
  }) : super(key: key);
  final List<SaleModel>? sale;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // floatingActionButton: Padding(
        //   padding: const EdgeInsets.only(bottom: 80.0),
        //   child: FloatingActionButton.extended(
        //     icon: const Icon(Icons.add),
        //     onPressed: () {
        //       MDialogs.dialogSimple(
        //         context,
        //         title: Text(
        //           "Add Sale",
        //           style: Theme.of(context).textTheme.headline3!,
        //         ),
        //         contentWidget: Container(
        //           decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(6),
        //           ),
        //           height: 500,
        //           width: 420,
        //           child: const AddOrEditSaleWidget(
        //               // sale: null,
        //               // product: null,
        //               // initialDate: null,
        //               // initialQuantity: null,
        //               ),
        //         ),
        //       );
        //     },
        //     label: const Text("Add Sale").tr(),
        //   ),
        // ),
        body: MultiBlocListener(
          listeners: [
            BlocListener<SellActionsBloc, SellActionsState>(
              listener: (context, state) {
                if (state is SellingSuccessfulState) {
                  GlobalFunctions.showSuccessSnackBar(
                      context, 'Successfully Sold '.tr());
                }

                if (state is SellingFailedState) {
                  GlobalFunctions.showErrorSnackBar(
                      context, 'Error selling Sale'.tr());
                }
              },
            ),
          ],
          child: BlocBuilder<FullSalesBloc, FullSalesState>(
            builder: (context, fullSalesState) {
              if (fullSalesState.status == FullSalesStatus.loaded) {
                //  var productList = fullSalesState.products;
                //var dbSalesList = fullSalesState.dbSales;
                var fullSales = fullSalesState.fullSales;
                // FilteredSales filteredSales = FilteredSales(
                //   sales: fullSales,
                // );
                SalesData salesData = SalesData(sales: fullSales);

                return Builder(builder: (context) {
                  return SingleChildScrollView(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        children: [
                          Wrap(
                            direction: Axis.horizontal,
                            spacing: 20,
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 8.0),
                                child: BluredContainer(
                                  width: 420,
                                  height: 200,
                                  child: SalesOverAllWidget(),
                                ),
                              ),
                              BluredContainer(
                                  width: 420,
                                  height: 200,
                                  child: SalesByCategoryWidget(
                                      taggedSales: salesData.salesByCategory)),
                            ],
                          ),
                          const SizedBox(height: 15),
                          const Expanded(
                            child: SalesDataTable(),
                          ),
                        ],
                      ),
                    ),
                  );
                });
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Loading Products ${fullSalesState.status}'.tr(),
                          style: Theme.of(context).textTheme.headline3!),
                      const CircularProgressIndicator(),
                    ],
                  ),
                );
              }
            },
          ),
        ));
  }
}

class SalesByCategoryWidget extends StatefulWidget {
  final List<TaggedSales> taggedSales;

  const SalesByCategoryWidget({
    Key? key,
    required this.taggedSales,
  }) : super(key: key);

  @override
  State<SalesByCategoryWidget> createState() => _SalesByCategoryWidgetState();
}

class _SalesByCategoryWidgetState extends State<SalesByCategoryWidget> {
  TaggedSales? taggedSales1;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.search),
                    const SizedBox(width: 8),
                    Text(
                      "Sales By Category",
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    width: 120,
                    height: 32,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color.fromARGB(61, 255, 255, 255),
                    ),
                    child: Autocomplete<TaggedSales>(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        if (textEditingValue.text == '') {
                          return const Iterable<TaggedSales>.empty();
                        }
                        return widget.taggedSales.where((TaggedSales option) {
                          return option.tag
                              .toLowerCase()
                              .contains(textEditingValue.text.toLowerCase());
                        });
                      },
                      fieldViewBuilder: (BuildContext context,
                          TextEditingController textEditingController,
                          FocusNode focusNode,
                          VoidCallback onFieldSubmitted) {
                        return TextFormField(
                          controller: textEditingController,
                          decoration: InputDecoration(
                            labelText: 'Category',
                            // border: OutlineInputBorder(
                            //   borderRadius: BorderRadius.circular(6.0),
                            //   borderSide: BorderSide(
                            //     width: 0.2,
                            //       color: AppConstants.whiteOpacity),
                            // ),
                            border: InputBorder.none,
                            hintText: 'category_hint',
                            hintStyle: Theme.of(context).textTheme.subtitle2!,
                            filled: true,
                          ),
                          focusNode: focusNode,
                        );
                      },
                      onSelected: (TaggedSales selection) {
                        setState(() {
                          taggedSales1 = selection;
                        });
                        log('Selected: $selection');
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Amount Sold',
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                      ),
                      PriceNumberZone(
                        price: taggedSales1?.salesData.totalSoldAmount ?? 0,
                        // style: Theme.of(context)
                        //     .textTheme
                        //     .headline5!
                        //     .copyWith(
                        //         color:
                        //             Theme.of(context).colorScheme.onPrimary),
                        withDollarSign: true,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Quantity Sold',
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                      ),
                      PriceNumberZone(
                        price: taggedSales1?.salesData.totalQuantitySold ?? 0,
                        // style: Theme.of(context)
                        //     .textTheme
                        //     .headline5!
                        //     .copyWith(
                        //         color:
                        //             Theme.of(context).colorScheme.onPrimary),
                        withDollarSign: true,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Profit',
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                      ),
                      PriceNumberZone(
                        price: taggedSales1?.salesData.totalNetProfit ?? 0,
                        // style: Theme.of(context)
                        //     .textTheme
                        //     .headline4!
                        //     .copyWith(
                        //         color: Theme.of(context).colorScheme.primary),
                        withDollarSign: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
