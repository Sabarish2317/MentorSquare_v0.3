part of 'student_sad_bloc.dart';

@immutable
sealed class StudentSadState {}

final class StudentSadInitialState extends StudentSadState {}

final class StudentSadLoadingState extends StudentSadState {}

final class StudentSadSuccessState extends StudentSadState {
  final List<StudentSad> resultData;

  StudentSadSuccessState({required this.resultData});
}

final class StudentSadErrorState extends StudentSadState {
  final int errorCode;
  final String errorMessage;

  StudentSadErrorState({required this.errorCode, required this.errorMessage});
}
