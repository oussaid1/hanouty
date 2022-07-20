import 'package:hanouty/components.dart';
import 'package:hanouty/models/techservice/techservice.dart';
import 'package:hanouty/screens/techservice/service_listview.dart';
import 'package:flutter/material.dart';

class SellService extends ConsumerWidget {
  const SellService({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<TechServiceModel> techServicesList = [];

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Wrap(
                children: [
                  SizedBox(
                    width: 700,
                    height: 700,
                    child: TechServiceListView(
                      techServiceList: techServicesList,
                    ),
                  ),
                  const Card(
                    child: SizedBox(
                      width: 420,
                      height: 400,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
