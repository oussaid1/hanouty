import 'package:flutter/material.dart';
import 'package:hanouty/local_components.dart';
import '../../blocs/debtbloc /debt_bloc.dart';
import '../../blocs/expensesbloc/expenses_bloc.dart';
import '../../blocs/fullsalesbloc/fullsales_bloc.dart';
import '../../blocs/incomebloc/income_bloc.dart';
import '../../blocs/paymentsbloc/payments_bloc.dart';
import '../../blocs/salesbloc/sales_bloc.dart';
import '../../components.dart';
import '../../widgets/cards/latest_trans_list_card.dart';
import '../../widgets/cards/scares_products_instock.dart';
import '../../widgets/charts/inventory_widget.dart';
import '../add_tostock/addstuff_fab.dart';

class DashBoardPage extends StatelessWidget {
  const DashBoardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: const Padding(
        padding: EdgeInsets.only(bottom: 80.0),
        child: SizedBox(
          width: 120,
          child: AddStuffWidget(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 20,
                direction: Axis.horizontal,
                alignment: WrapAlignment.spaceBetween,
                runSpacing: 20,
                children: const [
                  SalesOverAllWidget(),
                  StockInventory(),
                  SizedBox(height: 20),
                  RevenuWidget(),
                ],
              ),
              const SizedBox(height: 40),
              Wrap(
                spacing: 20,
                direction: Axis.horizontal,
                alignment: WrapAlignment.spaceBetween,
                children: [
                  const DashboardCharts(),
                  Wrap(
                    direction: Axis.vertical,
                    children: const [
                      ScaresProductslistCard(),
                      SizedBox(height: 20),
                      LatestTransactionsListCard(),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardBarChart extends StatelessWidget {
  final List<ChartData> data;
  final String? title;
  const DashboardBarChart({
    Key? key,
    required this.data,
    this.title,
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
            primaryXAxis: DateTimeAxis(
              majorGridLines: const MajorGridLines(width: 0),
              intervalType: DateTimeIntervalType.days,
              dateFormat: DateFormat.MMMd(),
              interval: 1,
              axisLine: const AxisLine(width: 0.5),
              //labelFormat: 'dd/MM',
              edgeLabelPlacement: EdgeLabelPlacement.shift,
              labelStyle: Theme.of(context).textTheme.subtitle2!,
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
              ColumnSeries<ChartData, DateTime>(
                  name: 'Services'.tr(),
                  color: MThemeData.productColor,
                  dataSource: [],
                  xValueMapper: (ChartData sales, _) => (sales.date),
                  yValueMapper: (ChartData sales, z) => sales.value),
              ColumnSeries<ChartData, DateTime>(
                  name: 'Products',
                  color: MThemeData.serviceColor,
                  dataSource: [],
                  xValueMapper: (ChartData sales, _) => sales.date,
                  yValueMapper: (ChartData sales, _) => sales.value),
              ColumnSeries<ChartData, DateTime>(
                  name: 'Sales',
                  color: MThemeData.expensesColor,
                  dataSource: [],
                  xValueMapper: (ChartData sales, _) => sales.date,
                  yValueMapper: (ChartData sales, _) => sales.value),
            ],
          ),
        ),
      ],
    );
  }
}

class DashboardLineChart extends StatelessWidget {
  final List<ChartData> data;
  final String? title;
  const DashboardLineChart({
    Key? key,
    required this.data,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 2,
          fit: FlexFit.tight,
          child: SfCartesianChart(
            backgroundColor: Colors.transparent,
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
            primaryXAxis: DateTimeAxis(
              majorGridLines: const MajorGridLines(width: 0),
              intervalType: DateTimeIntervalType.days,
              dateFormat: DateFormat.MMMd(),
              interval: 1,
              axisLine: const AxisLine(width: 0.5),
              //labelFormat: 'dd/MM',
              edgeLabelPlacement: EdgeLabelPlacement.shift,
              labelStyle: Theme.of(context).textTheme.subtitle2!,
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
              SplineSeries<ChartData, DateTime>(
                  name: 'Sales'.tr(),
                  color: MThemeData.salesColor,
                  dataSource: const [],
                  xValueMapper: (ChartData sales, _) => sales.date,
                  yValueMapper: (ChartData sales, _) => sales.value),
              SplineSeries<ChartData, DateTime>(
                  name: 'Products'.tr(),
                  color: MThemeData.productColor,
                  dataSource: [],
                  xValueMapper: (ChartData sales, _) => sales.date,
                  yValueMapper: (ChartData sales, _) => sales.value),
              SplineSeries<ChartData, DateTime>(
                  name: 'Services'.tr(),
                  color: MThemeData.serviceColor,
                  dataSource: const [],
                  xValueMapper: (ChartData sales, _) => sales.date,
                  yValueMapper: (ChartData sales, _) => sales.value),
            ],
          ),
        ),
      ],
    );
  }
}

// class AddStuffWidget extends StatelessWidget {
//   const AddStuffWidget({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         buildExpandedFab(context,
//             title: "Client",
//             child: AddClient(
//               pContext: context,
//             )),
//         const SizedBox(height: 10),
//         // buildExpandedFab(context,title: "Add Supplier",child: const AddSuplier()),
//         // const SizedBox(height: 10),
//         buildExpandedFab(context,
//             title: "Product", child: const AddOrEditProduct()),
//         const SizedBox(height: 10),
//         buildExpandedFab(context, title: "Service", child: const AddService()),
//         const SizedBox(height: 10),
//         buildExpandedFab(context, title: "Add Debt", child: const AddDebt()),
//         const SizedBox(height: 10),
//         buildExpandedFab(context, title: "Expense", child: const AddExpense()),
//         const SizedBox(height: 10),
//         buildExpandedFab(context,
//             title: "Sale", child: const AddOrEditSaleWidget()),
//         const SizedBox(height: 10),
//         buildExpandedFab(context, title: "Income", child: const AddIncome()),
//       ],
//     );
//   }

//   FloatingActionButton buildExpandedFab(BuildContext context,
//       {String? title, Widget? child}) {
//     return FloatingActionButton.extended(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(50),
//       ),
//       extendedIconLabelSpacing: 0,
//       onPressed: () {
//         MDialogs.dialogSimple(
//           context,
//           title: Text(
//             title ?? '',
//             style: Theme.of(context).textTheme.headline3!,
//           ),
//           contentWidget: SizedBox(
//             // height: 400,
//             width: 410,
//             child: SingleChildScrollView(
//                 child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 child ?? const SizedBox.shrink(),
//               ],
//             )),
//           ),
//         );
//       },
//       label: SizedBox(
//         width: 100,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Icon(Icons.add, size: 18),
//             const SizedBox(width: 5),
//             Text(title ?? '',
//                 style: Theme.of(context).textTheme.headline3!.copyWith(
//                       fontSize: 12,
//                       fontWeight: FontWeight.bold,
//                     )),
//           ],
//         ),
//       ),
//     );
//   }
// }

class DashboardCharts extends StatelessWidget {
  const DashboardCharts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FullSalesBloc, FullSalesState>(
      builder: (context, state) {
        SalesData salesData = SalesData(sales: state.fullSales);
        return Wrap(
          spacing: 20,
          direction: Axis.horizontal,
          alignment: WrapAlignment.spaceBetween,
          children: [
            BluredContainer(
                width: 420,
                height: 400,
                child: DashboardLineChart(
                  data: salesData.chartDataDDMMYY,
                  title: 'Inventory',
                )),
            BluredContainer(
              width: 420,
              height: 400,
              child: DashboardBarChart(
                data: salesData.chartDataDDMMYY,
                title: 'Sales',
              ),
            ),
          ],
        );
      },
    );
  }
}

class RevenuWidget extends StatelessWidget {
  const RevenuWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SalesBloc, SalesState>(
      builder: (context, state) {
        var debtBloc = context.watch<DebtBloc>().state;
        var paymentsBloc = context.watch<PaymentsBloc>().state;
        var fullSalesBloc = context.watch<FullSalesBloc>().state;
        var incomeBloc = context.watch<IncomeBloc>().state;
        var expenseBloc = context.watch<ExpenseBloc>().state;
        var filteredDebts = FilteredDebts(debts: debtBloc.debts);
        var filteredIncome = FilteredIncomes(incomes: incomeBloc.incomes);
        var filteredExpense = FilteredExpenses(expenses: expenseBloc.expenses);
        var salesData = SalesData(sales: fullSalesBloc.fullSales);
        var incomeData = IncomeData(filteredIncome: filteredIncome.incomes);
        var expenseData = ExpenseData(expenses: filteredExpense.expenses);
        var debtData = DebtData(
            allpayments: paymentsBloc.payments, allDebts: filteredDebts.debts);
        Revenu revenu = Revenu(
          debtData: debtData,
          salesData: salesData,
          incomeData: incomeData,
          expensesData: expenseData,
        );
        return BluredContainer(
          width: 420,
          height: 200,
          child: RevenuRadialChart(
            data: revenu,
          ),
        );
      },
    );
  }
}

