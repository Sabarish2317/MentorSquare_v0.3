part of 'department_bloc.dart';

@immutable
sealed class DepartmentEvent {}

//when the year is selected departments are sent back belonging to that year

final class DeptButtonPressedEvent extends DepartmentEvent {
  //passng the year data
  final int selectedYear;
  final int selectedDept;

  DeptButtonPressedEvent(
      {required this.selectedDept, required this.selectedYear});
}
