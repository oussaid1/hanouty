import 'package:hanouty/providers/var_provider.dart';
import 'package:flutter/material.dart';
import 'package:hanouty/components.dart';

import 'package:hanouty/settings/themes.dart';

class SpinnerWidget extends ConsumerWidget {
  const SpinnerWidget({Key? key, required this.hint, required this.list})
      : super(key: key);
  final List<String> list;

  final String hint;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedItem = ref.watch(selectedItemProvider.state);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(6),
        color: Theme.of(context).colorScheme.secondary,
      ),
      width: 220.0,
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButton<String>(
              hint: Text(hint),
              elevation: 4,
              focusColor: MThemeData.accentColor,
              iconSize: 30,
              icon: const Icon(Icons.keyboard_arrow_down_sharp),
              iconEnabledColor: MThemeData.accentColor,
              iconDisabledColor: MThemeData.accentColor,
              isExpanded: true,
              value: selectedItem.state,
              onChanged: (value) {
                selectedItem.state = value;
              },
              items: list
                  .toSet()
                  .map((itemName) {
                    return DropdownMenuItem<String>(
                      value: itemName,
                      child: SizedBox(
                        width: 100,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 4.0, right: 4),
                          child: Text(
                            itemName,
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.bodyText1!,
                          ),
                        ),
                      ),
                    );
                  })
                  .toSet()
                  .toList()),
        ),
      ),
    );
  }
}
