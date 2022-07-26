import 'package:flutter/material.dart';

import '../../components.dart';
import '../../models/chart_data.dart';
import '../../models/debt/debt.dart';
import '../../settings/themes.dart';
import '../../utils/glasswidgets.dart';

class DebtLineChart extends StatelessWidget {
  final DebtData data;
  const DebtLineChart({
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
            Expanded(
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
                      name: 'Debts'.tr(),
                      color: MThemeData.salesColor,
                      dataSource: data.debtsChartDataDDMMYY,
                      xValueMapper: (ChartData sales, _) => sales.date,
                      yValueMapper: (ChartData sales, _) => sales.value),
                  SplineSeries<ChartData, DateTime>(
                      name: 'Payments'.tr(),
                      color: MThemeData.serviceColor,
                      dataSource: data.paymentsChartDataDDMMYY,
                      xValueMapper: (ChartData sales, _) => sales.date,
                      yValueMapper: (ChartData sales, _) => sales.value),
                  // SplineSeries<ChartData, DateTime>(
                  //     name: 'Services'.tr(),
                  //     color: MThemeData.serviceColor,
                  //     dataSource: const [],
                  //     xValueMapper: (ChartData sales, _) => sales.date,
                  //     yValueMapper: (ChartData sales, _) => sales.value),
                ],
              ),
            ),
          ],
        ));
  }
}
