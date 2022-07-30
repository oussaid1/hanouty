import 'package:hanouty/components.dart';
import 'package:flutter/material.dart';

import 'expenses_list.dart';

class ExpensesTab extends StatelessWidget {
  const ExpensesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: Container(),
          elevation: 0,
          flexibleSpace: Column(
            children: [
              TabBar(
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Expenses').tr(),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        body: const TabBarView(
          physics: BouncingScrollPhysics(),
          children: [
            ExpensesListWidget(),
          ],
        ),
      ),
    );
  }
}

class ExpensesList {}
