import 'package:hanouty/local_components.dart';

import 'package:hanouty/screens/expenses/add_expense.dart';
import 'package:flutter/material.dart';
import 'package:hanouty/components.dart';
import 'package:hanouty/widgets/search_widget.dart';

import '../../blocs/expensesbloc/expenses_bloc.dart';

class ExpensesListWidget extends ConsumerWidget {
  const ExpensesListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                "Add Expense",
                style: Theme.of(context).textTheme.headline3!,
              ),
              contentWidget: const SizedBox(
                height: 400,
                width: 400,
                child: AddExpense(),
              ),
            );
          },
          label: const Text("Add").tr(),
        ),
      ),
      body: BlocBuilder<ExpensesBloc, ExpensesState>(
        builder: (context, state) {
          if (state.expenses.isEmpty) {
            return Center(
              child: Text(
                "No Expenses",
                style: Theme.of(context).textTheme.headline3!,
              ),
            );
          }
          List<ExpenseModel> expenses = state.expenses;
          return ConstrainedBox(
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
                      listOfCategories: const [],
                      onSearchTextChanged: (String search) {},
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: expenses.length,
                    (context, index) {
                      ExpenseModel expense = expenses[index];
                      return ExpenseListCard(expense: expense);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ExpenseListCard extends ConsumerWidget {
  const ExpenseListCard({
    Key? key,
    required this.expense,
  }) : super(key: key);

  final ExpenseModel expense;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Slidable(
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          IconButton(
              icon: const Icon(
                Icons.payment_outlined,
                color: MThemeData.productColor,
                size: 30,
              ),
              onPressed: () {
                MDialogs.dialogSimple(context,
                    contentWidget: SizedBox(
                      height: 420,
                      width: 400,
                      child: AddExpense(
                        expense: expense,
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
              Icons.edit_outlined,
              color: MThemeData.serviceColor,
            ),
            onPressed: () {
              // update the variables before opening the dialog

              //end
              // open the dialog
              MDialogs.dialogSimple(
                context,
                title: Text(
                  "Edit expense".tr(),
                  style: Theme.of(context).textTheme.headline3!,
                ),
                contentWidget: SizedBox(
                  height: 400,
                  width: 400,
                  child: AddExpense(
                    expense: expense,
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.clear,
              color: MThemeData.errorColor,
            ),
            onPressed: () {
              context.read<ExpensesBloc>().add(DeleteExpensesEvent(expense));
            },
          ),
        ],
      ),
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: MThemeData.primaryColor,
            child: Text(
              expense.name.substring(0, 1).toUpperCase(),
              style: Theme.of(context).textTheme.headline3!,
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                expense.name,
              ),
              RichText(
                text: TextSpan(
                  text: 'Category',
                  style: Theme.of(context).textTheme.subtitle2!,
                  children: [
                    TextSpan(
                      text: ' ${expense.expenseCategory}',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: MThemeData.expensesColor,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          subtitle: Text(
            '${expense.date} }',
            style: Theme.of(context).textTheme.subtitle2!,
          ),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${expense.amount} / ${expense.amountPaid}',
                    style: Theme.of(context).textTheme.headline3!,
                  ),
                ],
              ),
              Text(
                expense.deadLine.toString(),
                style: Theme.of(context).textTheme.subtitle2!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
