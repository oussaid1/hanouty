import 'package:hanouty/models/catrgory/category.dart';
import 'package:hanouty/models/techservice/techservice.dart';
import 'package:hanouty/widgets/list_cards/techservice_card.dart';
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
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: SearchByWidget(
            listOfCategories: Category.categoriesStrings,
            withCategory: true,
            onChanged: (value) {},
            onSearchTextChanged: (value) {},
            onBothChanged: (value, category) {},
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              TechServiceModel techService = widget.techServiceList[index];

              return TechServiceListCard(
                techService: techService,
              );
            },
            childCount: widget.techServiceList.length,
          ),
        ),
      ],
    );
  }
}
