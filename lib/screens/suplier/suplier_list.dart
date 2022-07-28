import 'package:hanouty/screens/suplier/add_suplier.dart';
import 'package:hanouty/settings/themes.dart';
import 'package:hanouty/utils/popup_dialogues.dart';
import 'package:flutter/material.dart';
import 'package:hanouty/components.dart';

import '../../blocs/suplierbloc/suplier_bloc.dart';
import '../../models/suplier/suplier.dart';

class SupliersList extends ConsumerWidget {
  const SupliersList({Key? key}) : super(key: key);

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
                "Add Suplier",
                style: Theme.of(context).textTheme.headline3!,
              ),
              contentWidget: const SizedBox(
                height: 400,
                width: 600,
                child: AddSuplier(),
              ),
            );
          },
          label: const Text("Add").tr(),
        ),
      ),
      body: BlocBuilder<SuplierBloc, SuplierState>(
        builder: (context, state) {
          return Column(
            children: [
              SingleChildScrollView(
                child: SizedBox(
                  height: 800,
                  width: 400,
                  child: ListView.builder(
                    itemCount: state.supliers.length,
                    itemBuilder: (context, index) {
                      final SuplierModel suplier = state.supliers[index];
                      return Slidable(
                        startActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.edit_outlined,
                                color: MThemeData.serviceColor,
                              ),
                              onPressed: () {
                                MDialogs.dialogSimple(
                                  context,
                                  title: Text(
                                    "Edit Suplier".tr(),
                                    style:
                                        Theme.of(context).textTheme.headline3!,
                                  ),
                                  contentWidget: const SizedBox(
                                    height: 400,
                                    width: 400,
                                    child: AddSuplier(
                                      suplier: null,
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
                            IconButton(
                              icon: const Icon(
                                Icons.clear,
                                color: MThemeData.errorColor,
                              ),
                              onPressed: () {
                                MDialogs.dialogSimple(
                                  context,
                                  title: Text(
                                    "${suplier.name}",
                                    style:
                                        Theme.of(context).textTheme.headline3!,
                                  ),
                                  contentWidget: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton(
                                        style: MThemeData.raisedButtonStyleSave,
                                        child: Text(
                                          'Delete'.tr(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!,
                                        ),
                                        onPressed: () {
                                          // ref
                                          //     .read(databaseProvider)!
                                          //     .deleteSuplier(suplier)
                                          //     .then((value) {
                                          //   if (value) {
                                          //     ScaffoldMessenger.of(context)
                                          //         .showSnackBar(MDialogs.snackBar(
                                          //             'Done !'));

                                          //     Navigator.of(context).pop();
                                          //   } else {
                                          //     ScaffoldMessenger.of(context)
                                          //         .showSnackBar(
                                          //             MDialogs.errorSnackBar(
                                          //                 'Error !'));
                                          //   }
                                          // });
                                        },
                                      ),
                                      ElevatedButton(
                                        style:
                                            MThemeData.raisedButtonStyleCancel,
                                        child: Text(
                                          'Cancel'.tr(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!,
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
                            leading: const Icon(
                              Icons.location_on_outlined,
                              color: MThemeData.accentColor,
                            ),
                            title: Text(
                              '${suplier.name}',
                              style: Theme.of(context).textTheme.headline3!,
                            ),
                            trailing: Text(
                              '${suplier.email}',
                              style: Theme.of(context).textTheme.subtitle2!,
                            ),
                            subtitle: Text(
                              '${suplier.phone}',
                              style: Theme.of(context).textTheme.subtitle2!,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
