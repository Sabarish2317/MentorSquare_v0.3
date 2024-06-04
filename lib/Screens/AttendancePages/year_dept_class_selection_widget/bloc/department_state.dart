part of 'department_bloc.dart';

@immutable
sealed class DepartmentState {}

//listeners
abstract class DepartmentListActionState extends DepartmentState {}

//initial state
final class DepartmentInitialState extends DepartmentState {}

//api fetch state
final class DepartmentFetchingLoadingState extends DepartmentState {}

//error from api
final class DepartmentFetchingErrorState extends DepartmentState {
  final int errorCode;
  final String errorMessage;

  DepartmentFetchingErrorState(
      {required this.errorCode, required this.errorMessage});
}

//error while fetching the api
final class DepartmentsDetailExecuteErrorState extends DepartmentState {
  final String message;

  DepartmentsDetailExecuteErrorState({required this.message});
}

//state when the result is successfully detched
final class DepartmentDetailFetchingSuccessState extends DepartmentState {
  final List<ClassesDataModel> classes;

  DepartmentDetailFetchingSuccessState({required this.classes});
}
