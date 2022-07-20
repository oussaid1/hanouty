import 'dart:developer';

import 'package:hanouty/blocs/clientsbloc/clients_bloc.dart';
import 'package:hanouty/local_components.dart';
import 'package:hanouty/models/product/product.dart';
import 'package:hanouty/models/revenu/revenu.dart';
import 'package:flutter/material.dart';
import '../../blocs/debtbloc /debt_bloc.dart';
import '../../blocs/expensesbloc/expenses_bloc.dart';
import '../../blocs/incomebloc/income_bloc.dart';
import '../../blocs/paymentsbloc/payments_bloc.dart';
import '../../blocs/productbloc/product_bloc.dart';
import '../../blocs/salesbloc/sales_bloc.dart';
import '../../components.dart';
import '../../cubits/cubit/filter_cubit.dart';
import '../../models/models.dart';
import '../../utils/popup_dialogues.dart';
import '../../widgets/cards/latest_trans_list_card.dart';
import '../../widgets/cards/scares_productss_instock.dart';
import '../../widgets/charts/inventory_widget.dart';
import '../../widgets/charts/syncfusion_charts.dart';
import '../client/add_clients/add_client.dart';
import '../product/add_product/add_product.dart';
import '../suplier/add_suplier/add_suplier.dart';
import '../techservice/add_service/add_service.dart';

class DashBoardPage extends StatelessWidget {
  const DashBoardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var filterType = context.watch<FilterCubit>().state.status;
    var productBloc = context.watch<ProductBloc>().state;
    var debtBloc = context.watch<DebtBloc>().state;
    var paymentsBloc = context.watch<PaymentsBloc>().state;
    var salesBloc = context.watch<SalesBloc>().state;
    var incomeBloc = context.watch<IncomeBloc>().state;
    var expenseBloc = context.watch<ExpenseBloc>().state;
    var clientsBloc = context.watch<ShopClientBloc>().state;
    var filteredProducts = FilteredProduct(products: productBloc.products);
    var filteredDebts = FilteredDebts(debts: debtBloc.debts);
    var filteredSales = FilteredSales(sales: salesBloc.sales);
    var filteredIncome = FilteredIncomes(incomes: incomeBloc.incomes);
    var filteredExpense = FilteredExpenses(expenses: expenseBloc.expenses);
    //// Data for the charts
    var productsData = ProductStockData(products: filteredProducts.products);
    var salesData = SalesData(filteredSales: filteredSales.sales);
    var incomeData = IncomeData(filteredIncome: filteredIncome.incomes);
    var expenseData = ExpenseData(expenses: filteredExpense.expenses);
    var debtData = DebtData(
      allDebts: filteredDebts.debts,
      payments: paymentsBloc.payments,
    );

    log('filterType: $filterType');
    log('productBloc: ${productBloc.products.length}');
    log('clientsBloc: ${clientsBloc.clients.length}');
    log('clientsBloc: ${productBloc.status}');
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: const Padding(
        padding: EdgeInsets.only(bottom: 80.0),
        child: AddStuffWidget(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 20,
                direction: Axis.horizontal,
                alignment: WrapAlignment.spaceBetween,
                runSpacing: 20,
                children: [
                  const MyInventoryWidget(),
                  const MySalesWidgetBlurred(),
                  const SizedBox(height: 20),
                  RadialBarCahrtCard(
                    data: Revenu(
                      debtData: debtData,
                      salesData: salesData,
                      expensesData: expenseData,
                      incomeData: incomeData,
                    ),
                    title: 'Revenu',
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Wrap(
                spacing: 20,
                direction: Axis.horizontal,
                alignment: WrapAlignment.spaceBetween,
                children: [
                  const BluredContainer(
                      width: 420,
                      height: 400,
                      child: LineChartCard(data: [], title: 'Inventory')),
                  const BluredContainer(
                    width: 420,
                    height: 400,
                    child: BarChartCard(
                      data: [],
                      title: 'Sales',
                    ),
                  ),
                  const SizedBox(width: 2),
                  Wrap(
                    direction: Axis.vertical,
                    children: const [
                      ScaresProductslistCard(),
                      SizedBox(height: 20),
                      LatestTransactionsListCard(
                        salesList: [],
                      ),
                    ],
                  ),
                ],
              ),
              Wrap(
                spacing: 20,
                direction: Axis.vertical,
                alignment: WrapAlignment.spaceBetween,
                children: [
                  const ScaresProductslistCard(),
                  LatestTransactionsListCard(
                    salesList: filteredSales.sales,
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

class AddStuffWidget extends StatelessWidget {
  const AddStuffWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton.extended(
          icon: const Icon(Icons.add),
          onPressed: () {
            log('add stuff ${context.widget}');
            MDialogs.dialogSimple(
              context,
              title: Text(
                "Add Product",
                style: Theme.of(context).textTheme.headline3!,
              ),
              contentWidget: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                ),
                //  gradient: MThemeData.gradient2),
                height: 500,
                width: 420,
                child: const AddOrEditProduct(),
              ),
            );
          },
          label: const Text("Add Product").tr(),
        ),
        const SizedBox(height: 10),
        FloatingActionButton.extended(
          icon: const Icon(Icons.add),
          onPressed: () {
            MDialogs.dialogSimple(
              context,
              title: Text(
                "Add Service",
                style: Theme.of(context).textTheme.headline3!,
              ),
              contentWidget: const SizedBox(
                height: 400,
                width: 400,
                child: AddService(),
              ),
            );
          },
          label: const Text("Add Service").tr(),
        ),
        const SizedBox(height: 10),
        FloatingActionButton.extended(
          icon: const Icon(Icons.add),
          onPressed: () {
            log('add stuff ${context.widget}');
            MDialogs.dialogSimple(
              context,
              title: Text(
                "Add Client",
                style: Theme.of(context).textTheme.headline3!,
              ),
              contentWidget: SizedBox(
                height: 400,
                width: 400,
                child: AddClient(
                  pContext: context,
                ),
              ),
            );
          },
          label: const Text("Add Client").tr(),
        ),
        const SizedBox(height: 10),
        FloatingActionButton.extended(
          icon: const Icon(Icons.add),
          onPressed: () {
            MDialogs.dialogSimple(
              context,
              title: Text(
                "Add Suplier",
                style: Theme.of(context).textTheme.headline3!,
              ),
              contentWidget: const SizedBox(
                height: 400,
                width: 400,
                child: AddSuplier(),
              ),
            );
          },
          label: const Text("Add Suplier").tr(),
        ),
      ],
    );
  }
}
