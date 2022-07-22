import 'package:flutter/material.dart';
import 'package:hanouty/blocs/filteredsalesbloc/filteredsales_bloc.dart';
import 'package:hanouty/components.dart';

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
    return DropdownButton<DateFilter>(
      onChanged: (value) {
        switch (value) {
          case DateFilter.all:
            context
                .read<FilteredSalesBloc>()
                .add(const FilterSalesAutoState(filterType: DateFilter.custom));
            break;
          case DateFilter.custom:
            context.read<FilteredSalesBloc>().add(FilterSalesByCustomEvent(
                  filterType: DateFilter.custom,
                  dateRange: MDateRange(
                    start: DateTime.now().subtract(const Duration(days: 30)),
                    end: DateTime.now(),
                  ),
                ));
            break;
          // case FilterType.today:
          //   context.read(filterCubit).setFilter(FilterType.today);
          //   break;
          // case FilterType.week:
          //   context.read(filterCubit).setFilter(FilterType.week);
          //   break;
          case DateFilter.month:
            context
                .read<FilteredSalesBloc>()
                .add(const FilterSalesAutoState(filterType: DateFilter.custom));
            break;
          default:
            break;
        }
      },
      items: DateFilter.values.map((DateFilter value) {
        return DropdownMenuItem<DateFilter>(
            value: value,
            child: Text(
              DateFilter.custom.name.tr(),
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.subtitle1!,
            ));
      }).toList(),
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
