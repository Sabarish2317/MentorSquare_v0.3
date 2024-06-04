part of 'student_details_bloc.dart';

@immutable
sealed class StudentDetailsEvent {}

final class SearchButtonPresseddEvent extends StudentDetailsEvent {
  final String studentRegNo;

  SearchButtonPresseddEvent({required this.studentRegNo});
}
