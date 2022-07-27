import 'package:flutter/material.dart';
import 'package:hanouty/extensions/extensions.dart';

import '../../components.dart';
import '../../models/chart_data.dart';
import '../../models/debt/debtsviewmodel.dart';
import '../../utils/glasswidgets.dart';

class DebtPieChart extends StatelessWidget {
  final DebtsStatsViewModel data;
  const DebtPieChart({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BluredContainer(
        width: 420,
        height: 270,
        child: Column(
          children: [
            SizedBox(
              height: 40,
              width: 420,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Debts',
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(color: context.theme.primary),
                  ),
                ],
              ),
            ),
            Expanded(
                child: SfCircularChart(
              backgroundColor: Colors.transparent,
              legend: Legend(
                  isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <DoughnutSeries<ChartData, String>>[
                DoughnutSeries<ChartData, String>(
                    radius: '80%',
                    explode: true,
                    explodeOffset: '20%',
                    dataSource: data.clientDebtTotal,
                    xValueMapper: (ChartData data, _) => data.label as String,
                    yValueMapper: (ChartData data, _) => data.value,
                    dataLabelMapper: (ChartData data, _) => data.label,
                    dataLabelSettings: const DataLabelSettings(
                      isVisible: false,
                      alignment: ChartAlignment.far,
                      angle: -45,
                    ))
              ],
            )),
          ],
        ));
  }
}
