import 'package:flutter/material.dart';

class SellTab extends StatelessWidget {
  const SellTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final AuthController authController = Get.find();
    //final userController = Get.put(UserController());
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // floatingActionButton: MyFab(
        //   onPressed: () {},
        //   widget: const Text(" Go ").tr(),
        //   icon: const Icon(Icons.home),
        // ),
        appBar: AppBar(
          leading: Container(),
          elevation: 0,
          flexibleSpace: TabBar(
            indicatorColor: Theme.of(context).tabBarTheme.labelColor,
            isScrollable: false,
            tabs: [
              Text(
                'Product',
                style: Theme.of(context).textTheme.bodyText1!,
              ),
              Text(
                'Service',
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
            Container(),
            Container(),
          ],
        ),
      ),
    );
  }
}
