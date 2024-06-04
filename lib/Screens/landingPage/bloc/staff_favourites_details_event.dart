part of 'staff_favourites_details_bloc.dart';

@immutable
sealed class StaffFavouritesDetailsEvent {}

final class StaffFavouritesDetailsGetEvent extends StaffFavouritesDetailsEvent {
  final String regNos;

  StaffFavouritesDetailsGetEvent({required this.regNos});
}
