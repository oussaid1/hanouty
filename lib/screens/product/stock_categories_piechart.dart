import 'package:flutter/material.dart';
import 'package:hanouty/local_components.dart';
import 'package:hanouty/models/product/tagged_products.dart';

import '../../components.dart';

class StockCategoriesPieChart extends StatelessWidget {
  final List<TaggedProducts> data;
  const StockCategoriesPieChart({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BluredContainer(
        width: 420,
        height: 300,
        child: Column(
          children: [
            SizedBox(
              height: 40,
              width: 420,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Categories',
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
              series: <DoughnutSeries<TaggedProducts, String>>[
                DoughnutSeries<TaggedProducts, String>(
                    radius: '80%',
                    explode: true,
                    explodeOffset: '20%',
                    dataSource: data,
                    xValueMapper: (TaggedProducts data, _) => data.tag,
                    yValueMapper: (TaggedProducts data, _) =>
                        data.productsData.productCountInStock,
                    dataLabelMapper: (TaggedProducts data, _) => data.tag,
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
