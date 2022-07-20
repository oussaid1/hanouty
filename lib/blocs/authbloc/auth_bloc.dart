import 'package:equatable/equatable.dart';

import '../../components.dart';
import '../../services/auth_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late AuthService _authService;
  AuthBloc(AuthService authService) : super(AuthInitState()) {
    _authService = authService;
    on<AuthLoadingEvent>(_onAuthLoading);
    on<AuthSuccessfulEvent>(_onAuthSuccessful);
    on<NotAuthenticatedEvent>(_onNotAuthenticated);
    on<AuthFailedEvent>(_onAuthFailed);
    _authService.currentUser.listen((event) {
      if (event != null) {
        add(AuthSuccessfulEvent(user: event));
      } else {
        add(NotAuthenticatedEvent());
      }
    });
  }

  void _onAuthLoading(AuthLoadingEvent event, Emitter<AuthState> emit) async {
    emit(AthenticatingState());
  }

  void _onAuthSuccessful(
      AuthSuccessfulEvent event, Emitter<AuthState> emit) async {
    emit(AuthenticatedState(user: event.user!));
  }

  void _onAuthFailed(AuthFailedEvent event, Emitter<AuthState> emit) async {
    emit(AuthenticationFailedState(error: event.error));
  }

  void _onNotAuthenticated(
      NotAuthenticatedEvent event, Emitter<AuthState> emit) async {
    emit(UnauthenticatedState());
  }
}
