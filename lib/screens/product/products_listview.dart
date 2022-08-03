import 'package:flutter/material.dart';
import 'package:hanouty/models/product/tagged_products.dart';

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
                if (state.status == SellActionsStatus.sold) {
                  GlobalFunctions.showSuccessSnackBar(
                      context, 'Successfully Sold '.tr());
                }

                if (state.status == SellActionsStatus.error) {
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
                                data: productStockData.productDataByCategory,
                              ),
                              BluredContainer(
                                width: 420,
                                height: 300,
                                child: BySuplierBarChart(
                                    title: 'Products by Supplier',
                                    data:
                                        productStockData.productDataByCategory),
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

class BySuplierBarChart extends StatelessWidget {
  final List<TaggedProducts> data;
  final String title;
  const BySuplierBarChart({
    Key? key,
    required this.data,
    required this.title,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          fit: FlexFit.tight,
          flex: 1,
          child: SfCartesianChart(
            borderWidth: 0,
            legend: Legend(
              isVisible: true,
              overflowMode: LegendItemOverflowMode.wrap,
              position: LegendPosition.top,
              height: '50%',
              legendItemBuilder: (legendText, series, point, seriesIndex) {
                return SizedBox(
                    height: 16,
                    width: 80,
                    child: Row(children: <Widget>[
                      Icon(Icons.bar_chart_rounded,
                          size: 16, color: series.color),
                      Text(
                        legendText,
                        style: Theme.of(context).textTheme.subtitle2!,
                      ),
                    ]));
              },
              alignment: ChartAlignment.center,
              textStyle: Theme.of(context)
                  .textTheme
                  .subtitle2!
                  .copyWith(fontSize: 12, color: MThemeData.secondaryColor),
            ),
            annotations: const <CartesianChartAnnotation>[
              CartesianChartAnnotation(
                  widget: SizedBox(child: Text('Empty data')),
                  coordinateUnit: CoordinateUnit.point,
                  region: AnnotationRegion.plotArea,
                  x: 3.5,
                  y: 60),
            ],
            // primaryXAxis: DateTimeAxis(
            //   majorGridLines: const MajorGridLines(width: 0),
            //   intervalType: DateTimeIntervalType.days,
            //   dateFormat: DateFormat.MMMd(),
            //   interval: 1,
            //   axisLine: const AxisLine(width: 0.5),
            //   //labelFormat: 'dd/MM',
            //   edgeLabelPlacement: EdgeLabelPlacement.shift,
            //   labelStyle: Theme.of(context).textTheme.subtitle2!,
            // ),
            primaryXAxis: CategoryAxis(
              majorGridLines: const MajorGridLines(width: 0),
              labelRotation: 0,
              labelStyle: Theme.of(context).textTheme.subtitle2!,
              majorTickLines: const MajorTickLines(width: 0),
              minorGridLines: const MinorGridLines(width: 0),
              minorTickLines: const MinorTickLines(width: 0),
            ),
            enableAxisAnimation: true,
            plotAreaBorderColor: Colors.transparent,
            plotAreaBorderWidth: 0,
            plotAreaBackgroundColor: Colors.transparent,
            primaryYAxis: NumericAxis(
              minimum: 0,
              labelRotation: 0,
              labelStyle: Theme.of(context).textTheme.subtitle2!,
              majorGridLines: const MajorGridLines(width: 0),
              majorTickLines: const MajorTickLines(width: 0),
              minorGridLines: const MinorGridLines(width: 0),
              minorTickLines: const MinorTickLines(width: 0),
            ),
            series: <ChartSeries>[
              // Renders spline chart
              ColumnSeries<TaggedProducts, String>(
                  name: 'Services'.tr(),
                  // color: MThemeData.productColor,
                  dataSource: data,
                  xValueMapper: (TaggedProducts products, _) => (products.tag),
                  yValueMapper: (TaggedProducts products, z) =>
                      products.productsData.totalCapitalInStock),
              // ColumnSeries<TaggedProducts, DateTime>(
              //     name: 'Products',
              //     color: MThemeData.serviceColor,
              //     dataSource: [],
              //     xValueMapper: (TaggedProducts products, _) => products.date,
              //     yValueMapper: (TaggedProducts products, _) => products.value),
              // ColumnSeries<TaggedProducts, DateTime>(
              //     name: 'products',
              //     color: MThemeData.expensesColor,
              //     dataSource: [],
              //     xValueMapper: (TaggedProducts products, _) => products.date,
              //     yValueMapper: (TaggedProducts products, _) => products.value),
            ],
          ),
        ),
      ],
    );
  }
}
