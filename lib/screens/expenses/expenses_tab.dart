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
          leading: Container(),
          elevation: 0,
          flexibleSpace: Column(
            children: [
              TabBar(
                indicatorColor: Theme.of(context).tabBarTheme.labelColor,
                isScrollable: false,
                tabs: [
                  Text('Expenses'.tr(),
                      style: Theme.of(context).textTheme.subtitle2!),
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
