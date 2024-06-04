part of 'student_details_bloc.dart';

@immutable
sealed class StudentDetailsState {}

final class StudentDetailsInitialState extends StudentDetailsState {}

final class StudentDetailsLoadingState extends StudentDetailsState {}

final class StudentDetailSuccessState extends StudentDetailsState {
  final StudentDetail resultData;

  StudentDetailSuccessState({required this.resultData});
}

final class StudentDetailErrorState extends StudentDetailsState {
  final String errorMessage;
  final int errorCode;

  StudentDetailErrorState(
      {required this.errorMessage, required this.errorCode});
}
