import 'dart:developer';

import 'package:flutter/material.dart';

import '../../blocs/fullsalesbloc/fullsales_bloc.dart';
import '../../blocs/sellactionsbloc/sellactions_bloc.dart';
import '../../components.dart';
import '../../local_components.dart';
import '../../widgets/search_widget.dart';
import 'edit_sale.dart';

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
          // onDeletePressed: (SaleModel saleModel) =>
          //     deleteProduct(context, saleModel),
        );
        return SingleChildScrollView(
          child: Column(
            children: [
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
                      dividerColor: Color.fromARGB(54, 106, 106, 106),
                      cardColor: Color.fromARGB(0, 255, 255, 255)),
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
                      DataColumn(
                        numeric: true,
                        label: const Text('Qnt'),
                        tooltip: 'Quantity Sold',
                        onSort: (columnIndex, ascending) => sort(
                          (SaleModel d) => d.quantitySold,
                          columnIndex,
                          ascending,
                        ),
                      ),
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
                        numeric: true,
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
      contentWidget: AddOrEditSaleWidget(
        sale: saleModel,
        initialDate: saleModel.dateSold,
        initialQuantity: saleModel.quantitySold,
      ),
    );
  }

  // /// /////////////////////////////////////////////////////////////////////////////
  // /// delete product dialog
  // void deleteProduct(context, SaleModel saleModel) {
  //   MDialogs.dialogSimple(
  //     context,
  //     title: Text(
  //       " ${saleModel.productName}",
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
  //             BlocProvider.of<SalesBloc>(context)
  //                 .add(DeleteSalesEvent(saleModel));
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
