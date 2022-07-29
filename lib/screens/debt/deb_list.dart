import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hanouty/local_components.dart';

import 'package:hanouty/utils/global_functions.dart';
import '../../blocs/clientsbloc/clients_bloc.dart';
import '../../blocs/debtbloc /debt_bloc.dart';
import '../../blocs/paymentsbloc/payments_bloc.dart';
import '../../components.dart';
import '../../models/debt/debtsviewmodel.dart';

import '../../widgets/price_number_zone.dart';
import '../../widgets/search_widget.dart';
import 'debt_details_widget.dart';
import 'debt_piechart.dart';
import 'due_debts_card.dart';
import 'line_chart.dart';

class DebtsView extends StatelessWidget {
  const DebtsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocListener<DebtBloc, DebtState>(
        listener: (context, state) {
          switch (state.status) {
            case DebtStatus.initial:
              GlobalFunctions.showSuccessSnackBar(context, "initial");
              break;
            case DebtStatus.loaded:
              break;
            case DebtStatus.added:
              GlobalFunctions.showSuccessSnackBar(
                  context, "successfully added");
              break;
            case DebtStatus.deleted:
              GlobalFunctions.showSuccessSnackBar(
                  context, "successfully deleted");
              break;
            case DebtStatus.updated:
              GlobalFunctions.showSuccessSnackBar(
                  context, "successfully updated");
              break;
            case DebtStatus.notAdded:
              GlobalFunctions.showErrorSnackBar(context, state.error!);
              break;
            case DebtStatus.notDeleted:
              GlobalFunctions.showErrorSnackBar(context, state.error!);
              break;
            case DebtStatus.notUpdated:
              GlobalFunctions.showErrorSnackBar(context, state.error!);
              break;
            case DebtStatus.error:
              GlobalFunctions.showErrorSnackBar(
                  context, state.error.toString());
              break;
          }
        },
        child: Column(
          children: const [
            TopWidgetDebtsView(),
            _DebtList(),
          ],
        ),
      ),
    );
  }
}

class _DebtList extends StatefulWidget {
  const _DebtList({
    Key? key,
  }) : super(key: key);

  @override
  State<_DebtList> createState() => _DebtListState();
}

