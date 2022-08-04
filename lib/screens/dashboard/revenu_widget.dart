import 'package:flutter/material.dart';
import 'package:hanouty/local_components.dart';
import 'package:hanouty/models/Sale/sales_calculations.dart';
import '../../blocs/debtbloc /debt_bloc.dart';
import '../../blocs/expensesbloc/expenses_bloc.dart';
import '../../blocs/fullsalesbloc/fullsales_bloc.dart';
import '../../blocs/incomebloc/income_bloc.dart';
import '../../blocs/paymentsbloc/payments_bloc.dart';
import '../../blocs/rechargebloc/fullrechargesales_bloc.dart';
import '../../blocs/salesbloc/sales_bloc.dart';
import '../../components.dart';
import '../../models/recharge/recharge_sales_data.dart';

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
        var rechargeBloc = context.watch<RechargeBloc>().state;
        var filteredDebts = FilteredDebts(debts: debtBloc.debts);
        var filteredIncome = FilteredIncomes(incomes: incomeBloc.incomes);
        var filteredExpense = FilteredExpenses(expenses: expenseBloc.expenses);
        //var salesData = SalesData(sales: fullSalesBloc.fullSales);
        var rechargeSalesData = RechargeSalesData(
          rechargeSalesList: rechargeBloc.rechargeSalesList,
        );
        var salesCalculs = SaleCalculations(sales: fullSalesBloc.fullSales);
        var incomeData = IncomeData(filteredIncome: filteredIncome.incomes);
        var expenseData = ExpenseData(expenses: filteredExpense.expenses);
        var debtData = DebtData(
            pymtsFrmDb: paymentsBloc.payments, dbtsFrmDb: filteredDebts.debts);
        Revenu revenu = Revenu(
          debtData: debtData,
          salesData: salesCalculs,
          incomeData: incomeData,
          expensesData: expenseData,
          rechargeSalesData: rechargeSalesData,
        );
        return BluredContainer(
          width: 420,
          height: 200,
          child: RevenuRadialChart(
            title: 'Revenu',
            data: revenu,
          ),
        );
      },
    );
  }
}

class RevenuRadialChart extends StatelessWidget {
  final String title;
  final Revenu data;
  const RevenuRadialChart({
    Key? key,
    required this.title,
    required this.data,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<ChartData> chartData = [
      ChartData(
        color: MThemeData.expensesColor,
        label: 'Expense',
        value: data.expensesData!.totalExpensesAmount,
      ),
      ChartData(
        color: const Color.fromARGB(255, 16, 182, 247),
        label: 'Recharge',
        value: 6885,
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
        label: 'Sales',
        value: data.totalRevenue,
      ),
      ChartData(
        color: MThemeData.revenuColor,
        label: 'Revenu',
        value: data.totalRevenue,
      ),
    ];

    return Material(
        color: Colors.transparent,
        child: BluredContainer(
          child: Column(
            // fit: StackFit.expand,
            // alignment: Alignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  // color: Color.fromARGB(137, 255, 245, 231),
                  height: 290,
                  child: SfCircularChart(
                    title: ChartTitle(
                      text: title,
                      textStyle: Theme.of(context).textTheme.labelMedium,
                    ),
                    legend: Legend(
                      isVisible: true,
                      overflowMode: LegendItemOverflowMode.wrap,
                      position: LegendPosition.right,
                      //height: '50%',
                      legendItemBuilder:
                          (legendText, series, point, seriesIndex) {
                        return SizedBox(
                            height: 27,
                            //width: 84,
                            child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Icon(
                                    Icons.bar_chart_rounded,
                                    size: 16,
                                    color: chartData[seriesIndex].color,
                                  ),
                                  Text(
                                    legendText,
                                    style:
                                        Theme.of(context).textTheme.subtitle2!,
                                  ),
                                ]));
                      },
                      alignment: ChartAlignment.center,
                      textStyle: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(
                              fontSize: 12, color: MThemeData.secondaryColor),
                    ),
                    centerX: '120',
                    series: [
                      RadialBarSeries<ChartData, String>(
                        animationDuration: 0,
                        radius: '100%',
                        gap: '9%',
                        //trackColor: Theme.of(context).colorScheme.background,
                        innerRadius: '20%',
                        animationDelay: 200,
                        dataLabelSettings: DataLabelSettings(
                            textStyle: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                            isVisible: true,
                            labelPosition: ChartDataLabelPosition.inside),
                        dataSource: chartData,

                        cornerStyle: CornerStyle.bothCurve,
                        xValueMapper: (ChartData data, _) => data.label,
                        // '${data.label} : ${data.value!.toPrecision()}',
                        yValueMapper: (ChartData data, _) => data.value,
                        pointColorMapper: (ChartData data, _) => data.color,
                        dataLabelMapper: (ChartData data, _) =>
                            data.value!.toString(),
                      )
                    ],
                    tooltipBehavior: TooltipBehavior(enable: true),
                  )),
            ],
          ),
        ));
  }

  _buildLegendItem(BuildContext context,
      {required String label, required Color color, required num value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
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
          ),
          // Row(
          //   children: [
          //     PriceNumberZone(
          //       withDollarSign: true,
          //       right: const SizedBox.shrink(),
          //       price: value,
          //       // priceStyle: Theme.of(context).textTheme.caption!.copyWith(
          //       //     // color: AppConstants.whiteOpacity,
          //       //     ),
          //       priceStyle: Theme.of(context)
          //           .textTheme
          //           .headline6!
          //           .copyWith(color: color),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
