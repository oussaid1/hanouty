import 'package:hanouty/models/client/shop_client.dart';
import 'package:flutter/material.dart';
import 'package:hanouty/components.dart';

import 'package:hanouty/settings/themes.dart';

import '../../blocs/clientsbloc/clients_bloc.dart';

class ClientSpinnerWidget extends StatelessWidget {
  const ClientSpinnerWidget({
    Key? key,
    required this.list,
    required this.onChanged,
    this.initialValue,
  }) : super(key: key);
  final List<ShopClientModel> list;
  final Function(ShopClientModel) onChanged;
  final ShopClientModel? initialValue;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopClientBloc, ShopClientState>(
      builder: (context, state) {
        return DropdownButtonHideUnderline(
          child: ButtonTheme(
            alignedDropdown: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: DropdownButton<ShopClientModel>(
                hint: const Text('select client').tr(),
                elevation: 4,
                iconSize: 30,
                icon: const Icon(Icons.keyboard_arrow_down_sharp),
                iconEnabledColor: MThemeData.accentColor,
                iconDisabledColor: MThemeData.accentColor,
                isExpanded: true,
                value: initialValue,
                onChanged: ((value) => onChanged.call(value!)),
                items: state.clients
                    .toSet()
                    .map((shopClient) {
                      return DropdownMenuItem<ShopClientModel>(
                        value: shopClient,
                        child: SizedBox(
                          width: 100,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4.0, right: 4),
                            child: Text(
                              shopClient.clientName!,
                              textAlign: TextAlign.start,
                              style: Theme.of(context).textTheme.subtitle2!,
                            ),
                          ),
                        ),
                      );
                    })
                    .toSet()
                    .toList()),
          ),
        );
      },
    );
  }
}
