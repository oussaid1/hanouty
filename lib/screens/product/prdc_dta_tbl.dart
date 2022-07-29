import 'package:flutter/material.dart';
import '../../blocs/clientsbloc/clients_bloc.dart';
import '../../blocs/productbloc/product_bloc.dart';
import '../../blocs/salesbloc/sales_bloc.dart';
import '../../components.dart';
import '../../database/database_operations.dart';
import '../../local_components.dart';
import '../../widgets/search_widget.dart';
import '../sell/sell_product_dialogue.dart';
import 'add_product.dart';

class ProductsDataTable extends StatefulWidget {
  //final List<ProductModel> products;
  const ProductsDataTable({
    Key? key,
    //required this.products,
  }) : super(key: key);

  @override
  State<ProductsDataTable> createState() => _ProductsDataTableState();
}

class _ProductsDataTableState extends State<ProductsDataTable> {
  ProductTableDataSource? _data;

  int _sortColumnIndex = 0;
  bool _sortAscending = true;

  void sort<T>(Comparable<T> Function(ProductModel d) getField, int columnIndex,
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
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        _data = ProductTableDataSource(
          context,
          state.products,
          onSellPressed: (ProductModel product) => sellProduct(
              context, product, context.read<SalesBloc>().state.sales),
          onEditPressed: (ProductModel product) =>
              editProduct(context, product),
          // onDeletePressed: (ProductModel product) =>
          //     deleteProduct(context, product),
        );
        return SingleChildScrollView(
          child: Column(
            children: [
              Text('* tap to sell',
                  style: Theme.of(context).textTheme.subtitle2),
              SearchByWidget(
                listOfCategories: ProductModel.fieldStrings,
                withCategory: true,
                onSearchTextChanged: (String text) {},
                onBothChanged: (String category, String text) {
                  _data!.filterByCategory(category, text);
                },
              ),
              BluredContainer(
                width: context.width,
                height: 800,
                child: Theme(
                  data: Theme.of(context).copyWith(
                      dividerColor: const Color.fromARGB(54, 0, 0, 0),
                      cardColor: const Color.fromARGB(42, 0, 240, 172)),
                  child: PaginatedDataTable(
                    sortColumnIndex: _sortColumnIndex,
                    sortAscending: _sortAscending,
                    showCheckboxColumn: false,
                    // columnSpacing: 10,
                    // checkboxHorizontalMargin: 4,
                    // horizontalMargin: 4,
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
                            sort<String>((ProductModel d) => d.productName,
                                columnIndex, ascending);
                          }),
                      DataColumn(
                          numeric: true,
                          label: const Text('Qnt'),
                          tooltip: 'Quantity',
                          onSort: (int columnIndex, bool ascending) {
                            sort<String>((ProductModel d) => d.productName,
                                columnIndex, ascending);
                          }),
                      const DataColumn(
                        numeric: true,
                        label: Text('Price In'),
                        tooltip: 'Price In',
                      ),
                      const DataColumn(
                        numeric: true,
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
                      // const DataColumn(
                      //   label: Text('Delete'),
                      //   tooltip: 'Delete',
                      // ),
                    ],
                    source: _data!,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// /////////////////////////////////////////////////////////////////////////////
  /// sell product dialog
  void sellProduct(context, ProductModel product, List<SaleModel> sales) {
    // List<String> distinctSaleClients =
    //     FilteredSales(sales: sales).distinctCilentNames;
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
        child: BlocProvider(
          create: (context) => ShopClientBloc(
              databaseOperations: GetIt.I.get<DatabaseOperations>()),
          child: SellProductDialoge(
            product: product,
            saleType: SaleType.product,
          ),
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
      contentWidget: AddOrEditProduct(
        product: product,
        initialDateTime: product.dateIn,
        initialValue: product.quantity,
      ),
    );
  }

  // /// /////////////////////////////////////////////////////////////////////////////
  // /// delete product dialog
  // void deleteProduct(context, ProductModel product) {
  //   MDialogs.dialogSimple(
  //     context,
  //     title: Text(
  //       " ${product.productName}",
  //       style: Theme.of(context).textTheme.headline3!,
  //     ),
  //     contentWidget: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //       children: [
  //         ElevatedButton(
  //           style: MThemeData.raisedButtonStyleSave,
  //           child: Text(
  //             'Delete'.tr(),
  //             style: Theme.of(context).textTheme.bodyText1!,
  //           ),
  //           onPressed: () {
  //             BlocProvider.of<ProductBloc>(context)
  //                 .add(DeleteProductEvent(product));
  //             Navigator.pop(context);
  //           },
  //         ),
  //         ElevatedButton(
  //           style: MThemeData.raisedButtonStyleCancel,
  //           child: Text(
  //             'Cancel'.tr(),
  //             style: Theme.of(context).textTheme.bodyText1!,
  //           ),
  //           onPressed: () {
  //             Navigator.pop(context);
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
