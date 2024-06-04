part of 'get_students_list_bloc.dart';

@immutable
sealed class GetStudentsListEvent {}

final class GetStudentListActionEvent extends GetStudentsListEvent {
  final int classId;

  GetStudentListActionEvent({required this.classId});
}
