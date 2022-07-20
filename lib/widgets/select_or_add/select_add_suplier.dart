import 'package:hanouty/providers/var_provider.dart';
import 'package:hanouty/settings/themes.dart';
import 'package:flutter/material.dart';

import '../../components.dart';

// ignore: must_be_immutable
class SelectOrAddNewSuplier extends ConsumerStatefulWidget {
  SelectOrAddNewSuplier(
      {Key? key,
      this.labelText,
      this.hintText,
      required this.onSaved,
      required this.spinnerList})
      : super(key: key);
  List<String>? spinnerList;
  final String Function(String) onSaved;
  final String? hintText;
  final String? labelText;

  @override
  ConsumerState<SelectOrAddNewSuplier> createState() => _SelectOrAddNew1State();
}

class _SelectOrAddNew1State extends ConsumerState<SelectOrAddNewSuplier> {
  String? selectedItem;
  bool isNew = false;
  @override
  Widget build(BuildContext context) {
    //final selec = ref.watch(selectedSelectOrAdd1);
    final isNew = ref.watch(isNewSelectOrAddSuplier);
    return Column(children: [
      Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(6)),
        child: SizedBox(
          width: 300.0,
          child: DropdownButtonHideUnderline(
            child: ButtonTheme(
              alignedDropdown: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButton<String>(
                  hint: Text(
                    'select'.tr(),
                    style: Theme.of(context).textTheme.bodyText1!,
                  ).tr(),
                  elevation: 4,
                  focusColor: MThemeData.accentColor,
                  iconSize: 30,
                  icon: const Icon(Icons.keyboard_arrow_down_sharp),
                  iconEnabledColor: MThemeData.accentColor,
                  iconDisabledColor: MThemeData.accentColor,
                  isExpanded: true,
                  value:
                      selectedItem, //ref.read(selectedSelectOrAddSuplier.state).state,
                  onChanged: (value) {
                    setState(() {
                      selectedItem = value!;
                      ref.read(selectedSelectOrAddSuplier.state).state = value;
                      widget.onSaved(value);
                      value == ("new")
                          ? ref.read(isNewSelectOrAddSuplier.state).state = true
                          : ref.read(isNewSelectOrAddSuplier.state).state =
                              false;
                    });

                    // ref.read(selectOrAddBoolSelectedItemFinal.state).state = value;
                  },
                  items: widget.spinnerList!
                      .toSet()
                      .map((itemName) {
                        return DropdownMenuItem<String>(
                          value: itemName,
                          child: SizedBox(
                            width: 100,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 4.0, right: 4),
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
        ),
      ),
      const SizedBox(height: 8),
      isNew ? SizedBox(child: _buildTextForm(ref)) : const SizedBox.shrink()
    ]);
  }

  Widget _buildTextForm(WidgetRef ref) {
    return SizedBox(
      width: 200,
      height: 80,
      child: TextFormField(
        validator: (text) {
          if (text!.trim().isEmpty) {
            return "error".tr();
          }
          return null;
        },
        onChanged: (value) {
          setState(() {
            widget.onSaved(value);
            ref.read(selectedSelectOrAddSuplier.state).state = value;
          });
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: const BorderSide(),
          ),
          hintText: widget.hintText,
          hintStyle: Theme.of(context).textTheme.subtitle2!,
          contentPadding: const EdgeInsets.only(top: 4),
          prefixIcon: const Icon(Icons.card_travel_outlined),
          filled: true,
          labelText: widget.labelText,
        ),
      ),
    );
  }
}
