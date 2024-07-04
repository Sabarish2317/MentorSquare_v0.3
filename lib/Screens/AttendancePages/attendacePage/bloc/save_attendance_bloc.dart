import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

part 'save_attendance_event.dart';
part 'save_attendance_state.dart';

class SaveAttendanceBloc
    extends Bloc<SaveAttendanceEvent, SaveAttendanceState> {
  SaveAttendanceBloc() : super(SaveAttendanceInitialState()) {
    on<SaveAttendanceButtonPresses>(_saveAttendanceEvent);
  }

  FutureOr<void> _saveAttendanceEvent(SaveAttendanceButtonPresses event,
      Emitter<SaveAttendanceState> emit) async {
    WidgetsFlutterBinding.ensureInitialized();
    const storage = FlutterSecureStorage();
    String ipAdd = await storage.read(key: 'ipAdd') ?? 'null';

    print('mark attendacne bloc activated');

    //temporary response code to give fot erros
    int responseCode = 500;
    //
    //
    var client = http.Client();
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult == ConnectivityResult.none) {
        emit(SaveAttendanceErrorState(
            errorCode: 503, errorMessage: "No internet connection available"));
      } else {
        String apiUrl = '$ipAdd/MentorSquare/api/mark_attendance';
        print("semo no ${event.semNo}");
        final response = await http
            .post(
          Uri.parse(apiUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'date': event.date,
            'day': "${event.day}",
            'semno': "${event.semNo}",
            'periodno': "${event.periodNo}",
            'subjectid': "${event.subjectId}",
            'auth': "Bearer ${event.auth}",
            'subjectclip': event.subjectClip,
            'staffid': "${event.staffId}",
          },
          body: jsonEncode(event.attStatus),
        )
            .timeout(
          const Duration(seconds: 8),
          onTimeout: () {
            // Return an empty response or handle the timeout error
            return http.Response('Request timeout', 408);
          },
        );

        if (response.statusCode == 200) {
          print('success');
          emit(SaveAttendanceSuccessState(
              responseData: "Maerked attendance successfully"));
        } else {
          responseCode = response.statusCode;
          emit(SaveAttendanceErrorState(
              errorMessage: "Unable to retrive the student data",
              errorCode: responseCode));
        }
      }
    } catch (e) {
      emit(SaveAttendanceErrorState(
          errorMessage: "Unable to retrive the student data",
          errorCode: responseCode));
    } finally {
      client.close();
    }
  }
}
