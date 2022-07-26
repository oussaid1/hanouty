import 'package:flutter/material.dart';

import '../../blocs/techservicebloc/techservice_bloc.dart';
import '../../components.dart';

import '../../models/techservice/techservice.dart';

import '../../utils/popup_dialogues.dart';

import '../techservice/add_service.dart';
import '../techservice/service_listview.dart';

class TechServiceList extends ConsumerWidget {
  const TechServiceList({
    Key? key,
    this.techServicesList,
  }) : super(key: key);
  final List<TechServiceModel>? techServicesList;

  @override
  Widget build(BuildContext context, ref) {
    // List<TechService> techServicesList = ref.watch(techServicesProvider.state).state;

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
            label: const Text("Add").tr(),
          ),
        ),
        body: SingleChildScrollView(
          child: BlocBuilder<TechServiceBloc, TechServiceState>(
              builder: (context, state) {
            if (state.status == TechServiceStatus.loaded) {
              var techServicesList = state.techservices;

              return SizedBox(
                width: 700,
                height: 700,
                child: TechServiceListView(
                  techServiceList: techServicesList,
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
        ));
  }
}
