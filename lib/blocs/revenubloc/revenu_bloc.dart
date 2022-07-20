import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'revenu_event.dart';
part 'revenu_state.dart';

class RevenuBloc extends Bloc<RevenuEvent, RevenuState> {
  RevenuBloc() : super(RevenuInitial()) {
    on<RevenuEvent>((event, emit) {});
  }
}
