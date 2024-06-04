part of 'student_sad_bloc.dart';

@immutable
sealed class StudentSadEvent {}

final class StudentSADfetchEvent extends StudentSadEvent {
  final StudentDetail studentDetail;
  final int semNo;

  StudentSADfetchEvent(this.semNo, {required this.studentDetail});
}
