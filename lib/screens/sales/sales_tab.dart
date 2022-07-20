import 'package:hanouty/components.dart';
import 'package:flutter/material.dart';

import 'sales_list.dart';

class SalesTab extends StatelessWidget {
  const SalesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: Container(),
          elevation: 0,
          flexibleSpace: TabBar(
            indicatorColor: Theme.of(context).tabBarTheme.labelColor,
            isScrollable: false,
            tabs: [
              Text(
                'Product Sales'.tr(),
                style: Theme.of(context).textTheme.bodyText1!,
              ),
              Text(
                'Service Sales'.tr(),
                style: Theme.of(context).textTheme.bodyText1!,
              ),
            ],
          ),
        ),
        body: TabBarView(
          physics: const BouncingScrollPhysics(),
          children: [
            // SellProduct(),
            // SellService(),
            const SalesList(),
            Container(),
          ],
        ),
      ),
    );
  }
}
