import 'package:flutter/material.dart';
import 'package:hanouty/local_components.dart';
import '../../blocs/debtbloc /debt_bloc.dart';
import '../../blocs/expensesbloc/expenses_bloc.dart';
import '../../blocs/fullsalesbloc/fullsales_bloc.dart';
import '../../blocs/incomebloc/income_bloc.dart';
import '../../blocs/paymentsbloc/payments_bloc.dart';
import '../../blocs/salesbloc/sales_bloc.dart';
import '../../components.dart';

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
        var incomeBloc = context.watch<IncomesBloc>().state;
        var expenseBloc = context.watch<ExpensesBloc>().state;
        var filteredDebts = FilteredDebts(debts: debtBloc.debts);
        var filteredIncome = FilteredIncomes(incomes: incomeBloc.incomes);
        var filteredExpense = FilteredExpenses(expenses: expenseBloc.expenses);
        var salesData = SalesData(sales: fullSalesBloc.fullSales);
        var incomeData = IncomeData(filteredIncome: filteredIncome.incomes);
        var expenseData = ExpenseData(expenses: filteredExpense.expenses);
        var debtData = DebtData(
            pymtsFrmDb: paymentsBloc.payments, dbtsFrmDb: filteredDebts.debts);
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
  final Revenu data;
  const RevenuRadialChart({
    Key? key,
    required this.data,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<ChartData> chartData = [
      ChartData(
        color: MThemeData.revenuColor,
        label: 'Revenu',
        value: data.totalRevenue,
      ),
      ChartData(
        color: MThemeData.expensesColor,
        label: 'Expense',
        value: data.expensesData!.totalExpensesAmount,
      ),
      ChartData(
        color: MThemeData.productColor,
        label: 'Debts',
        value: data.debtData!.totalDebtAmount,
      ),
      ChartData(
        color: MThemeData.incomeColor,
        label: 'Incomes',
        value: data.incomeData!.totalIncomeAmount,
      ),
      ChartData(
        color: MThemeData.profitColor,
        label: 'Profit',
        value: data.totalRevenue,
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
