import 'dart:developer';

import 'package:hanouty/widgets/price_number_zone.dart';
import 'package:flutter/material.dart';

import '../../blocs/productbloc/product_bloc.dart';
import '../../blocs/salesbloc/sales_bloc.dart';
import '../../blocs/sellactionsbloc/sellactions_bloc.dart';
import '../../components.dart';
import '../../local_components.dart';
import '../../utils/global_functions.dart';
import '../../widgets/charts/inventory_widget.dart';
import '../../widgets/search_widget.dart';
import 'add_sale/edit_sale.dart';

class SalesList extends ConsumerWidget {
  const SalesList({
    Key? key,
    this.sale,
  }) : super(key: key);
  final List<SaleModel>? sale;

  @override
  Widget build(BuildContext context, ref) {
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
          child: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, productState) {
              if (productState.status == ProductStatus.loaded) {
                var productList = productState.products;

                return Builder(builder: (context) {
                  return SingleChildScrollView(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: BlocBuilder<SalesBloc, SalesState>(
                        builder: (context, salesState) {
                          if (salesState.status == SalesStatus.loaded) {
                            List<SaleModel> sales = salesState.sales;
                            return Column(
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
                                    buildSalesByCategory(context),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SearchByWidget(
                                        listOfCategories:
                                            ProductModel.fieldStrings,
                                        withCategory: true,
                                        onSearchTextChanged: (String text) {},
                                        onChanged: (String category) {},
                                        onBothChanged: (cat, text) {},
                                      ),
                                      Flexible(
                                        flex: 1,
                                        child: ListView(
                                          children: [
                                            Text(
                                                '* tap to unsell a product'
                                                    .tr(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle2),
                                            SalesDataTable(
                                              sales: sales,
                                              products: productList,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      'Loading Sales ${salesState.status}'.tr(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline3!),
                                  const CircularProgressIndicator(),
                                ],
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  );
                });
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Loading Products ${productState.status}'.tr(),
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

  Padding buildSalesByCategory(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: BluredContainer(
        width: 420,
        height: 240,
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
                  DropDownButton(
                    dropDownItems: const ['All', 'Food', 'Drink', 'Other'],
                    onChanged: (value) {
                      log(value!.toString());
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Amount Sold'),
                        PriceNumberZone(
                          price: 2999,
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                          withDollarSign: true,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Quantity Sold'),
                        PriceNumberZone(
                          price: 2999,
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                          withDollarSign: true,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Profit'),
                        PriceNumberZone(
                          price: 2999,
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(
                                  color: Theme.of(context).colorScheme.primary),
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
  final List<SaleModel> sales;
  final List<ProductModel> products;
  const SalesDataTable({
    Key? key,
    required this.sales,
    required this.products,
  }) : super(key: key);

  @override
  State<SalesDataTable> createState() => _SalesDataTableState();
}

class _SalesDataTableState extends State<SalesDataTable> {
  late final SaleTableDataSource _data;

  int _sortColumnIndex = 0;
  bool _sortAscending = true;

  void sort<T>(Comparable<T> Function(SaleModel d) getField, int columnIndex,
      bool ascending) {
    _data.sort<T>(getField, ascending);
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  @override
  void initState() {
    _data = SaleTableDataSource(
      context,
      widget.sales,
      widget.products,
      onUnSellPressed: (SaleModel saleModel, ProductModel product) =>
          unSellProduct(context, saleModel, product),
      onEditPressed: (SaleModel saleModel) => editProduct(context, saleModel),
      onDeletePressed: (SaleModel saleModel) =>
          deleteProduct(context, saleModel),
    );
    GetIt.I.registerSingleton(_data);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PaginatedDataTable(
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
      source: _data,
    );
  }

  /// /////////////////////////////////////////////////////////////////////////////
  /// sell product dialog
  void unSellProduct(context, SaleModel saleModel, ProductModel product) {
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
              BlocProvider.of<SellActionsBloc>(context).add(UnsellingRequested(
                  saleModel: saleModel, productModel: product));
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
