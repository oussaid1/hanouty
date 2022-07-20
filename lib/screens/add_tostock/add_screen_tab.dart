import 'package:flutter/material.dart';

import '../../blocs/productbloc/product_bloc.dart';
import '../../components.dart';
import '../../local_components.dart';
import '../client/client_list.dart';
import '../product/products_listview.dart';
import '../sales/services_list.dart';
import '../suplier/suplier_list.dart';

class AddScreenTab extends ConsumerWidget {
  const AddScreenTab({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: Container(),
          elevation: 0,
          flexibleSpace: TabBar(
            indicatorColor: Theme.of(context).tabBarTheme.labelColor,
            isScrollable: false,
            tabs: [
              Text(
                'Product'.tr(),
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: MThemeData.serviceColor),
              ),
              Text(
                'Service'.tr(),
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: MThemeData.productColor),
              ),
              Text(
                'Client'.tr(),
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: MThemeData.salesColor),
              ),
              Text(
                'Suplier'.tr(),
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: MThemeData.revenuColor),
              ),
            ],
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.all(8.0),
          child: TabBarView(
            physics: BouncingScrollPhysics(),
            children: [
              ProductList(),
              TechServiceList(),
              ShopClientsList(),
              SupliersList(),
            ],
          ),
        ),
      ),
    );
  }
}
