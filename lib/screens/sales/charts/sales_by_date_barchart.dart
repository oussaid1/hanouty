import 'package:flutter/material.dart';

import '../../../components.dart';
import '../../../models/chart_data.dart';
import '../../../models/Sale/tagged_sales.dart';
import '../../../settings/themes.dart';

class DashboardBarChart extends StatelessWidget {
  final List<ChartData> pdta;
  final List<ChartData> sdta;
  final List<ChartData> dta;
  final String? title;
  const DashboardBarChart({
    Key? key,
    required this.dta,
    required this.sdta,
    required this.pdta,
    this.title,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
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
                  color: MThemeData.serviceColor,
                  dataSource: sdta,
                  xValueMapper: (ChartData sales, _) => (sales.date),
                  yValueMapper: (ChartData sales, z) => sales.value),
              ColumnSeries<ChartData, DateTime>(
                  name: 'Products',
                  color: MThemeData.productColor,
                  dataSource: pdta,
                  xValueMapper: (ChartData sales, _) => sales.date,
                  yValueMapper: (ChartData sales, _) => sales.value),
              ColumnSeries<ChartData, DateTime>(
                  name: 'Sales',
                  color: MThemeData.expensesColor,
                  dataSource: dta,
                  xValueMapper: (ChartData sales, _) => sales.date,
                  yValueMapper: (ChartData sales, _) => sales.value),
            ],
          ),
        ),
      ],
    );
  }
}

class BySuplierBarChart extends StatelessWidget {
  final List<TaggedSales> data;
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
        Expanded(
          child: SfCartesianChart(
            title: ChartTitle(
              text: title,
              textStyle: Theme.of(context).textTheme.subtitle2!,
            ),
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
              ColumnSeries<TaggedSales, String>(
                  dataLabelMapper: (TaggedSales sales, _) =>
                      '${sales.salesData.totalSalesCount}',
                  dataLabelSettings: const DataLabelSettings(
                    isVisible: true,
                    labelAlignment: ChartDataLabelAlignment.top,

                    //textStyle: Theme.of(context).textTheme.subtitle2!,
                  ),
                  pointColorMapper: (TaggedSales sales, _) => sales.randomColor,
                  dataSource: data,
                  xValueMapper: (TaggedSales sales, _) => (sales.tag),
                  yValueMapper: (TaggedSales sales, z) =>
                      sales.salesData.totalSalesAmount),
            ],
          ),
        ),
      ],
    );
  }
}
