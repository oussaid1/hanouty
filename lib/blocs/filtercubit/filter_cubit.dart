import 'package:hanouty/models/daterange.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../models/enums/enums.dart';

part 'filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit() : super(const FilterState(FilterType.all, null));

  /// updateFilter() is used to update the state.
  void updateFilter(FilterType status, MDateRange? dateRange) {
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