class _DebtListState extends State<_DebtList> {
  List<ClientDebt> _clientDebts = [];
  String filter = '';
  ClientDebt? selectedClientDebt;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopClientBloc, ShopClientState>(
      builder: (context, shopsState) {
        return BlocBuilder<PaymentsBloc, PaymentsState>(
          builder: (context, paymentsState) {
            return BlocBuilder<DebtBloc, DebtState>(
              builder: (context, debtsState) {
                if (debtsState.debts.isEmpty) {
                  return const Center(
                    child: Text('No debts'),
                  );
                }
                DebtsStatsViewModel debtsStatsViewModel = DebtsStatsViewModel(
                    shopClients: shopsState.clients,
                    debts: debtsState.debts,
                    payments: paymentsState.payments);
                // DebtData debtData = DebtData(
                //   allDebts: debtsState.debts,
                //   allpayments: paymentsState.payments,
                // );

                _clientDebts = debtsStatsViewModel.clientDebts
                    .where((e) => e.shopClient.clientName!
                        .toLowerCase()
                        .toString()
                        .contains(filter.toLowerCase()))
                    .toList();
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 8),
                      child: SearchByWidget(
                        listOfCategories: ProductModel.fieldStrings,
                        withCategory: false,
                        onSearchTextChanged: (String text) {
                          log('search text: $text');
                          setState(() {
                            filter = text;
                          });
                        },
                        onBothChanged: (String category, String text) {
                          log('both: , ');
                          //_data!.filterByCategory(category, text);
                        },
                      ),
                    ),
                    Wrap(
                      direction: Axis.horizontal,
                      spacing: 15,
                      runSpacing: 15,
                      children: [
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            minWidth: 420,
                            minHeight: 400,
                            maxWidth: 720,
                            maxHeight: 500,
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: _clientDebts.length,
                            itemBuilder: (context, index) {
                              final clientDebt = _clientDebts[index];
                              return Card(
                                color: const Color.fromARGB(127, 255, 255, 255),
                                elevation: 0,
                                child: DebtListCard(
                                  clientDebt: clientDebt,
                                  onTap: (value) {
                                    setState(() {
                                      selectedClientDebt = value;
                                    });
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                        BluredContainer(
                          width: 420,
                          height: 500,
                          child: DebtDetailsWidget(
                            clientDebt: selectedClientDebt,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}

class TopWidgetDebtsView extends StatelessWidget {
  const TopWidgetDebtsView({
    Key? key,
    //required this.debtsStatsViewModel,
  }) : super(key: key);
  //final DebtsStatsViewModel debtsStatsViewModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopClientBloc, ShopClientState>(
      builder: (context, shopsState) {
        return BlocBuilder<PaymentsBloc, PaymentsState>(
          builder: (context, paymentsState) {
            return BlocBuilder<DebtBloc, DebtState>(
              builder: (context, debtsState) {
                DebtsStatsViewModel debtsStatsViewModel = DebtsStatsViewModel(
                    shopClients: shopsState.clients,
                    debts: debtsState.debts,
                    payments: paymentsState.payments);
                DebtData debtData = DebtData(
                  allDebts: debtsState.debts,
                  allpayments: paymentsState.payments,
                );
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Wrap(
                    runSpacing: 15,
                    spacing: 15,
                    children: [
                      DebtLineChart(data: debtData),
                      DebtPieChart(data: debtsStatsViewModel),
                      BluredContainer(
                        width: 420,
                        height: 270,
                        child: DueDebtsCard(
                          debtsStatsViewModel: debtsStatsViewModel,
                        ),
                      ),
                      OverallDebtsWidget(
                        debtdata: debtData,
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

class DebtListCard extends StatelessWidget {
  const DebtListCard({
    Key? key,
    required this.clientDebt,
    required this.onTap,
  }) : super(key: key);

  final ClientDebt clientDebt;
  final Function(ClientDebt) onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8),
      child: InkWell(
        onTap: () => onTap(clientDebt),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: CircularPercentIndicator(
                    progressColor: Theme.of(context).colorScheme.secondary,
                    radius: 20,
                    lineWidth: 3,
                    percent: clientDebt.debtData.unitInterval,
                    center: Text(
                      '${clientDebt.debtData.totalDifferencePercentage}%',
                      style: Theme.of(context).textTheme.caption!,
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${clientDebt.shopClient.clientName}',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    Text(
                      clientDebt.debtData.nearestDeadlineDate.ddmmyyyy(),
                      style: context.textTheme.subtitle2!.copyWith(
                        color: Theme.of(context).colorScheme.primaryContainer,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  PriceNumberZone(
                    withDollarSign: true,
                    // right: const SizedBox.shrink(), //const Text('left'),
                    price: clientDebt.debtData.totalDebtAmountLeft,
                    priceStyle: Theme.of(context).textTheme.headline2!.copyWith(
                          color: MThemeData.serviceColor,
                        ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'from /',
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                            color:
                                Theme.of(context).colorScheme.primaryContainer),
                      ),
                      PriceNumberZone(
                        withDollarSign: true,
                        price: clientDebt.debtData.totalDebtAmount,
                        priceStyle:
                            Theme.of(context).textTheme.subtitle2!.copyWith(
                                  color: MThemeData.serviceColor,
                                ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OverallDebtsWidget extends StatelessWidget {
  final DebtData debtdata;
  const OverallDebtsWidget({
    Key? key,
    required this.debtdata,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BluredContainer(
      width: 420,
      height: 156,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(FontAwesomeIcons.moneyBillTransfer),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0, right: 18),
                    child: Text(
                      'Overall'.tr(),
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                ],
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_vert_outlined,
                  ))
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: LinearPercentIndicator(
                  percent: debtdata.unitInterval,
                  progressColor: MThemeData.expensesColor,
                ),
              ),
              Text(
                '${debtdata.totalDifferencePercentage}%',
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      color: MThemeData.productColor,
                    ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18),
                child: Column(
                  children: [
                    Text(
                      'Highest'.tr(),
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    PriceNumberZone(
                      price: debtdata.highestDebtAmount,
                      withDollarSign: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18),
                child: Column(
                  children: [
                    Text(
                      'Lowest'.tr(),
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    PriceNumberZone(
                      price: debtdata.lowestDebtAmount,
                      withDollarSign: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(
            height: 0,
            thickness: 1,
            color: Color.fromARGB(202, 255, 255, 255),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 8, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: context.theme.onSecondaryContainer),
                ),
                PriceNumberZone(
                  right: const SizedBox.shrink(),
                  withDollarSign: true,
                  price: debtdata.totalDebtAmount,
                  priceStyle: context.textTheme.bodyLarge!.copyWith(
                      //fontWeight: FontWeight.w100,
                      // wordSpacing: 0.5,
                      fontSize: 18,
                      color: Colors.white.withOpacity(0.8)),
                  // style: Theme.of(context)
                  //     .textTheme
                  //     .headline2!
                  //     .copyWith(color: context.theme.primary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
