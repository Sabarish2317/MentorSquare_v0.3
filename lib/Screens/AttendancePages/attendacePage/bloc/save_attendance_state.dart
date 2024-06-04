part of 'save_attendance_bloc.dart';

@immutable
sealed class SaveAttendanceState {}

//initial state
final class SaveAttendanceInitialState extends SaveAttendanceState {}

//loading state
final class SaveAttendanceLoadingstate extends SaveAttendanceState {}

//error state
final class SaveAttendanceErrorState extends SaveAttendanceState {
  final String errorMessage;
  final int errorCode;

  SaveAttendanceErrorState(
      {required this.errorMessage, required this.errorCode});
}

//success state
final class SaveAttendanceSuccessState extends SaveAttendanceState {
  final String responseData;

  SaveAttendanceSuccessState({required this.responseData});
}
