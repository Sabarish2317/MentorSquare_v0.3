part of 'save_attendance_bloc.dart';

@immutable
sealed class SaveAttendanceEvent {}

final class SaveAttendanceButtonPresses extends SaveAttendanceEvent {
  final String date;
  final int day;
  final int semNo;
  final int periodNo;
  final int subjectId;
  final String subjectClip;
  final int staffId;
  final String auth;

  final List<Map<String, dynamic>> attStatus;

  SaveAttendanceButtonPresses(
      {required this.date,
      required this.attStatus,
      required this.semNo,
      required this.day,
      required this.periodNo,
      required this.subjectId,
      required this.subjectClip,
      required this.staffId,
      required this.auth});
}
