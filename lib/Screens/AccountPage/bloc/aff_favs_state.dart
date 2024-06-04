part of 'aff_favs_bloc.dart';

@immutable
sealed class AffFavsState {}

final class AffFavsInitial extends AffFavsState {}

//initial state
final class AffFavsInitialState extends AffFavsState {}

//api fetch state
final class AffFavsFetchingLoadingState extends AffFavsState {}

//error from api
final class AffFavsFetchingErrorState extends AffFavsState {
  final int errorCode;
  final String errorMessage;

  AffFavsFetchingErrorState(
      {required this.errorCode, required this.errorMessage});
}

//error while fetching the api
final class AffFavssDetailExecuteErrorState extends AffFavsState {
  final String message;

  AffFavssDetailExecuteErrorState({required this.message});
}

//state when the result is successfully detched
final class AffFavsDetailFetchingSuccessState extends AffFavsState {
  final String responseMessage;

  AffFavsDetailFetchingSuccessState({required this.responseMessage});
}
