part of 'auth_bloc_bloc.dart';

sealed class AuthBlocState {}

//INITIAL STATE
class AuthenticationInitialState extends AuthBlocState {}

//LOADING STATE
final class AuthenticationLoadingState extends AuthBlocState {}

//SUCCESS STATE RA
class AuthenticationSuccessState extends AuthBlocState {
  final StaffLoginResponseModel loginReponseList;

  AuthenticationSuccessState(this.loginReponseList);
}

//ERROR STATE
class AuthenticationErrorState extends AuthBlocState {
  final int errorCode;
  final String errorMessage;

  AuthenticationErrorState(
      {required this.errorCode, required this.errorMessage});
}

//failure
class AuthenticationFailureState extends AuthBlocState {
  final int errorCode;
  final String errorMessage;

  AuthenticationFailureState(
      {required this.errorCode, required this.errorMessage});
}
