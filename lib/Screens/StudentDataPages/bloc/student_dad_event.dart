part of 'student_dad_bloc.dart';

@immutable
sealed class StudentDadEvent {}

final class StudentDadFetchEvent extends StudentDadEvent {
  final String semNo;
  final String studentId;

  StudentDadFetchEvent({required this.semNo, required this.studentId});
}
