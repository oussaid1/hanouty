import 'package:hanouty/models/income/income.dart';
import 'package:hanouty/providers/var_provider.dart';
import 'package:hanouty/screens/income/add_income/add_income.dart';
import 'package:hanouty/settings/themes.dart';
import 'package:hanouty/utils/popup_dialogues.dart';
import 'package:flutter/material.dart';
import 'package:hanouty/components.dart';

class IncomeListWidget extends ConsumerWidget {
  const IncomeListWidget({Key? key, required this.incomes}) : super(key: key);
  final List<IncomeModel> incomes;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80.0),
        child: FloatingActionButton.extended(
          hoverColor: MThemeData.accentColor,
          backgroundColor: MThemeData.accentColor,
          icon: const Icon(Icons.add),
          onPressed: () {
            MDialogs.dialogSimple(
              context,
              title: Text(
                "Add Income",
                style: Theme.of(context).textTheme.headline3!,
              ),
              contentWidget: const SizedBox(
                height: 600,
                width: 400,
                child: AddIncome(),
              ),
            );
          },
          label: const Text("Add").tr(),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 120,
            ),
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
                // update the variables before opening the dialog
                ref.watch(pickedDateTime.state).state = income.date;
                //end
                // open the dialog
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
                        // ref
                        //     .read(databaseProvider)!
                        //     .deleteIncome(income)
                        //     .then((value) {
                        //   if (value) {
                        //     ScaffoldMessenger.of(context)
                        //         .showSnackBar(MDialogs.snackBar('Done !'));

                        //     Navigator.of(context).pop();
                        //   } else {
                        //     ScaffoldMessenger.of(context).showSnackBar(
                        //         MDialogs.errorSnackBar('Error !'));
                        //   }
                        // });
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
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                income.name,
              ),
              RichText(
                text: TextSpan(
                  text: ' Source :',
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
          subtitle: Text(
            '${income.date} }',
            style: Theme.of(context).textTheme.subtitle2!,
          ),
          trailing: Text(
            income.amount.toString(),
            style: Theme.of(context).textTheme.headline3!,
          ),
        ),
      ),
    );
  }
}
