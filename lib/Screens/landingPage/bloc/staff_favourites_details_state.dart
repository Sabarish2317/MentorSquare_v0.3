part of 'staff_favourites_details_bloc.dart';

@immutable
sealed class StaffFavouritesDetailsState {}

final class StaffFavouritesDetailsInitialState
    extends StaffFavouritesDetailsState {}

//state while fetching the data from api
final class StaffFavouritesDetailsFetchingLoadingState
    extends StaffFavouritesDetailsState {}

//error from api
final class StaffFavouritesDetailsFetchingErrorState
    extends StaffFavouritesDetailsState {
  final int errorCode;
  final String errorMessage;

  StaffFavouritesDetailsFetchingErrorState(
      {required this.errorCode, required this.errorMessage});
}

//error while fetching the api
final class StaffFavouritesDetailsExecuteErrorState
    extends StaffFavouritesDetailsState {
  final String message;

  StaffFavouritesDetailsExecuteErrorState({required this.message});
}

//state when the result is successfully detched
final class StaffFavouritesDetailsFetchingSuccessState
    extends StaffFavouritesDetailsState {
  final List<StudentDetail> studentsDetails;

  StaffFavouritesDetailsFetchingSuccessState({required this.studentsDetails});
}
