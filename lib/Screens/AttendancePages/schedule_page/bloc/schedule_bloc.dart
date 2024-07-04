// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:bloc/bloc.dart';
import 'package:mentor_square_v3_responsive/Screens/AttendancePages/schedule_page/model/schedule_model.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  ScheduleBloc() : super(ScheduleInitialState()) {
    on<ScheduleListFetchEvent>(_scheduleDataFetch);
  }

  FutureOr<void> _scheduleDataFetch(
      ScheduleListFetchEvent event, Emitter<ScheduleState> emit) async {
    WidgetsFlutterBinding.ensureInitialized();
    const storage = FlutterSecureStorage();
    String ipAdd = await storage.read(key: 'ipAdd') ?? 'null';
    // State is emitted to show the loading indicator while fetching the API
    emit(ScheduleFetchingLoadingState());

    // Variables and instances
    var client = http.Client();

    try {
      // Validate and parse inputs
      int selectedYear_id = int.parse(event.selectedYear_id);
      int selectedClass_id = int.parse(event.selectedClass_id);
      int selectedDay_id = int.parse(event.selectedDay_id);

      // Variable to store all the responses as models
      List<ScheduleModel> resultDatas = [];

      // Check connectivity
      final connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult == ConnectivityResult.none) {
        emit(ScheduleFetchErrorState(
            message: "No internet connection available"));
        return;
      } else {
        // Posting an HTTP request
        String apiUrl = '$ipAdd/MentorSquare/api/schedule';

        final response = await http.post(
          Uri.parse(apiUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            "year_id": selectedYear_id,
            "class_id": selectedClass_id,
            "day_id": selectedDay_id,
          }),
        );

        // Handle response
        if (response.statusCode == 200) {
          print('schedule api :200');
          final decodedResult = jsonDecode(response.body);

          // Modeling the result
          for (int i = 0; i < decodedResult.length; i++) {
            ScheduleModel tmpData = ScheduleModel(
                className: decodedResult[i]["Class_Name"],
                dayName: decodedResult[i]["day_name"],
                periodNo: decodedResult[i]["Period_No"],
                subjectClip: decodedResult[i]["Subject_Clip"],
                subjectCode: decodedResult[i]["Subject_code"],
                subjectIdSt: decodedResult[i]["Subject_id_ST"],
                subjectName: decodedResult[i]["subject_name"]);
            resultDatas.add(tmpData);
          }
          emit(ScheduleFetchingSuccessState(scheduleData: resultDatas));
        } else {
          emit(ScheduleApiFetchErrorState(
              errorCode: response.statusCode, message: 'An error has occured'));
        }
      }
    } catch (e) {
      // Handle parsing errors
      emit(ScheduleFetchErrorState(
          message: "Unable to fetch the data. Error: $e"));
    } finally {
      client.close();
    }
  }
}