class RevenuRadialChart extends StatelessWidget {
  final Revenu? data;
  const RevenuRadialChart({
    Key? key,
    this.data,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<ChartData> chartData = [
      ChartData(
        color: MThemeData.revenuColor,
        label: 'Revenu',
        value: 4530,
      ),
      ChartData(
        color: MThemeData.expensesColor,
        label: 'Expense',
        value: 535,
      ),
      ChartData(
        color: MThemeData.productColor,
        label: 'Debts',
        value: 6678,
      ),
      ChartData(
        color: MThemeData.incomeColor,
        label: 'Incomes',
        value: 700,
      ),
      ChartData(
        color: MThemeData.profitColor,
        label: 'Profit',
        value: 4560,
      ),
    ];

    return Material(
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              fit: StackFit.passthrough,
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                      // color: Color.fromARGB(137, 255, 245, 231),
                      height: 160,
                      child: SfCircularChart(
                        centerX: '90',
                        series: [
                          RadialBarSeries<ChartData, String>(
                            animationDuration: 0,
                            radius: '110%',
                            gap: '12%',
                            //  trackColor: Theme.of(context).colorScheme.background,
                            innerRadius: '20%',
                            animationDelay: 200,
                            dataLabelSettings: DataLabelSettings(
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                isVisible: false,
                                labelPosition: ChartDataLabelPosition.inside),
                            dataSource: chartData,
                            cornerStyle: CornerStyle.bothCurve,
                            xValueMapper: (ChartData data, _) => data.label,
                            // '${data.label} : ${data.value!.toPrecision()}',
                            yValueMapper: (ChartData data, _) => data.value,
                            pointColorMapper: (ChartData data, _) => data.color,
                            dataLabelMapper: (ChartData data, _) =>
                                data.value!.toPrecision(2).toString(),
                          )
                        ],
                        tooltipBehavior: TooltipBehavior(enable: true),
                      )),
                ),
                Positioned(
                  right: 15,
                  height: 200,
                  width: 180,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildLegendItem(context,
                          color: chartData[0].color!,
                          label: chartData[0].label!,
                          value: chartData[0].value!.toPrecision(2)),
                      _buildLegendItem(context,
                          color: chartData[1].color!,
                          label: chartData[1].label!,
                          value: chartData[1].value!.toPrecision(2)),
                      _buildLegendItem(context,
                          color: chartData[2].color!,
                          label: chartData[2].label!,
                          value: chartData[2].value!.toPrecision(2)),
                      _buildLegendItem(context,
                          color: chartData[3].color!,
                          label: chartData[3].label!,
                          value: chartData[3].value!.toPrecision(2)),
                      _buildLegendItem(context,
                          color: chartData[4].color!,
                          label: chartData[4].label!,
                          value: chartData[4].value!.toPrecision(2)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  _buildLegendItem(BuildContext context,
      {required String label, required Color color, required double value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 4),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(label,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(color: color)),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text('$value',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle2!),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
