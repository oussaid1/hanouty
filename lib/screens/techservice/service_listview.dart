import 'package:hanouty/models/catrgory/category.dart';
import 'package:hanouty/models/techservice/techservice.dart';
import 'package:hanouty/screens/techservice/techservice_card.dart';
import 'package:hanouty/widgets/search_widget.dart';
import 'package:flutter/material.dart';

class TechServiceListView extends StatefulWidget {
  const TechServiceListView({Key? key, required this.techServiceList})
      : super(key: key);
  final List<TechServiceModel> techServiceList;
  @override
  TechServiceListViewState createState() => TechServiceListViewState();
}

class TechServiceListViewState extends State<TechServiceListView> {
  String fltr = '';

  /// filter the list of tech services by category nd name
  List<TechServiceModel> filteredTechServicesList() {
    return widget.techServiceList
        .where((e) =>
            e.toString().toLowerCase().contains(fltr.toLowerCase().trim()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: SearchByWidget(
            listOfCategories: Category.categoriesStrings,
            withCategory: true,
            onChanged: (value, category) {
              setState(() {
                fltr = value;
              });
            },
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              TechServiceModel techService = filteredTechServicesList()[index];

              return TechServiceListCard(
                techService: techService,
              );
            },
            childCount: filteredTechServicesList().length,
          ),
        ),
      ],
    );
  }
}
