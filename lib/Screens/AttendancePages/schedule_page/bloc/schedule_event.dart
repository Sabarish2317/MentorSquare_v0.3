// ignore_for_file: non_constant_identifier_names

part of 'schedule_bloc.dart';

@immutable
sealed class ScheduleEvent {}

//the event initialises itself when the page loads

final class ScheduleListFetchEvent extends ScheduleEvent {
  final String selectedYear_id;
  final String selectedClass_id;
  final String selectedDay_id;

  ScheduleListFetchEvent(
      {required this.selectedYear_id,
      required this.selectedClass_id,
      required this.selectedDay_id});
}
