import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:bloc/bloc.dart';
import 'package:mentor_square/Features/StaffDetail/models/Staff_detail_model.dart';
import 'package:meta/meta.dart';

part 'staff_detail_event.dart';
part 'staff_detail_state.dart';

class StaffDetailsBloc
    extends Bloc<StaffDetailInitialFetchEvent, StaffDetailsState> {
  StaffDetailsBloc() : super(StaffDetailInititalState()) {
    on<StaffDetailInitialFetchEvent>(_staffDetailInitialFetchEvent);
  }

  Future<void> _staffDetailInitialFetchEvent(StaffDetailInitialFetchEvent event,
      Emitter<StaffDetailsState> emit) async {
    emit(StaffDetailFetchingLoadingState());
    var client = http.Client();
    List<StaffDetailInitialFetchModel> staffDetails = [];
    try {
      var response = await client.get(Uri.parse(
          'http://192.168.29.16:3000/MentorSquare/api/staffs?staff_id =9'));
      if (response.statusCode == 200) {
        List result = jsonDecode(response.body);
        for (int i = 0; i < result.length; i++) {
          StaffDetailInitialFetchModel staffDetail =
              StaffDetailInitialFetchModel.fromJson(
                  result[i] as Map<String, dynamic>);
          staffDetails.add(staffDetail);
        }
        //emitting if the event is succeeded
        emit(StaffDetailFetchingSuccessfulState(staffDetails: staffDetails));
      } else {
        //tempo using print for testing
        //need to add error use cases and caching
        emit(StaffDetailFetchingNotFoundState(errorCode: response.statusCode));
        print(
            "Failed to fetch the details : error code : ${response.statusCode}");
      }
    } catch (e) {
      emit(StaffDetailFetchingErrorState());
      print(e.toString());
    } finally {
      client.close();
    }
  }
}
