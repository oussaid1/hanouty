import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hanouty/blocs/filteredsalesbloc/filteredsales_bloc.dart';
import 'package:hanouty/local_components.dart';

import '../../blocs/clientsbloc/clients_bloc.dart';
import '../../blocs/debtbloc /debt_bloc.dart';
import '../../blocs/expensesbloc/expenses_bloc.dart';
import '../../blocs/fullsalesbloc/fullsales_bloc.dart';
import '../../blocs/incomebloc/income_bloc.dart';
import '../../blocs/paymentsbloc/payments_bloc.dart';
import '../../blocs/productbloc/product_bloc.dart';
import '../../blocs/salesbloc/sales_bloc.dart';
import '../../components.dart';
import '../../models/Sale/sale.dart';
import '../../models/chart_data.dart';
import '../../models/debt/debt.dart';
import '../../models/expenses/expenses.dart';
import '../../models/income/income.dart';
import '../../models/product/product.dart';
import '../../models/revenu/revenu.dart';
import '../../settings/themes.dart';
import '../../utils/glasswidgets.dart';
import '../../utils/popup_dialogues.dart';
import '../../widgets/cards/latest_trans_list_card.dart';
import '../../widgets/cards/scares_productss_instock.dart';
import '../../widgets/charts/inventory_widget.dart';
import '../../widgets/charts/syncfusion_charts.dart';
import '../client/add_clients/add_client.dart';
import '../product/add_product/add_product.dart';
import '../suplier/add_suplier/add_suplier.dart';
import '../techservice/add_service/add_service.dart';

class DashBoardPage extends StatelessWidget {
  const DashBoardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // log('fullSalesBloc.state.fullSales: ${fullSalesBloc.fullSales.length}');
    // log('filterType: $filterType');
    // log('productBloc: ${productBloc.products.length}');
    // log('clientsBloc: ${clientsBloc.clients.length}');
    // log('clientsBloc: ${productBloc.status}');
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: const Padding(
        padding: EdgeInsets.only(bottom: 80.0),
        child: AddStuffWidget(),
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
                  MyInventoryWidget(),
                  MySalesWidgetBlurred(),
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
                  const BluredContainer(
                      width: 420,
                      height: 400,
                      child: LineChartCard(data: [], title: 'Inventory')),
                  const BluredContainer(
                    width: 420,
                    height: 400,
                    child: BarChartCard(
                      data: [],
                      title: 'Sales',
                    ),
                  ),
                  const SizedBox(width: 2),
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

class AddStuffWidget extends StatelessWidget {
  const AddStuffWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton.extended(
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
        const SizedBox(height: 10),
        FloatingActionButton.extended(
          icon: const Icon(Icons.add),
          onPressed: () {
            MDialogs.dialogSimple(
              context,
              title: Text(
                "Add Service",
                style: Theme.of(context).textTheme.headline3!,
              ),
              contentWidget: const AddService(),
            );
          },
          label: const Text("Add Service").tr(),
        ),
        const SizedBox(height: 10),
        FloatingActionButton.extended(
          icon: const Icon(Icons.add),
          onPressed: () {
            MDialogs.dialogSimple(
              context,
              title: Text(
                "Add Client",
                style: Theme.of(context).textTheme.headline3!,
              ),
              contentWidget: AddClient(
                pContext: context,
              ),
            );
          },
          label: const Text("Add Client").tr(),
        ),
        const SizedBox(height: 10),
        FloatingActionButton.extended(
          icon: const Icon(Icons.add),
          onPressed: () {
            MDialogs.dialogSimple(
              context,
              title: Text(
                "Add Suplier",
                style: Theme.of(context).textTheme.headline3!,
              ),
              contentWidget: const SizedBox(
                height: 400,
                width: 400,
                child: AddSuplier(),
              ),
            );
          },
          label: const Text("Add Suplier").tr(),
        ),
      ],
    );
  }
}

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
                child: LineChartCard(
                  data: salesData.chartDataDDMMYY,
                  title: 'Inventory',
                )),
            BluredContainer(
              width: 420,
              height: 400,
              child: BarChartCard(
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
          height: 400,
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
        child: BluredContainer(
          child: Column(
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
                              pointColorMapper: (ChartData data, _) =>
                                  data.color,
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
          ),
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
