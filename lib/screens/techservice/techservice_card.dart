import 'package:hanouty/models/techservice/techservice.dart';
import 'package:hanouty/screens/sell/sell_product_dialogue.dart';
import 'package:hanouty/screens/techservice/add_service.dart';
import 'package:hanouty/settings/themes.dart';
import 'package:hanouty/utils/glasswidgets.dart';
import 'package:flutter/material.dart';
import '../../blocs/techservicebloc/techservice_bloc.dart';
import '../../components.dart';
import '../../database/database_operations.dart';
import '../../models/Sale/sale.dart';
import '../../utils/popup_dialogues.dart';

class TechServiceListCard extends ConsumerWidget {
  const TechServiceListCard({Key? key, required this.techService})
      : super(key: key);
  final TechServiceModel techService;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BluredContainer(
        height: 54,
        child: Slidable(
            startActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  label: 'Sell'.tr(),
                  icon: Icons.price_check_rounded,
                  //color: MThemeData.productColor,
                  backgroundColor: Colors.transparent,
                  onPressed: (context) {
                    MDialogs.dialogSimple(
                      context,
                      title: Text(
                        "Sell : ".tr() + techService.title,
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(color: MThemeData.productColor),
                        textAlign: TextAlign.center,
                      ),
                      contentWidget: SizedBox(
                        height: 420,
                        width: 400,
                        child: SellProductDialoge(
                          product: techService,
                          saleType: SaleType.service,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  icon: Icons.edit_outlined,
                  // color: MThemeData.serviceColor,
                  backgroundColor: Colors.transparent,

                  label: 'Edit'.tr(),
                  onPressed: (context) {
                    MDialogs.dialogSimple(
                      context,
                      title: Text(
                        "Edit : ".tr() + techService.title,
                        style: Theme.of(context)
                            .textTheme
                            .headline3!
                            .copyWith(color: MThemeData.productColor),
                        textAlign: TextAlign.center,
                      ),
                      contentWidget: AddService(
                        techService: techService,
                      ),
                    );
                  },
                ),
                SlidableAction(
                  label: 'Delete'.tr(),
                  icon: Icons.clear,
                  //color: MThemeData.errorColor,
                  backgroundColor: Colors.transparent,
                  onPressed: (context) {
                    MDialogs.dialogSimple(
                      context,
                      title: Text(
                        " ${techService.title}",
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
                              var servBloc = TechServiceBloc(
                                  databaseOperations:
                                      GetIt.I<DatabaseOperations>());
                              servBloc.add(DeleteTechServiceEvent(techService));
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
            child: Theme(
              data: Theme.of(context).copyWith(
                dividerColor: Colors.transparent,
              ),
              child: ExpansionTile(
                leading: CircleAvatar(
                  backgroundColor: const Color.fromARGB(83, 255, 255, 255),
                  child: Text(
                    techService.title.substring(0, 1).toUpperCase(),
                    style: Theme.of(context).textTheme.headline3!,
                  ),
                ),
                title: Text(
                  techService.title,
                ),
                trailing: _buildAvailable(techService.available ?? false),
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            techService.title,
                          ),
                          RichText(
                            text: TextSpan(
                              text: ' Price-in :',
                              style: Theme.of(context).textTheme.subtitle2!,
                              children: [
                                TextSpan(
                                  text: ' ${techService.priceIn}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        color: MThemeData.serviceColor,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              text: ' Price-out :',
                              style: Theme.of(context).textTheme.subtitle2!,
                              children: [
                                TextSpan(
                                  text: ' ${techService.priceOut}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        color: MThemeData.expensesColor,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '${techService.description}',
                            style: Theme.of(context).textTheme.subtitle2!,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Widget _buildAvailable(bool value) {
    return value
        ? const SizedBox(
            width: 30,
            height: 30,
            child: Card(
              shape: CircleBorder(),
              color: Color.fromARGB(127, 76, 175, 79),
            ),
          )
        : const SizedBox(
            width: 30,
            height: 30,
            child: Card(
              shape: CircleBorder(),
              color: Color.fromARGB(127, 244, 67, 54),
            ),
          );
  }
}
