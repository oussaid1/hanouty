import 'dart:developer';

import 'package:hanouty/widgets/charts/syncfusion_charts.dart';
import 'package:flutter/material.dart';

import 'package:hanouty/blocs/sellactionsbloc/sellactions_bloc.dart';
import 'package:hanouty/screens/sell/sell_product/sell_product_dialogue.dart';

import '../../blocs/productbloc/product_bloc.dart';
import '../../components.dart';
import '../../local_components.dart';
import '../../utils/global_functions.dart';
import '../../widgets/charts/inventory_widget.dart';
import '../../widgets/search_widget.dart';
import 'add_product/add_product.dart';

class ProductList extends ConsumerWidget {
  const ProductList({
    Key? key,
    this.product,
  }) : super(key: key);
  final List<ProductModel>? product;

  @override
  Widget build(BuildContext context, ref) {
    // List<TechService> techServicesList = ref.watch(techServicesProvider.state).state;
    // var prdBloc =
    //     ProductBloc(databaseOperations: GetIt.I<DatabaseOperations>());
    //  var sellActionsBloc = SellActionsBloc(GetIt.I<DatabaseOperations>());
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
                  "Add Product",
                  style: Theme.of(context).textTheme.headline3!,
                ),
                contentWidget: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  //  gradient: MThemeData.gradient2),
                  height: 500,
                  width: 420,
                  child: const AddOrEditProduct(),
                ),
              );
            },
            label: const Text("Add Product").tr(),
          ),
        ),
        body: MultiBlocListener(
          listeners: [
            BlocListener<ProductBloc, ProductState>(
              listener: (context, state) {
                if (state.status == ProductStatus.error) {
                  GlobalFunctions.showSuccessSnackBar(
                      context, 'Product added successfully'.tr());
                }
                if (state.status == ProductStatus.error) {
                  GlobalFunctions.showErrorSnackBar(
                      context, 'Error adding product'.tr());
                }

                if (state.status == ProductStatus.updated) {
                  GlobalFunctions.showSuccessSnackBar(
                      context, 'Product updated successfully'.tr());
                }
                if (state.status == ProductStatus.updating) {
                  GlobalFunctions.showErrorSnackBar(
                      context, 'Error updating product'.tr());
                }

                if (state.status == ProductStatus.deleted) {
                  GlobalFunctions.showSuccessSnackBar(
                      context, 'Product deleted successfully'.tr());
                }
                if (state.status == ProductStatus.deleting) {
                  GlobalFunctions.showErrorSnackBar(
                      context, 'Error deleting product'.tr());
                }
              },
            ),
            BlocListener<SellActionsBloc, SellActionsState>(
              listener: (context, state) {
                if (state is SellingSuccessfulState) {
                  GlobalFunctions.showSuccessSnackBar(
                      context, 'Successfully Sold '.tr());
                }

                if (state is SellingFailedState) {
                  GlobalFunctions.showErrorSnackBar(
                      context, 'Error selling product'.tr());
                }
              },
            ),
          ],
          child: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state.status == ProductStatus.loaded) {
                var productList = state.products;
                FilteredProduct filteredProduct = FilteredProduct(
                  products: productList,
                );
                ProductStockData productStockData =
                    ProductStockData(products: filteredProduct.products);

                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      GlassContainer(
                        child: Wrap(
                          spacing: 20,
                          children: [
                            const MyInventoryWidgetNoBlurr(),
                            PieChartCard(
                              // title: 'Products in stock',
                              data: productStockData.productCategorySumCounts,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: Column(
                          children: [
                            SearchByWidget(
                              listOfCategories: ProductModel.fieldStrings,
                              withCategory: true,
                              onSearchTextChanged: (String text) {},
                              onChanged: (String category) {},
                              onBothChanged: (String category, String text) {
                                log(category);
                                log(text);
                                GetIt.I<ProductTableDataSource>()
                                    .filterByCategory(category, text);
                              },
                            ),
                            Expanded(
                              child: ListView(
                                children: [
                                  Text('* tap to sell',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2),
                                  ProductsDataTable(
                                    products: productList,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Expanded(
                      //   child: ProductListView(
                      //       productsList: filteredProduct.products),
                      // ),
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ));
  }
}

class ProductsDataTable extends StatefulWidget {
  final List<ProductModel> products;
  const ProductsDataTable({
    Key? key,
    required this.products,
  }) : super(key: key);

  @override
  State<ProductsDataTable> createState() => _ProductsDataTableState();
}

class _ProductsDataTableState extends State<ProductsDataTable> {
  late final ProductTableDataSource _data;

  int _sortColumnIndex = 0;
  bool _sortAscending = true;

  void sort<T>(Comparable<T> Function(ProductModel d) getField, int columnIndex,
      bool ascending) {
    _data.sort<T>(getField, ascending);
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  @override
  void initState() {
    _data = ProductTableDataSource(
      context,
      widget.products,
      onSellPressed: (ProductModel product) => sellProduct(context, product),
      onEditPressed: (ProductModel product) => editProduct(context, product),
      onDeletePressed: (ProductModel product) =>
          deleteProduct(context, product),
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
          label: Text('Sell'),
          tooltip: 'Sell',
        ),
        // DataColumn(
        //   label: Text('Barcode'),
        //   tooltip: 'Barcode',
        // ),
        DataColumn(
            label: const Text('Product Name'),
            tooltip: 'Product Name',
            onSort: (int columnIndex, bool ascending) {
              sort<String>(
                  (ProductModel d) => d.productName, columnIndex, ascending);
            }),
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
  void sellProduct(context, ProductModel product) {
    MDialogs.dialogSimple(
      context,
      title: Text(
        "Sell Product",
        style: Theme.of(context).textTheme.headline3!,
      ),
      contentWidget: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
        ),
        //  gradient: MThemeData.gradient2),
        height: 500,
        width: 420,
        child: SellProductDialoge(
          product: product,
        ),
      ),
    );
  }

  /// /////////////////////////////////////////////////////////////////////////////
  /// edit product dialog
  void editProduct(context, ProductModel product) {
    MDialogs.dialogSimple(
      context,
      title: Text(
        "Edit product".tr(),
        style: Theme.of(context).textTheme.headline3!,
      ),
      contentWidget: SizedBox(
        height: 400,
        width: 400,
        child: AddOrEditProduct(
          product: product,
          initialDateTime: product.dateIn,
          initialValue: product.quantity,
        ),
      ),
    );
  }

  /// /////////////////////////////////////////////////////////////////////////////
  /// delete product dialog
  void deleteProduct(context, ProductModel product) {
    MDialogs.dialogSimple(
      context,
      title: Text(
        " ${product.productName}",
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
              BlocProvider.of<ProductBloc>(context)
                  .add(DeleteProductEvent(product));
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
