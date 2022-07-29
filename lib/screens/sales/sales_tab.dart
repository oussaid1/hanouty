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
          backgroundColor: Colors.transparent,
          leading: Container(),
          elevation: 0,
          flexibleSpace: TabBar(
            labelStyle: const TextStyle(fontSize: 18),
            indicatorColor: Colors.transparent,
            labelColor: const Color.fromARGB(255, 254, 242, 255),
            //unselectedLabelColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.label,
            labelPadding: const EdgeInsets.symmetric(horizontal: 80),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            //indicatorPadding: const EdgeInsets.symmetric(horizontal: 8),
            //splashBorderRadius: const BorderRadius.all(Radius.circular(6)),

            indicator: const BoxDecoration(
              color: Color.fromARGB(50, 255, 255, 255),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            isScrollable: false,
            tabs: [
              Tab(
                text: 'Product Sales'.tr(),
              ),
              Tab(
                text: 'Service Sales'.tr(),
                //style: Theme.of(context).textTheme.bodyText1!,
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
