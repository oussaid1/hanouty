import 'package:flutter/material.dart';
import 'package:hanouty/components.dart';

import '../../blocs/clientsbloc/clients_bloc.dart';
import '../../local_components.dart';
import 'add_client.dart';

class ShopClientsList extends ConsumerWidget {
  const ShopClientsList({Key? key}) : super(key: key);

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
          label: const Text("Add").tr(),
        ),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<ShopClientBloc, ShopClientState>(
          builder: (context, state) {
            if (state.status == ShopClientsStatus.loaded) {
              List<ShopClientModel> clientsList = state.clients;
              return Column(
                children: [
                  Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: SingleChildScrollView(
                        child: SizedBox(
                          height: 800,
                          width: 400,
                          child: ListView.builder(
                            itemCount: clientsList.length,
                            itemBuilder: (context, index) {
                              final ShopClientModel shopClient =
                                  clientsList[index];
                              return Slidable(
                                startActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  dismissible:
                                      DismissiblePane(onDismissed: () {}),
                                  children: [
                                    SlidableAction(
                                      onPressed: (context) {
                                        MDialogs.dialogSimple(
                                          context,
                                          title: Text(
                                            "Edit techService".tr(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline3!,
                                          ),
                                          contentWidget: SizedBox(
                                            height: 400,
                                            width: 400,
                                            child: AddClient(
                                              client: shopClient,
                                              pContext: context,
                                            ),
                                          ),
                                        );
                                      },
                                      icon: Icons.delete,
                                      label: 'Edit',
                                    ),
                                  ],
                                ),
                                endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  dismissible:
                                      DismissiblePane(onDismissed: () {}),
                                  children: [
                                    SlidableAction(
                                      onPressed: (context) {
                                        MDialogs.dialogSimple(
                                          context,
                                          title: Text(
                                            " ${shopClient.clientName}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline3!,
                                          ),
                                          contentWidget: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              ElevatedButton(
                                                style: MThemeData
                                                    .raisedButtonStyleSave,
                                                child: Text(
                                                  'Delete'.tr(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!,
                                                ),
                                                onPressed: () {},
                                              ),
                                              ElevatedButton(
                                                style: MThemeData
                                                    .raisedButtonStyleCancel,
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
                                      icon: Icons.delete,
                                      label: 'Edit',
                                    ),
                                  ],
                                ),
                                child: Card(
                                  child: ListTile(
                                    leading: const Icon(
                                      Icons.person_outline_outlined,
                                      color: MThemeData.accentColor,
                                    ),
                                    title: Text(
                                      '${shopClient.clientName}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline3!,
                                    ),
                                    trailing: Text(
                                      '${shopClient.email}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!,
                                    ),
                                    subtitle: Text(
                                      '${shopClient.phone}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      )),
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
