import 'dart:developer';

import 'package:hanouty/blocs/fullsalesbloc/fullsales_bloc.dart';
import 'package:hanouty/widgets/price_number_zone.dart';
import 'package:flutter/material.dart';

import '../../blocs/salesbloc/sales_bloc.dart';
import '../../blocs/sellactionsbloc/sellactions_bloc.dart';
import '../../components.dart';
import '../../local_components.dart';
import '../../utils/constents.dart';
import '../../utils/global_functions.dart';
import '../../widgets/charts/inventory_widget.dart';
import '../../widgets/search_widget.dart';
import 'add_sale/edit_sale.dart';

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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 80.0),
          child: FloatingActionButton.extended(
            icon: const Icon(Icons.add),
            onPressed: () {
              MDialogs.dialogSimple(
                context,
                title: Text(
                  "Add Sale",
                  style: Theme.of(context).textTheme.headline3!,
                ),
                contentWidget: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  //  gradient: MThemeData.gradient2),
                  height: 500,
                  width: 420,
                  child: const AddOrEditSaleWidget(
                      // sale: null,
                      // product: null,
                      // initialDate: null,
                      // initialQuantity: null,
                      ),
                ),
              );
            },
            label: const Text("Add Sale").tr(),
          ),
        ),
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
                var productList = fullSalesState.products;
                var dbSalesList = fullSalesState.dbSales;
                var fullSales = fullSalesState.fullSales;
                FilteredSales filteredSales = FilteredSales(
                  sales: fullSales,
                );
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
                                  height: 320,
                                  child: MySalesWidget(),
                                ),
                              ),
                              buildSalesByCategory(
                                  context, salesData.salesByCategory),
                            ],
                          ),
                          const SizedBox(height: 15),
                          const Expanded(
                            child: Flexible(
                              flex: 1,
                              child: SalesDataTable(),
                            ),
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

  buildSalesByCategory(BuildContext context, List<TaggedSales> taggedSales) {
    return SalesByCategoryWidget(taggedSales: taggedSales);
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
      child: BluredContainer(
        width: 420,
        height: 200,
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
      ),
    );
  }
}

class SalesDataTable extends StatefulWidget {
  // final List<SaleModel> sales;
  //final List<ProductModel> products;
  const SalesDataTable({
    Key? key,
    // required this.sales,
    // required this.products,
  }) : super(key: key);

  @override
  State<SalesDataTable> createState() => _SalesDataTableState();
}

class _SalesDataTableState extends State<SalesDataTable> {
  SaleTableDataSource? _data;

  int _sortColumnIndex = 0;
  bool _sortAscending = true;

