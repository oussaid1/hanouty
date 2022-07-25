import 'package:flutter/material.dart';
import 'package:hanouty/local_components.dart';

import '../../blocs/fullsalesbloc/fullsales_bloc.dart';
import '../../components.dart';

class DateRangePicker extends ConsumerWidget {
  const DateRangePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BlocBuilder<FullSalesBloc, FullSalesState>(
      builder: (context, state) {
        if (state.status == FullSalesStatus.loaded) {
          // if (state.filterType == DateFilter.custom) {
          //   return Container();
          // }
          return MaterialButton(
            child: Wrap(
              direction: Axis.horizontal,
              children: [
                Text((state.dateRange ?? MDateRange.empty).start.ddmmyyyy(),
                    style: Theme.of(context).textTheme.subtitle2!),
                Text((state.dateRange ?? MDateRange.empty).end.ddmmyyyy(),
                    style: Theme.of(context).textTheme.subtitle2!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface)),
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
                                    .read<FilteredSalesBloc>()
                                    .add(FilterSalesByCustomEvent(
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
            },
          );
        }

        return Container();
      },
    );
  }
}
