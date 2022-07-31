import 'package:flutter/material.dart';

import '../../blocs/productbloc/product_bloc.dart';
import '../../blocs/sellactionsbloc/sellactions_bloc.dart';
import '../../components.dart';
import '../../local_components.dart';
import '../../utils/global_functions.dart';

import 'add_product.dart';
import 'prdc_dta_tbl.dart';
import 'stock_categories_piechart.dart';
import 'stock_inventory.dart';

class ProductList extends ConsumerWidget {
  const ProductList({
    Key? key,
    this.product,
  }) : super(key: key);
  final List<ProductModel>? product;

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
                  "Add Product",
                  style: Theme.of(context).textTheme.headline3!,
                ),
                contentWidget: const AddOrEditProduct(),
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

                if (state.status == ProductStatus.deleted) {
                  GlobalFunctions.showSuccessSnackBar(
                      context, 'Product deleted successfully'.tr());
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
                //log('loaded ${state.products.length}');
                var productList = state.products;
                FilteredProduct filteredProduct =
                    FilteredProduct(products: productList);
                ProductStockData productStockData =
                    ProductStockData(products: filteredProduct.products);

                return Builder(builder: (context) {
                  return SingleChildScrollView(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        children: [
                          Wrap(
                            spacing: 20,
                            runSpacing: 20,
                            children: [
                              const StockInventory(),
                              StockCategoriesPieChart(
                                // title: 'Products in stock',
                                data: productStockData.prdCatSumCnt,
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          const Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(20.0),
                              child: ProductsDataTable(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
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
