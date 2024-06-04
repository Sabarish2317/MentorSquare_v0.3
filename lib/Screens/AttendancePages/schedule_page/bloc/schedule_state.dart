part of 'schedule_bloc.dart';

@immutable
sealed class ScheduleState {}

final class ScheduleInitialState extends ScheduleState {}

//state emitted when entered into the bloc
final class ScheduleinitialState extends ScheduleState {}

//state emitted when trying to fetch the api
final class ScheduleFetchingLoadingState extends ScheduleState {}

//state emitted when an error is responded
final class ScheduleApiFetchErrorState extends ScheduleState {
  final String message;
  final int errorCode;

  ScheduleApiFetchErrorState({required this.message, required this.errorCode});
}

//state emitted when an error occured during the bloc method
final class ScheduleFetchErrorState extends ScheduleState {
  final String message;

  ScheduleFetchErrorState({required this.message});
}

// state when the api runs sucessfully mothafucker
final class ScheduleFetchingSuccessState extends ScheduleState {
  final List<ScheduleModel> scheduleData;

  ScheduleFetchingSuccessState({required this.scheduleData});
}
