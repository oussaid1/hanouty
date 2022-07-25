import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/models.dart';

part 'date_filter_event.dart';
part 'date_filter_state.dart';

class DateFilterBloc extends Bloc<DateFilterEvent, DateFilterState> {
  DateFilterBloc() : super(DateFilterInitial()) {
    on<DateFilterEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
