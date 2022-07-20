import 'package:hanouty/models/techservice/techservice.dart';

import 'package:hanouty/screens/techservice/add_service/add_service.dart';

import 'package:hanouty/settings/themes.dart';
import 'package:hanouty/utils/glasswidgets.dart';
import 'package:flutter/material.dart';

import '../../components.dart';
import '../../utils/popup_dialogues.dart';

class TechServiceListCard extends ConsumerWidget {
  const TechServiceListCard({Key? key, required this.techService})
      : super(key: key);
  final TechServiceModel techService;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Slidable(
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              label: 'Sell'.tr(),
              icon: Icons.price_check_rounded,
              //color: MThemeData.productColor,
              backgroundColor: Colors.transparent,
              onPressed: (context) {
                // ref.read(priceSoldForProvider.state).state =
                //     techService.priceOut;
                // ref.read(pickedDateTime.state).state = DateTime.now();
                // // set the variables to be used in the dialogue
                // // and show the dialogue

                // MDialogs.dialogSimple(
                //   context,
                //   title: Text(
                //     "Sell : ".tr() + techService.title,
                //     style: Theme.of(context)
                //         .textTheme
                //         .headline3!
                //         .copyWith(color: MThemeData.productColor),
                //     textAlign: TextAlign.center,
                //   ),
                //   contentWidget: SizedBox(
                //     height: 420,
                //     width: 400,
                //     child: SellTechServiceDialoge(
                //       isUpdate: false,
                //       techService: techService,
                //     ),
                //   ),
                // );
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
                // set the variables to be used in the dialogue
                // ref.read(pickedDateTime.state).state = techService.timeStamp;
                // ref.read(techServAvailProvider.state).state =
                //     techService.available!;
                // ref.read(techServiceTypeProvider.state).state =
                //     techService.type;
                // ref.read(pickedDateTime.state).state = techService.timeStamp;
                // ref.read(selectedSelectOrAddCat.state).state = techService.type;

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
                  contentWidget: SizedBox(
                    height: 400,
                    width: 400,
                    child: AddService(
                      techService: techService,
                    ),
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
                          // ref
                          //     .read(databaseProvider)!
                          //     .deleteTechService(techService)
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
        child: GlassContainer(
          child: ExpansionTile(
            leading: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Text(
                techService.title.substring(0, 1).toUpperCase(),
                style: Theme.of(context).textTheme.headline3!,
              ),
            ),
            title: Text(
              techService.title,
            ),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildAvailable(techService.available ?? false),
                Text(
                  techService.type.toString(),
                  style: Theme.of(context).textTheme.subtitle2!,
                ),
              ],
            ),
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 10,
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
        ));
  }

  Widget _buildAvailable(bool value) {
    return value
        ? const SizedBox(
            width: 20,
            height: 20,
            child: Card(
              shape: CircleBorder(),
              color: Colors.green,
            ),
          )
        : const SizedBox(
            width: 20,
            height: 20,
            child: Card(
              shape: CircleBorder(),
              color: Colors.red,
            ),
          );
  }
}
