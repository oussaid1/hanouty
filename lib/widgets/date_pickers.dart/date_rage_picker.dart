import 'package:hanouty/blocs/filtercubit/filter_cubit.dart';
import 'package:hanouty/local_components.dart';
import 'package:flutter/material.dart';

import '../../components.dart';

class DateRangePicker extends ConsumerWidget {
  const DateRangePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final dateRangeState = ref.watch(selectedDateRangeStateNotifier);
    final filterState = context.watch<FilterCubit>().state;
    return MaterialButton(
      child: Wrap(
        direction: Axis.horizontal,
        children: [
          Text((filterState.dateRange ?? MDateRange.empty).start.ddmmyyyy(),
              style: Theme.of(context).textTheme.subtitle2!),
          Text((filterState.dateRange ?? MDateRange.empty).end.ddmmyyyy(),
              style: Theme.of(context)
                  .textTheme
                  .subtitle2!
                  .copyWith(color: Theme.of(context).colorScheme.onSurface)),
        ],
      ),
      onPressed: () {
        showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Date Range Picker'),
              content: SizedBox(
                height: 300,
                width: 400,
                child: Material(
                  child: Scaffold(
                    body: SfDateRangePicker(
                        backgroundColor: Theme.of(context).backgroundColor,
                        showTodayButton: true,
                        rangeSelectionColor:
                            MThemeData.accentColor.withOpacity(0.5),
                        initialSelectedDate: DateTime.now(),
                        initialDisplayDate: DateTime.now(),
                        todayHighlightColor: MThemeData.revenuColor,
                        selectionColor: MThemeData.accentColor,
                        selectionShape: DateRangePickerSelectionShape.rectangle,
                        selectionMode: DateRangePickerSelectionMode.range,
                        showActionButtons: true,
                        onCancel: () {
                          Navigator.pop(context);
                        },
                        onSubmit: (Object? range) {
                          var dateRange = range as PickerDateRange;
                          context.read<FilterCubit>().updateFilter(
                              FilterType.custom,
                              MDateRange(
                                  start: dateRange.startDate!,
                                  end: dateRange.endDate!));
                          Navigator.pop(context);
                        }),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
