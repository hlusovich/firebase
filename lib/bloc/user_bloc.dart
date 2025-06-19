import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

// Events
@immutable
sealed class UserEvent {}

class LoginEvent extends UserEvent {
  final String email;
  final String password;

  LoginEvent(this.email, this.password);
}

class LogoutEvent extends UserEvent {}

// States
@immutable
sealed class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserAuthenticated extends UserState {
  final String email;

  UserAuthenticated(this.email);
}

class UserError extends UserState {
  final String message;

  UserError(this.message);
}

// BLoC
class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<LoginEvent>(_onLogin);
    on<LogoutEvent>(_onLogout);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      // Mock login logic
      if (event.email.isNotEmpty) {
        await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
        emit(UserAuthenticated(event.email));
      } else {
        emit(UserError('Email cannot be empty'));
      }
    } catch (e) {
      emit(UserError('An error occurred during login'));
    }
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    emit(UserInitial());
  }
}