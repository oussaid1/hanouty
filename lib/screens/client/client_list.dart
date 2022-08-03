import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hanouty/components.dart';
import 'package:hanouty/widgets/search_widget.dart';

import '../../blocs/clientsbloc/clients_bloc.dart';
import '../../local_components.dart';
import 'add_client.dart';

class ShopClientsList extends StatefulWidget {
  const ShopClientsList({Key? key}) : super(key: key);

  @override
  State<ShopClientsList> createState() => _ShopClientsListState();
}

class _ShopClientsListState extends State<ShopClientsList> {
  String filter = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.only(bottom: 80.0),
      //   child: FloatingActionButton.extended(
      //     icon: const Icon(Icons.add),
      //     onPressed: () {
      //       MDialogs.dialogSimple(
      //         context,
      //         title: Text(
      //           "Add Client",
      //           style: Theme.of(context).textTheme.headline3!,
      //         ),
      //         contentWidget: const AddClient(),
      //       );
      //     },
      //     label: const Text("Add").tr(),
      //   ),
      // ),
      body: SingleChildScrollView(
        child: BlocBuilder<ShopClientBloc, ShopClientState>(
          builder: (context, state) {
            if (state.status == ShopClientsStatus.loaded) {
              List<ShopClientModel> clientsList = state.clients
                ..where((e) => e.clientName!
                    .toLowerCase()
                    .contains(filter.toLowerCase())).toList();
              return Column(
                children: [
                  const SizedBox(height: 20),
                  SearchByWidget(
                      listOfCategories: const [
                        "Name",
                        "Phone",
                        "Email",
                      ],
                      onChanged: (cat, txt) {
                        setState(() {
                          filter = txt;
                        });
                      }),
                  const SizedBox(height: 20),
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxHeight: 600,
                      maxWidth: 600,
                      minWidth: 420,
                    ),
                    child: BluredContainer(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: clientsList.length,
                          itemBuilder: (context, index) {
                            final ShopClientModel shopClient =
                                clientsList[index];
                            return Slidable(
                              key: Key(shopClient.id!),
                              startActionPane: ActionPane(
                                motion: const ScrollMotion(),
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
                                      BlocProvider.of<ShopClientBloc>(context)
                                          .add(DeleteShopClientEvent(
                                              shopClient));
                                    },
                                    icon: Icons.delete,
                                    label: 'Delete',
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
                                    style:
                                        Theme.of(context).textTheme.headline3!,
                                  ),
                                  trailing: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${shopClient.email}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!,
                                      ),
                                    ],
                                  ),
                                  subtitle: buildRating(context),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
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

  buildRating(BuildContext context, {double rating = 0}) {
    return RatingBar.builder(
      initialRating: 3,
      ignoreGestures: true,
      itemSize: 24,
      minRating: rating,
      maxRating: rating,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {},
    );
  }
}