  void sort<T>(Comparable<T> Function(SaleModel d) getField, int columnIndex,
      bool ascending) {
    _data!.sort<T>(getField, ascending);
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FullSalesBloc, FullSalesState>(
      builder: (context, state) {
        _data = SaleTableDataSource(
          context,
          state.fullSales,
          onUnSellPressed: (SaleModel saleModel) {
            log('unsell pressed ${saleModel.pId}');

            unSellProduct(context, saleModel);
          },
          onEditPressed: (SaleModel saleModel) =>
              editProduct(context, saleModel),
          onDeletePressed: (SaleModel saleModel) =>
              deleteProduct(context, saleModel),
        );
        return Column(
          children: [
            Text('* tap to sell', style: Theme.of(context).textTheme.subtitle2),
            SearchByWidget(
              listOfCategories: ProductModel.fieldStrings,
              withCategory: true,
              onSearchTextChanged: (String text) {},
              onChanged: (String category) {},
              onBothChanged: (String category, String text) {
                _data!.filterByCategory(category, text);
              },
            ),
            PaginatedDataTable(
              sortColumnIndex: _sortColumnIndex,
              sortAscending: _sortAscending,
              showCheckboxColumn: false,
              columnSpacing: 10,
              checkboxHorizontalMargin: 0,
              horizontalMargin: 4,
              rowsPerPage: 10,
              columns: [
                const DataColumn(
                  label: Text('ID'),
                  tooltip: 'ID',
                ),
                const DataColumn(
                  label: Text('Unsell'),
                  tooltip: 'Unsell',
                ),
                // const  DataColumn(
                //   label: Text('Barcode'),
                //   tooltip: 'Barcode',
                // ),
                DataColumn(
                  label: const Text('Product Name'),
                  tooltip: 'Product Name',
                  onSort: (columnIndex, ascending) => sort(
                    (SaleModel d) => d.productName,
                    columnIndex,
                    ascending,
                  ),
                ),
                const DataColumn(
                  label: Text('Quantity'),
                  tooltip: 'Quantity',
                ),
                const DataColumn(
                  label: Text('Price In'),
                  tooltip: 'Price In',
                ),
                const DataColumn(
                  label: Text('Price Out'),
                  tooltip: 'Price Out',
                ),
                const DataColumn(
                  label: Text('Suplier'),
                  tooltip: 'Suplier',
                ),
                const DataColumn(
                  label: Text('Price Sold For'),
                  tooltip: 'Price Sold For',
                ),
                const DataColumn(
                  label: Text('Date In'),
                  tooltip: 'Date In',
                ),
                const DataColumn(
                  label: Text('Category'),
                  tooltip: 'Category',
                ),
                const DataColumn(
                  label: Text('Description'),
                  tooltip: 'Description',
                ),
                const DataColumn(
                  label: Text('Edit'),
                  tooltip: 'Edit',
                ),
                const DataColumn(
                  label: Text('Delete'),
                  tooltip: 'Delete',
                ),
              ],
              source: _data!,
            ),
          ],
        );
      },
    );
  }

  /// /////////////////////////////////////////////////////////////////////////////
  /// sell product dialog
  void unSellProduct(context, SaleModel saleModel) {
    MDialogs.dialogSimple(
      context,
      title: Text(
        "Unsell: ${saleModel.productName}",
        style: Theme.of(context).textTheme.headline3!,
      ),
      contentWidget: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            style: MThemeData.raisedButtonStyleSave,
            child: Text(
              'Unsell'.tr(),
              style: Theme.of(context).textTheme.bodyText1!,
            ),
            onPressed: () {
              BlocProvider.of<SellActionsBloc>(context)
                  .add(UnsellingRequested(saleModel: saleModel));
              Navigator.pop(context);
            },
          ),
          ElevatedButton(
            style: MThemeData.raisedButtonStyleCancel,
            child: Text(
              'Cancel'.tr(),
              style: Theme.of(context).textTheme.bodyText1!,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  /// /////////////////////////////////////////////////////////////////////////////
  /// edit product dialog
  void editProduct(context, SaleModel saleModel) {
    MDialogs.dialogSimple(
      context,
      title: Text(
        "Edit product".tr(),
        style: Theme.of(context).textTheme.headline3!,
      ),
      contentWidget: SizedBox(
        height: 400,
        width: 400,
        child: AddOrEditSaleWidget(
          sale: saleModel,
          initialDate: saleModel.dateSold,
          initialQuantity: saleModel.quantitySold,
        ),
      ),
    );
  }

  /// /////////////////////////////////////////////////////////////////////////////
  /// delete product dialog
  void deleteProduct(context, SaleModel saleModel) {
    MDialogs.dialogSimple(
      context,
      title: Text(
        " ${saleModel.productName}",
        style: Theme.of(context).textTheme.headline3!,
      ),
      contentWidget: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            style: MThemeData.raisedButtonStyleSave,
            child: Text(
              'Delete'.tr(),
              style: Theme.of(context).textTheme.bodyText1!,
            ),
            onPressed: () {
              BlocProvider.of<SalesBloc>(context)
                  .add(DeleteSalesEvent(saleModel));
              Navigator.pop(context);
            },
          ),
          ElevatedButton(
            style: MThemeData.raisedButtonStyleCancel,
            child: Text(
              'Cancel'.tr(),
              style: Theme.of(context).textTheme.bodyText1!,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
