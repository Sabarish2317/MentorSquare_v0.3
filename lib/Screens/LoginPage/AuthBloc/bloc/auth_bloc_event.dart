part of 'auth_bloc_bloc.dart';

sealed class AuthBlocEvent {}

//post request trigger
class LoginButtonPressedEvent extends AuthBlocEvent {
  final String emailId;
  final String password;

  LoginButtonPressedEvent({required this.emailId, required this.password});
}
