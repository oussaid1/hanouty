import 'package:flutter/material.dart';
import 'package:hanouty/components.dart';

import '../../blocs/bloc/date_filter_bloc.dart';
import '../../local_components.dart';
import '../../utils/constents.dart';

class RangeFilterSpinner extends StatelessWidget {
  const RangeFilterSpinner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        // margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: AppConstants.whiteOpacity,
        ),
        width: 120.0,
        //height: 40,
        child: buildFilterSelectMenu(context));
  }

  /// build popup menu
  Widget buildFilterSelectMenu(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<DateFilter>(
        alignment: Alignment.center,
        value: context.watch<DateFilterBloc>().state.filterType,
        onChanged: (value) {
          switch (value) {
            case DateFilter.all:
              context
                  .read<DateFilterBloc>()
                  .add(const UpdateFilterEvent(filterType: DateFilter.all));
              break;
            case DateFilter.custom:
              showDialog<void>(
                context: context,
                builder: (BuildContext bcontext) {
                  return AlertDialog(
                    title: const Text('Date Range Picker'),
                    content: SizedBox(
                      height: 300,
                      width: 400,
                      child: Material(
                        child: Scaffold(
                          body: SfDateRangePicker(
                              backgroundColor:
                                  Theme.of(context).backgroundColor,
                              showTodayButton: true,
                              rangeSelectionColor:
                                  MThemeData.accentColor.withOpacity(0.5),
                              initialSelectedDate: DateTime.now(),
                              initialDisplayDate: DateTime.now(),
                              todayHighlightColor: MThemeData.revenuColor,
                              selectionColor: MThemeData.accentColor,
                              selectionShape:
                                  DateRangePickerSelectionShape.rectangle,
                              selectionMode: DateRangePickerSelectionMode.range,
                              showActionButtons: true,
                              onCancel: () {
                                Navigator.pop(context);
                              },
                              onSubmit: (Object? range) {
                                var dateRange = range as PickerDateRange;

                                context
                                    .read<DateFilterBloc>()
                                    .add(UpdateFilterEvent(
                                      filterType: DateFilter.custom,
                                      dateRange: MDateRange(
                                        start: dateRange.startDate!,
                                        end: dateRange.endDate!,
                                      ),
                                    ));
                                Navigator.pop(context);
                              }),
                        ),
                      ),
                    ),
                  );
                },
              );
              break;

            case DateFilter.month:
              context
                  .read<DateFilterBloc>()
                  .add(const UpdateFilterEvent(filterType: DateFilter.month));
              break;
            default:
              context
                  .read<DateFilterBloc>()
                  .add(const UpdateFilterEvent(filterType: DateFilter.all));
          }
        },
        items: DateFilter.values.map((DateFilter value) {
          return DropdownMenuItem<DateFilter>(
              value: value,
              child: Text(
                value.name.tr(),
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.subtitle1!,
              ));
        }).toList(),
      ),
    );
  }
}

// class RangeFilterSpinner extends ConsumerWidget {
//   const RangeFilterSpinner({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     var selectedRangeFilter = ref.watch(rangeFilterProvider.state);
//     //final debtsData = ref.watch(debtsDataStateNotifierProvider.state).state;
//     return Container(
//       margin: const EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(50),
//         color: AppConstants.whiteOpacity,
//       ),
//       width: 100.0,
//       height: 40,
//       child: ButtonTheme(
//         alignedDropdown: true,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(AppConstants.radius),
//         ),
//         child: DropdownButtonFormField<FilterType>(
//             borderRadius: BorderRadius.circular(AppConstants.radius),
//             dropdownColor:
//                 const Color.fromARGB(202, 255, 255, 255).withOpacity(0.6),
//             alignment: Alignment.center,
//             autofocus: true,
//             isDense: true,
//             autovalidateMode: AutovalidateMode.always,
//             decoration: const InputDecoration(
//               border: InputBorder.none,
//               contentPadding: EdgeInsets.only(bottom: 20, left: 8),
//             ),
//             elevation: 4,
//             icon: Container(), // const Icon(Icons.keyboard_arrow_down_sharp),
//             // isExpanded: true,
//             value: selectedRangeFilter.state,
//             onChanged: (value) {
//               selectedRangeFilter.state = value!;
//               if (value == FilterType.custom) {
//                 ref.read(rangeFilterIsCustomProvider.state).state = true;
//               } else {
//                 ref.read(rangeFilterIsCustomProvider.state).state = false;
//               }
//               // debtsData.filterDebts();
//             },
//             items: FilterType.values
//                 .map((itemName) {
//                   return DropdownMenuItem<FilterType>(
//                     value: itemName,
//                     child: Text(
//                       itemName.toString().split('.').last.tr(),
//                       textAlign: TextAlign.start,
//                       style: Theme.of(context).textTheme.subtitle1!,
//                     ),
//                   );
//                 })
//                 .toSet()
//                 .toList()),
//       ),
//     );
//   }
// }
