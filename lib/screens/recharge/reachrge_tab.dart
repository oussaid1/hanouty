import 'package:flutter/material.dart';

import '../../utils/popup_dialogues.dart';
import 'add_recharge.dart';
import 'stock/recharges_view.dart';
import 'sales/recharge_sales_view.dart';

class RechargeTab extends StatelessWidget {
  const RechargeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 80.0, right: 20.0),
          child: FloatingActionButton.extended(
            heroTag: "add_recharge",
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            extendedIconLabelSpacing: 0,
            onPressed: () {
              MDialogs.dialogSimple(
                context,
                title: Text(
                  'Add Recharge',
                  style: Theme.of(context).textTheme.headline3!,
                ),
                contentWidget:
                    const SizedBox(width: 400, child: AddRechargeWidget()),
              );
            },
            label: SizedBox(
              width: 120,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.add, size: 18),
                  const SizedBox(width: 5),
                  Text('Add Recharge',
                      style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Container(),
          // title: const Text('Recharge List'),
          flexibleSpace: const TabBar(
            physics: NeverScrollableScrollPhysics(),
            splashFactory: NoSplash.splashFactory,
            labelStyle: TextStyle(fontSize: 18),
            indicatorColor: Colors.transparent,
            labelColor: Color.fromARGB(255, 254, 242, 255),
            //unselectedLabelColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.label,
            labelPadding: EdgeInsets.symmetric(horizontal: 80),
            padding: EdgeInsets.symmetric(horizontal: 8),
            //indicatorPadding: const EdgeInsets.symmetric(horizontal: 8),
            //splashBorderRadius: const BorderRadius.all(Radius.circular(6)),

            indicator: BoxDecoration(
              color: Color.fromARGB(50, 255, 255, 255),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            isScrollable: false,
            tabs: [
              Tab(
                text: 'Recharge',
              ),
              Tab(
                text: 'Recharge Sale',
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            RechargeStockView(),
            RechargeSalesView(),
          ],
        ),
      ),
    );
  }
}
