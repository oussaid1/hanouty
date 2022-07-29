import 'package:flutter/material.dart';
import 'package:hanouty/screens/client/client_list.dart';
import 'package:hanouty/screens/suplier/suplier_list.dart';

import '../../components.dart';

class PeopleTab extends ConsumerWidget {
  const PeopleTab({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                child: Row(
                  children: [
                    const Text('Client').tr(),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  children: [
                    const Text('Supplier').tr(),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.all(8.0),
          child: TabBarView(
            physics: BouncingScrollPhysics(),
            children: [
              ShopClientsList(),
              SupliersList(),
            ],
          ),
        ),
      ),
    );
  }
}
