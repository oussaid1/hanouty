import 'package:flutter/material.dart';
import '../../components.dart';
import '../../local_components.dart';

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
class RadialBarCahrtCard extends StatelessWidget {
  final Revenu data;
  final String title;
  const RadialBarCahrtCard({
    Key? key,
    required this.data,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 300,
      child: RadialChart(data: data),
    );
  }
}

class LineChartCard extends ConsumerWidget {
  final List<ChartData> data;
  final String title;
  const LineChartCard({
    Key? key,
    required this.data,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LineChartWidget(data: data);
  }
}

class PieChartCard extends ConsumerWidget {
  final List<ChartData> data;
  const PieChartCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PieChart(data: data);
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////
///

class LineChartWidget extends StatelessWidget {
  final List<ChartData> data;
  const LineChartWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LineChart(
      data: data,
    );
  }
}

class LineChart extends ConsumerWidget {
  final List<ChartData> data;
  const LineChart({
    Key? key,
    required this.data,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  xValueMapper: (ChartData sales, _) => sales.getDate,
                  yValueMapper: (ChartData sales, _) => sales.value),
              SplineSeries<ChartData, DateTime>(
                  name: 'Products'.tr(),
                  color: MThemeData.productColor,
                  dataSource: data,
                  xValueMapper: (ChartData sales, _) => sales.getDate,
                  yValueMapper: (ChartData sales, _) => sales.value),
              SplineSeries<ChartData, DateTime>(
                  name: 'Services'.tr(),
                  color: MThemeData.serviceColor,
                  dataSource: const [],
                  xValueMapper: (ChartData sales, _) => sales.getDate,
                  yValueMapper: (ChartData sales, _) => sales.value),
            ],
          ),
        ),
      ],
    );
  }
}

class PieChart extends StatelessWidget {
  final List<ChartData> data;
  const PieChart({
    Key? key,
    required this.data,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40,
          width: 420,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Product Categories In Stock'.tr(),
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(color: Theme.of(context).colorScheme.primary),
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
          series: _getDefaultDoughnutSeries(),
        )),
      ],
    );
  }

  ///Get the default circular series
  List<DoughnutSeries<ChartData, String>> _getDefaultDoughnutSeries() {
    return <DoughnutSeries<ChartData, String>>[
      DoughnutSeries<ChartData, String>(
          radius: '80%',
          explode: true,
          explodeOffset: '20%',
          dataSource: data.take(8).toList(),
          xValueMapper: (ChartData data, _) => data.label as String,
          yValueMapper: (ChartData data, _) => data.value,
          dataLabelMapper: (ChartData data, _) => data.label,
          dataLabelSettings: const DataLabelSettings(
            isVisible: true,
          ))
    ];
  }
}

class BarChartCard extends ConsumerWidget {
  final List<ChartData> data;
  final String title;
  const BarChartCard({
    Key? key,
    required this.data,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

class BarChart extends StatelessWidget {
  final List<ChartData> data;
  const BarChart({
    Key? key,
    required this.data,
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
                  dataSource: data,
                  xValueMapper: (ChartData sales, _) => (sales.getDate),
                  yValueMapper: (ChartData sales, z) => sales.value),
              ColumnSeries<ChartData, DateTime>(
                  name: 'Products',
                  color: MThemeData.serviceColor,
                  dataSource: [],
                  xValueMapper: (ChartData sales, _) => sales.getDate,
                  yValueMapper: (ChartData sales, _) => sales.value),
              ColumnSeries<ChartData, DateTime>(
                  name: 'Sales',
                  color: MThemeData.expensesColor,
                  dataSource: [],
                  xValueMapper: (ChartData sales, _) => sales.getDate,
                  yValueMapper: (ChartData sales, _) => sales.value),
            ],
          ),
        ),
      ],
    );
  }
}

class PieChartWidget extends ConsumerWidget {
  const PieChartWidget({
    Key? key,
    required this.title,
    required this.chartData,
  }) : super(key: key);
  final String title;
  final List<ChartData> chartData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final salesData = ref.watch(salesDataStateNotifierProvider.state).state;

    return SizedBox(
      width: 420,
      height: 240,
      child: Column(
        children: [
          SizedBox(
            height: 40,
            width: 420,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(color: Theme.of(context).colorScheme.primary),
                ),
              ],
            ),
          ),
          Expanded(child: buildLegendDefaultChart(chartData)),
        ],
      ),
    );
  }

  SfCircularChart buildLegendDefaultChart(List<ChartData> chartData) {
    return SfCircularChart(
      legend:
          Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
      series: getLegendDefaultSeries(chartData),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  ///Get the default circular series
  List<DoughnutSeries<ChartData, String>> getLegendDefaultSeries(
      List<ChartData> chartData) {
    return <DoughnutSeries<ChartData, String>>[
      DoughnutSeries<ChartData, String>(
          dataSource: chartData,
          xValueMapper: (ChartData data, _) => data.label,
          yValueMapper: (ChartData data, _) => data.value,
          startAngle: 90,
          endAngle: 90,
          dataLabelSettings: const DataLabelSettings(
              isVisible: true, labelPosition: ChartDataLabelPosition.outside)),
    ];
  }
}

class RadialChart extends StatelessWidget {
  final Revenu data;
  const RadialChart({Key? key, required this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<ChartData> chartData = [
      ChartData(
        color: MThemeData.revenuColor,
        label: 'Revenu',
        value: 0,
      ),
      ChartData(
        color: MThemeData.expensesColor,
        label: 'Expense',
        value: 0,
      ),
      ChartData(
        color: MThemeData.productColor,
        label: 'Debts',
        value: 0,
      ),
      ChartData(
        color: MThemeData.incomeColor,
        label: 'Incomes',
        value: 0,
      ),
      ChartData(
        color: MThemeData.profitColor,
        label: 'Profit',
        value: 0,
      ),
    ];

    return Material(
        color: Colors.transparent,
        child: BluredContainer(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      children: [
                        const Icon(FontAwesomeIcons.moneyBill1Wave),
                        const SizedBox(width: 8),
                        Text(
                          'Revenu'.tr(),
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(
                                  color: Theme.of(context).colorScheme.primary),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.more_vert),
                ],
              ),
              const SizedBox(height: 8),
              Stack(
                fit: StackFit.passthrough,
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                        // color: Color.fromARGB(137, 255, 245, 231),
                        height: 140,
                        width: 160,
                        child: SfCircularChart(
                          centerX: '60',
                          centerY: '60',
                          // legend: Legend(
                          //   //alignment: ChartAlignment.far,
                          //   isResponsive: true,
                          //   iconBorderWidth: 2,
                          //   isVisible: true,
                          //   overflowMode: LegendItemOverflowMode.wrap,
                          //   backgroundColor: const Color.fromARGB(0, 255, 255, 255),
                          //   textStyle: Theme.of(context)
                          //       .textTheme
                          //       .subtitle2!
                          //       .copyWith(
                          //           color: Theme.of(context).colorScheme.onPrimary),
                          // ),
                          series: [
                            RadialBarSeries<ChartData, String>(
                              animationDuration: 0,
                              // pointRadiusMapper: (ChartSampleData data, ) => data.xValue as String,
                              //maximumValue: 100,
                              radius: '90%',
                              gap: '2%',
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
                    right: 8,
                    top: 20,
                    width: 140,
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
    return Row(
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
    );
  }
}
