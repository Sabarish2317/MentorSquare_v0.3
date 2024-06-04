part of 'staff_detail_bloc.dart';

@immutable
sealed class StaffDetailEvent {}

//get user's name and register number.
class StaffDetailInitialFetchEvent extends StaffDetailEvent {}
