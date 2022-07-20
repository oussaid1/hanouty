import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/daterange.dart';
import '../../models/enums/date_filter.dart';

part 'filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit() : super(const FilterState(FilterType.all, null));

  /// updateFilter() is used to update the state.
  void updateFilter({required FilterType status, MDateRange? dateRange}) {
    emit(state.copyWith(status: status, dateRange: dateRange));
  }

  // @override
  // FilterState? fromJson(Map<String, dynamic> json) {
  //   return FilterState.fromJson(json);
  // }

  // @override
  // Map<String, dynamic>? toJson(FilterState state) {
  //   return state.toJson();
  // }
}
