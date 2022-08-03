import 'package:flutter/material.dart';
import 'package:hanouty/blocs/bloc/sellactionsrecharge_bloc.dart';
import 'package:hanouty/extensions/extensions.dart';
import '../../../blocs/clientsbloc/clients_bloc.dart';
import '../../../blocs/rechargebloc/fullrechargesales_bloc.dart';
import '../../../components.dart';
import '../../../models/recharge/filtered_recharges.dart';
import '../../../models/recharge/recharge.dart';
import '../../../models/recharge/recharge_sales_data.dart';
import '../../../utils/glasswidgets.dart';
import '../../../utils/popup_dialogues.dart';
import '../../../widgets/search_widget.dart';
import '../sell_recharge.dart';
import 'recharge_sales_chats.dart';
import 'recharge_sales_inventory.dart';

class RechargeSalesView extends StatelessWidget {
  const RechargeSalesView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopClientBloc, ShopClientState>(
      builder: (context, clientState) {
        return BlocBuilder<RechargeBloc, RechargeState>(
          builder: (context, rechargeState) {
            /// [RechargeSalesData] is a [List<RechargeModel>]
            // RecghargeViewModel recghargeViewModel = RecghargeViewModel(
            //   shopClients: ShopClientModel.fakeClients,
            //   rechargeList: RechargeModel.fakeData,
            //   rechargeSalesList: RechargeSaleModel.fakeData,
            // );

            /// this is a list of [RechargeSalesModel] after being joined to [RechargeModel]
            List<RechargeSaleModel> fullRechargeSales =
                rechargeState.fullRechargeSalesList;

            /// this is a list of [RechargeSalesModel] after being filtered by [DateFilter]
            FilteredRechargesSales filteredRecharges = FilteredRechargesSales(
              fullRechargeList: fullRechargeSales,
            );
//////////////////////////////////////////////////////
//////////////filtered [List<RechargeSaleModel>] which is filtered by [DateFilter]////////////////////////////
            // List<RechargeSaleModel> filteredRechargeSalesList =
            //     filteredRecharges.allRechargeSales;
//////////////////////////////////////////////////////
            RechargeSalesData data = RechargeSalesData(
              rechargeSalesList: rechargeState.fullRechargeSalesList,
            );

            ////////////////////////////////////////////////////////////////////////////////
            /// this is the main widget that will be displayed in the screen               ///
            List<RechargeSaleChartData> salesDataInwi = data.inwiChartDataDaily
              ..sort((a, b) => b.date!.compareTo(a.date!));
            List<RechargeSaleChartData> salesDataOrange = data
                .orangeChartDataDaily
              ..sort((a, b) => b.date!.compareTo(a.date!));
            List<RechargeSaleChartData> salesDataIam = data.iamChartDataDaily
              ..sort((a, b) => b.date!.compareTo(a.date!));
            var inwiOrangeIam = [
              data.oprtrRechargeSaleChartData(
                  'inwi', filteredRecharges.inwiList),
              data.oprtrRechargeSaleChartData(
                  'orange', filteredRecharges.orangeList),
              data.oprtrRechargeSaleChartData('iam', filteredRecharges.iamList)
            ];
            return SingleChildScrollView(
              child: Column(
                children: [
                  Wrap(
                    runSpacing: 15,
                    spacing: 15,
                    children: [
                      //const RechargeSalesInventoryWidget(),
                      RechargeSalesOverAllWidget(data: inwiOrangeIam),

                      BluredContainer(
                        height: 300,
                        width: 420,
                        child: RechargeSalePieChart(
                          data: inwiOrangeIam,
                          title: 'Stock',
                        ),
                      ),
                      BluredContainer(
                        height: 300,
                        width: 420,
                        child: RechargeSaleBarChart(
                          data: data.inwiChartDataDaily,
                          title: '',
                        ),
                      ),
                      BluredContainer(
                        height: 300,
                        width: 420,
                        child: RechargeSaleLineChart(
                          iamData: salesDataIam,
                          inwiData: salesDataInwi,
                          orangeData: salesDataOrange,
                          title: 'Stock',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: SalesListViewWidget(
                        fullRechargeSales: fullRechargeSales),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class SalesListViewWidget extends StatefulWidget {
  const SalesListViewWidget({
    Key? key,
    required this.fullRechargeSales,
  }) : super(key: key);

  final List<RechargeSaleModel> fullRechargeSales;

  @override
  State<SalesListViewWidget> createState() => _SalesListViewWidgetState();
}

class _SalesListViewWidgetState extends State<SalesListViewWidget> {
  List<RechargeSaleModel> _salesList = [];

  /// filter sales list
  void _filteredSalesList(String cat, String fTxt) {
    switch (cat) {
      case 'all':
        _salesList = widget.fullRechargeSales;
        break;
      case 'inwi':
        _salesList = widget.fullRechargeSales
          ..where((element) => element.oprtr == RechargeOperator.inwi);
        break;
      case 'orange':
        _salesList = widget.fullRechargeSales
          ..where((element) => element.oprtr == RechargeOperator.orange);
        break;
      case 'iam':
        _salesList = widget.fullRechargeSales
          ..where((element) => element.oprtr == RechargeOperator.iam);
        break;
      default:
        _salesList = widget.fullRechargeSales;
        break;
    }
  }

  @override
  void initState() {
    _salesList = widget.fullRechargeSales;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: context.width * 0.5,
      ),
      child: SizedBox(
        height: 570,
        width: context.width - 20,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchByWidget(
                withCategory: true,
                listOfCategories: RechargeOperator.values
                    .map((e) => e.name.toUpperCase())
                    .toList(),
                onChanged: _filteredSalesList,
              ),
            ),
            Expanded(
              child: BluredContainer(
                margin: const EdgeInsets.all(15),
                height: 570,
                width: context.width - 20,
                child: ListView.builder(
                  itemCount: widget.fullRechargeSales.length,
                  itemBuilder: (context, index) {
                    final RechargeSaleModel rechargeSaleModel =
                        _salesList[index];
                    return RechargeSaleListItem(
                      onUnSell: (rechargeModel) {
                        MDialogs.botomPopUpDialog(
                          context,
                          SizedBox(
                            height: 200,
                            width: 400,
                            child: Material(
                              child: Column(
                                children: [
                                  const Text(
                                    'Are you sure you want to unsell this recharge?',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          context
                                              .read<SellActionsRechargeBloc>()
                                              .add(
                                                UnsellRechargeRequestedEvent(
                                                    rechargeSaleModel:
                                                        rechargeSaleModel,
                                                    rechargeModel:
                                                        rechargeModel),
                                              );
                                          Navigator.canPop(context)
                                              ? Navigator.pop(context)
                                              : null;
                                        },
                                        child: const Text('Unsell'),
                                      ),
                                      const SizedBox(width: 10),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.canPop(context)
                                              ? Navigator.pop(context)
                                              : null;
                                        },
                                        child: const Text('Cancel'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      // onDelete: (rech) {
                      //   BlocProvider.of<RechargeBloc>(context)
                      //       .add(DeleteRechargeEvent(rechargeModel: rech));
                      // },
                      onEdit: (rech) {
                        MDialogs.dialogSimple(
                          context,
                          title: Text(
                            'Edit Recharge',
                            style: Theme.of(context).textTheme.headline3!,
                          ),
                          contentWidget: SizedBox(
                            width: 400,
                            child: SellRechargeWidget(
                              rechargeSale: rechargeSaleModel,
                              state: AddRechargeState.editing,
                              recharge: rech,
                            ),
                          ),
                        );
                      },
                      rechargeSale: _salesList[index],
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RechargeSalesInventoryWidget extends StatelessWidget {
  const RechargeSalesInventoryWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BluredContainer(
      height: 300,
      width: 420,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Icon(
                  Icons.phone_android,
                  color: Color.fromARGB(255, 254, 242, 255),
                  size: 30,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  'Recharge Sales',
                  style: Theme.of(context).textTheme.headline3,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RechargeSaleListItem extends StatelessWidget {
  final RechargeSaleModel rechargeSale;
  final void Function(RechargeModel rechargeModel)? onTap;
  //final void Function(RechargeModel) onDelete;
  final void Function(RechargeModel) onEdit;
  final void Function(RechargeModel) onUnSell;

  const RechargeSaleListItem({
    Key? key,
    required this.rechargeSale,
    this.onTap,
    //required this.onDelete,
    required this.onEdit,
    required this.onUnSell,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(motion: const ScrollMotion(), children: [
        SlidableAction(
          onPressed: (_) => onEdit(rechargeSale),
          backgroundColor: const Color.fromARGB(255, 73, 254, 163),
          foregroundColor: const Color.fromARGB(134, 255, 255, 255),
          borderRadius: BorderRadius.circular(10),
          icon: Icons.edit,
          label: 'Edit',
        ),
      ]),
      endActionPane: ActionPane(motion: const ScrollMotion(), children: [
        SlidableAction(
          onPressed: (_) => onUnSell(rechargeSale),
          backgroundColor: const Color.fromARGB(255, 254, 191, 73),
          foregroundColor: const Color.fromARGB(134, 255, 255, 255),
          borderRadius: BorderRadius.circular(10),
          icon: Icons.money_off_csred,
          label: 'Unsell',
        ),
        // SlidableAction(
        //   onPressed: (_) => onDelete(recharge),
        //   backgroundColor: const Color.fromARGB(255, 255, 0, 0),
        //   foregroundColor: const Color.fromARGB(134, 255, 255, 255),
        //   borderRadius: BorderRadius.circular(10),
        //   icon: Icons.delete,
        //   label: 'Delete',
        // ),
      ]),
      child: InkWell(
        onTap: (() => onTap!(rechargeSale)),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: RechargeModel.getOprtrColor(rechargeSale.oprtr),
              width: 1,
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        width: 37,
                        height: 37,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(50),
                          ),
                          color: Colors.white.withOpacity(0.5),
                        ),
                        child: Center(
                          child: Text(
                            '${rechargeSale.qnttSld}',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              rechargeSale.oprtr.name.toUpperCase(),
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            Text(
                              'on : ${rechargeSale.dateSld.ddmmyyyy()}',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${rechargeSale.amount} DH',
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          // Text(
                          //   'from : laayoun',
                          //   style: Theme.of(context).textTheme.subtitle2,
                          // ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                          color:
                              RechargeModel.getOprtrColor(rechargeSale.oprtr),
                          //color: Color.fromARGB(255, 254, 242, 255),
                        ),
                        width: 4,
                        height: 37,
                      ),
                    ],
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
