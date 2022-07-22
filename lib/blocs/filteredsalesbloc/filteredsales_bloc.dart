import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/Sale/sale.dart';
import '../../models/daterange.dart';
import '../../models/enums/date_filter.dart';
import '../fullsalesbloc/fullsales_bloc.dart';

part 'filteredsales_state.dart';
part 'filteredsales_event.dart';

class FilteredSalesBloc extends Bloc<FilteredSalesEvent, FilteredSalesState> {
  final FullSalesBloc _fullSalesBloc;
  late final StreamSubscription<FullSalesState> _fullSalesSubscription;

  FilteredSalesBloc(this._fullSalesBloc) : super(FilteredSalesInitial()) {
    on<GetFilteredSaleDataEvent>(_getFilteredSaleData);
    on<LoadFilteredSalesEvent>(onFilteredSalesAll);
  }

  ///on getFiltered
  _getFilteredSaleData(GetFilteredSaleDataEvent event,
      Emitter<FilteredSalesState> emitter) async {
    _fullSalesBloc.stream.listen((state) {
      add(LoadFilteredSalesEvent(
          filterType: event.filterType,
          filteredSales: FilteredSales(sales: state.fullSales)));
    });
  }

  /// onFilteredSalesAll
  onFilteredSalesAll(
      LoadFilteredSalesEvent event, Emitter<FilteredSalesState> emit) async {
    switch (event.filterType) {
      case DateFilter.all:
        emit(FilteredSalesLoadedState(
            filterType: event.filterType,
            filteredSalesData: SalesData(sales: event.filteredSales.sales)));
        break;
      case DateFilter.month:
        emit(FilteredSalesLoadedState(
            filterType: event.filterType,
            filteredSalesData:
                SalesData(sales: event.filteredSales.salesThisMonth)));
        break;
      case DateFilter.custom:
        emit(FilteredSalesLoadedState(
            filterType: event.filterType,
            dateRange: event.dateRange,
            filteredSalesData: SalesData(
                sales: event.filteredSales.salesByDateRange(
                    event.dateRange!.start, event.dateRange!.end))));
        break;
    }
  }
}
