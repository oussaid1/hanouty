import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hanouty/local_components.dart';
import '../../blocs/datefilterbloc/date_filter_bloc.dart';
import '../../components.dart';

class DateRangePicker extends StatelessWidget {
  const DateRangePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DateFilterBloc, DateFilterState>(
      // buildWhen: (previous, current) =>
      //     previous.dateRange != current.dateRange && current.dateRange != null,
      builder: (context, state) {
        if (state.filterType == DateFilter.custom && state.dateRange != null) {
          log('custom date range is ${state.dateRange}');
          return Wrap(
            direction: Axis.horizontal,
            children: [
              Text(
                (state.dateRange ?? MDateRange.empty).start.ddmmyyyy(),
              ),
              const Text(
                '-',
              ),
              Text((state.dateRange ?? MDateRange.empty).end.ddmmyyyy()),
            ],
          );
        }

        return Container();
      },
    );
  }
}
