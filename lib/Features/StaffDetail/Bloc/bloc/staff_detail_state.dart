part of 'staff_detail_bloc.dart';

@immutable
//builders
abstract class StaffDetailsState {}

//listeners
abstract class StaffDetailActionState extends StaffDetailsState {}

final class StaffDetailInititalState extends StaffDetailsState {}

//state while the api fetching is done
class StaffDetailFetchingLoadingState extends StaffDetailsState {}

//error state
class StaffDetailFetchingErrorState extends StaffDetailsState {}

//state when the fetching of getStaff api is successfull
class StaffDetailFetchingNotFoundState extends StaffDetailsState {
  final int errorCode;
  StaffDetailFetchingNotFoundState({required this.errorCode});
}

class StaffDetailFetchingSuccessfulState extends StaffDetailsState {
  //list containing the modeled json to list
  final List<StaffDetailInitialFetchModel> staffDetails;

  StaffDetailFetchingSuccessfulState({required this.staffDetails});
}
