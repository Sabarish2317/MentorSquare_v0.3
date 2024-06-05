part of 'student_dad_bloc.dart';

@immutable
sealed class StudentDadState {}

final class StudentDadInitial extends StudentDadState {}

final class StudentDadInitialState extends StudentDadState {}

final class StudentDadLoadingState extends StudentDadState {}

final class StudentDaduccessState extends StudentDadState {
  final List<Attendance> resultData;

  StudentDaduccessState({required this.resultData});
}

final class StudentDadErrorState extends StudentDadState {
  final String errorMessage;
  final int errorCode;

  StudentDadErrorState({required this.errorMessage, required this.errorCode});
}
