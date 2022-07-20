import 'package:hanouty/components.dart';
import 'package:hanouty/screens/income/income_list.dart';
import 'package:flutter/material.dart';

class IncomeTab extends ConsumerWidget {
  const IncomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  Text('Income'.tr(),
                      style: Theme.of(context).textTheme.subtitle2!),
                ],
              ),
            ],
          ),
        ),
        body: const TabBarView(
          physics: BouncingScrollPhysics(),
          children: [
            IncomeListWidget(incomes: []),
          ],
        ),
      ),
    );
  }
}
