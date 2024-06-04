part of 'get_students_list_bloc.dart';

@immutable
sealed class GetStudentsListState {}

//initital
final class GetStudentsListInitialState extends GetStudentsListState {}

//state when the api request is being fettched
final class GetStudentsListsLoadingState extends GetStudentsListState {}

//state when the api is success
final class GetStudentsListSuccesState extends GetStudentsListState {
  final List<StudentsList> studentsList;

  GetStudentsListSuccesState({required this.studentsList});
}

//state when the api has errors
final class GetStudentsListFailedState extends GetStudentsListState {
  final String errorMessage;
  final int errorCode;

  GetStudentsListFailedState(
      {required this.errorMessage, required this.errorCode});
}
