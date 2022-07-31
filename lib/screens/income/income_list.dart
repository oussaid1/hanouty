import 'package:flutter/material.dart';
import 'package:hanouty/components.dart';
import 'package:hanouty/local_components.dart';
import 'package:hanouty/widgets/search_widget.dart';

import '../../blocs/incomebloc/income_bloc.dart';

import 'add_income.dart';

class IncomeListWidget extends StatelessWidget {
  const IncomeListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80.0),
        child: FloatingActionButton.extended(
          icon: const Icon(Icons.add),
          onPressed: () {
            MDialogs.dialogSimple(
              context,
              title: Text(
                "Add Income",
                style: Theme.of(context).textTheme.headline3!,
              ),
              contentWidget: const AddIncome(),
            );
          },
          label: const Text("Add").tr(),
        ),
      ),
      body: BlocBuilder<IncomesBloc, IncomesState>(
        builder: (context, state) {
          if (state.incomes.isEmpty) {
            return Center(
              child: Text(
                "No Incomes",
                style: Theme.of(context).textTheme.headline3!,
              ),
            );
          }
          List<IncomeModel> incomes = state.incomes;
          FilteredIncomes filteredIncomes = FilteredIncomes(incomes: incomes);
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height - 120,
                maxWidth: 600,
              ),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: SizedBox(
                        height: 120,
                        child: SearchByWidget(
                          listOfCategories: filteredIncomes.distinctCategories,
                          onSearchTextChanged: (txt) {},
                        )),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        IncomeModel income = incomes[index];

                        return IncomeListCard(income: income);
                      },
                      childCount: incomes.length,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class IncomeListCard extends ConsumerWidget {
  const IncomeListCard({
    Key? key,
    required this.income,
  }) : super(key: key);

  final IncomeModel income;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Slidable(
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          IconButton(
              icon: const Icon(
                Icons.edit,
                color: MThemeData.serviceColor,
                size: 30,
              ),
              onPressed: () {
                MDialogs.dialogSimple(context,
                    contentWidget: SizedBox(
                      height: 600,
                      width: 400,
                      child: AddIncome(
                        income: income,
                      ),
                    ));
              })
        ],
      ),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          IconButton(
            icon: const Icon(
              Icons.clear,
              color: MThemeData.errorColor,
            ),
            onPressed: () {
              MDialogs.dialogSimple(
                context,
                title: Text(
                  " ${income.name}",
                  style: Theme.of(context).textTheme.headline3!,
                ),
                contentWidget: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: MThemeData.raisedButtonStyleSave,
                      child: Text(
                        'Delete'.tr(),
                        style: Theme.of(context).textTheme.bodyText1!,
                      ),
                      onPressed: () {
                        BlocProvider.of<IncomesBloc>(context).add(
                          DeleteIncomeEvent(income),
                        );
                        Navigator.pop(context);
                      },
                    ),
                    ElevatedButton(
                      style: MThemeData.raisedButtonStyleCancel,
                      child: Text(
                        'Cancel'.tr(),
                        style: Theme.of(context).textTheme.bodyText1!,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: MThemeData.primaryColor,
            child: Text(
              income.name.substring(0, 1).toUpperCase(),
              style: Theme.of(context).textTheme.headline3!,
            ),
          ),
          title: Text(
            income.name,
          ),
          subtitle: Text(
            income.date.ddmmyyyy(),
            style: Theme.of(context).textTheme.subtitle2!,
          ),
          trailing: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                income.amount.toString(),
                style: Theme.of(context).textTheme.headline3!,
              ),
              RichText(
                text: TextSpan(
                  text: 'From :',
                  style: Theme.of(context).textTheme.subtitle2!,
                  children: [
                    TextSpan(
                      text: ' ${income.source}',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: MThemeData.serviceColor,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
