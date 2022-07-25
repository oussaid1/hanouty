// import 'dart:async';
// import 'dart:developer';

// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';

// import '../../models/Sale/sale.dart';
// import '../../models/daterange.dart';
// import '../../models/enums/date_filter.dart';
// import '../fullsalesbloc/fullsales_bloc.dart';

// part 'filteredsales_state.dart';
// part 'filteredsales_event.dart';

// class FilteredSalesBloc extends Bloc<FilteredSalesEvent, FilteredSalesState> {
//   final FullSalesBloc _fullSalesBloc;
//   late final StreamSubscription<FullSalesState> _fullSalesSubscription;

//   FilteredSalesBloc(this._fullSalesBloc)
//       : super(const FilteredSalesState(
//           filterType: DateFilter.all,
//           filteredSales: [],
//         )) {
//     on<GetFilteredSaleEvent>(_getFilteredSale);
//     on<LoadFilteredSalesEvent>(onFilteredSalesAll);
//   }

//   ///on getFiltered
//   _getFilteredSale(
//       GetFilteredSaleEvent event, Emitter<FilteredSalesState> emitter) async {
//     _fullSalesSubscription = _fullSalesBloc.stream.listen((state) {
//       log('FilteredSalesBloc _getFilteredSale state: ${state.status}');
//       add(LoadFilteredSalesEvent(
//           filterType: event.filterType, filteredSales: state.fullSales));
//     });
//   }

//   /// onFilteredSalesAll
//   onFilteredSalesAll(
//       LoadFilteredSalesEvent event, Emitter<FilteredSalesState> emit) async {
//     switch (event.filterType) {
//       case DateFilter.all:
//         emit(state.copyWith(
//             filterType: DateFilter.all, filteredSales: event.filteredSales));
//         break;
//       case DateFilter.month:
//         emit(state.copyWith(
//             filterType: DateFilter.all,
//             filteredSales: event.filteredSales
//                 .where(
//                     (element) => element.dateSold.month == DateTime.now().month)
//                 .toList()));
//         break;
//       case DateFilter.custom:
//         emit(FilteredSalesState(
//             filterType: event.filterType,
//             dateRange: event.dateRange,
//             filteredSales: Sales(
//                 sales: event.filteredSales.salesByDateRange(
//                     event.dateRange!.start, event.dateRange!.end))));
//         break;
//     }
//   }

//   @override
//   Future<void> close() {
//     _fullSalesSubscription.cancel();
//     return super.close();
//   }
// }
