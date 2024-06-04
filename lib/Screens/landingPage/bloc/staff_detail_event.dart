part of 'staff_detail_bloc.dart';

@immutable
sealed class StaffDetailEvent {}

//inital bloc
final class InitalFetchEvent extends StaffDetailEvent {
  final int staffId;

  InitalFetchEvent({required this.staffId});
}
