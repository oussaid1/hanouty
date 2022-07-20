import 'package:hanouty/components.dart';
import 'package:flutter/material.dart';

import '../../utils/glasswidgets.dart';

final selectedSearchProvider = StateProvider<String?>((ref) {
  return null;
});

class SearchCategorySpinner extends ConsumerWidget {
  const SearchCategorySpinner({
    Key? key,
    required this.list,
    required this.onChanged,
    required this.initialItem,
  }) : super(key: key);
  final List<String> list;
  final void Function(String) onChanged;
  final String initialItem;
  @override
  Widget build(BuildContext context, ref) {
    return SizedBox(
      width: 220.0,
      child: GlassContainer(
        child: DropdownButtonHideUnderline(
          child: ButtonTheme(
            alignedDropdown: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            child: DropdownButtonFormField<String>(
                isDense: true,
                elevation: 4,
                dropdownColor: const Color(0xff38B2F7),
                focusColor: const Color.fromARGB(0, 255, 255, 255),
                iconSize: 30,
                icon: const Icon(Icons.keyboard_arrow_down_sharp),
                //iconEnabledColor: MThemeData.accentColor,
                //iconDisabledColor: MThemeData.accentColor,
                isExpanded: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null) {
                    return 'Please select a category';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Select a category',
                  hintStyle: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Theme.of(context).colorScheme.primary),
                ),
                hint: Text(
                  'Search by'.tr(),
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                value: ref
                    .watch(selectedSearchProvider.state)
                    .state, //selecrtedValue,
                onChanged: (value) => onChanged(value!),
                // onChanged: (value) {
                //   selectedItem.state = value;
                //   switch (value) {
                //     case 'Name':
                //       ref.read(searchByProvider.state).state = SearchBy.name;
                //       break;
                //     case 'Barcode':
                //       ref.read(searchByProvider.state).state = SearchBy.barcode;
                //       break;
                //     case 'date':
                //       ref.read(searchByProvider.state).state = SearchBy.date;
                //       break;
                //     case 'Quantity':
                //       ref.read(searchByProvider.state).state =
                //           SearchBy.quantity;
                //       break;
                //     case 'Category':
                //       ref.read(searchByProvider.state).state =
                //           SearchBy.category;
                //       break;
                //     default:
                //       ref.read(searchByProvider.state).state = SearchBy.name;
                //   }
                // },
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
                              style: Theme.of(context).textTheme.subtitle2!,
                            ),
                          ),
                        ),
                      );
                    })
                    .toSet()
                    .toList()),
          ),
        ),
      ),
    );
  }
}
