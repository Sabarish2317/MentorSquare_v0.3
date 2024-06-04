part of 'staff_detail_bloc.dart';

@immutable
sealed class StaffDetailState {}

//LISTENERS
abstract class StaffDetailActionState extends StaffDetailState {}

final class StaffDetailInitialState extends StaffDetailState {}

//state while fetching the data from api
final class StaffDetailFetchingLoadingState extends StaffDetailState {}

//error from api
final class StaffDetailFetchingErrorState extends StaffDetailState {
  final int errorCode;
  final String errorMessage;

  StaffDetailFetchingErrorState(
      {required this.errorCode, required this.errorMessage});
}

//error while fetching the api
final class StaffDetailExecuteErrorState extends StaffDetailState {
  final String message;

  StaffDetailExecuteErrorState({required this.message});
}

//state when the result is successfully detched
final class StaffDetailFetchingSuccessState extends StaffDetailState {
  final StaffDetailInitialFetchModel staffData;

  StaffDetailFetchingSuccessState({required this.staffData});
}
