import 'package:hanouty/local_components.dart';
import 'package:hanouty/utils/constents.dart';
import 'package:flutter/material.dart';

import '../components.dart';

class SearchByWidget extends StatefulWidget {
  final bool withCategory;
  final List<String> listOfCategories;
  final void Function(String)? onChanged;
  final String? initialCategoryValue;
  final void Function(String searchText) onSearchTextChanged;
  final void Function(String catg, String searchText) onBothChanged;

  //final String searchText;
  const SearchByWidget({
    Key? key,
    this.withCategory = false,
    required this.listOfCategories,
    this.onChanged,
    required this.onSearchTextChanged,
    required this.onBothChanged,

    /// required this.searchText,
    this.initialCategoryValue,
  }) : super(key: key);

  @override
  State<SearchByWidget> createState() => _SearchByWidgetState();
}

class _SearchByWidgetState extends State<SearchByWidget> {
  String searchText = '';
  String? selectedCategory;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        (widget.withCategory)
            ? SizedBox(
                width: 200,
                child: Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),

                    /// a dropdown button with a list of categories
                    child: DropdownButtonFormField<String>(
                      borderRadius: BorderRadius.circular(10),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: 'category',
                      ),
                      dropdownColor: Colors.white.withOpacity(0.8),
                      value: selectedCategory,
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedCategory = newValue!;
                        });
                        widget.onBothChanged.call(newValue!, searchText);
                      },
                      items: widget.listOfCategories
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ))
            : const SizedBox.shrink(),
        Expanded(
          flex: 2,
          child: SizedBox(
            width: 300,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (fillterText) {
                  widget.onSearchTextChanged(fillterText);
                  widget.onBothChanged(
                    selectedCategory!,
                    fillterText,
                  );
                },
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: context.theme.primary),
                decoration: InputDecoration(
                  disabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: const BorderSide(
                        //  color: Colors.transparent,
                        color: Colors.transparent,
                      )),
                  suffixIcon: const Icon(
                    Icons.search_outlined,
                    size: 18,
                  ),
                  hintText: 'Search'.tr(),
                  contentPadding:
                      const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  filled: true,
                  fillColor: AppConstants.whiteOpacity,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
