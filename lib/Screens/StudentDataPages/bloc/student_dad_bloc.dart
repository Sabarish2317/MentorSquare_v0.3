import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mentor_square_v3_responsive/Screens/StudentDataPages/models/student_dad_model.dart';

part 'student_dad_event.dart';
part 'student_dad_state.dart';

class StudentDadBloc extends Bloc<StudentDadEvent, StudentDadState> {
  StudentDadBloc() : super(StudentDadInitial()) {
    on<StudentDadFetchEvent>(studentDadFetchEvent);
  }

  FutureOr<void> studentDadFetchEvent(
      StudentDadFetchEvent event, Emitter<StudentDadState> emit) async {
    WidgetsFlutterBinding.ensureInitialized();
    const storage = FlutterSecureStorage();
    String ipAdd = await storage.read(key: 'ipAdd') ?? 'null';
    emit(StudentDadLoadingState());
    var client = http.Client();

    try {
      String apiUrl = '$ipAdd/attentiveAid/api/students/Attendance/daily';
      final response = await http
          .post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body:
            jsonEncode({"sem_no": event.semNo, "student_id": event.studentId}),
      )
          .timeout(const Duration(seconds: 2), onTimeout: () {
        // Return an empty response or handle the timeout error
        return http.Response(
            'Request timeout : Check your internet connection', 408);
      });
      print("sutdent dad: ${response.statusCode}");
      if (response.statusCode == 200) {
        final List<Attendance> resultData = [];
        final result = jsonDecode(response.body);
        print(result);

        for (int i = 0; i < result.length; i++) {
          Attendance tmpData = Attendance(
              attendanceId: result[i]['Attendance_id'],
              studentId: result[i]['Student_id_DAT'],
              semesterNo: result[i]['Semester_No'],
              date: result[i]['Date'].split('T')[0],
              dayId: result[i]['Day_id_DAT'],
              period1Status: result[i]['Period1_Status'],
              period2Status: result[i]['Period2_status'],
              period3Status: result[i]['Period3_Status'],
              period4Status: result[i]['Period4_Status'],
              period5Status: result[i]['Period5_Status'],
              period6Status: result[i]['Period6_Status'],
              period7Status: result[i]['Period7_Status'],
              period8Status: result[i]['Period8_Status']);

          resultData.add(tmpData);
        }
        emit(StudentDaduccessState(resultData: resultData));
        // emit(StudentDaduccessState(resultData: resultData));
      } else if (response.statusCode == 408) {
        emit(StudentDadErrorState(
            errorCode: 408,
            errorMessage:
                "Connection timed out : check your internet connection ${response.statusCode}"));
      } else if (response.statusCode == 404) {
        emit(StudentDadErrorState(
            errorCode: 404,
            errorMessage:
                "Enter valid Register Number or select valid semester"));
      }
    } catch (e) {
      print(e);
      // Error occurred during authentication process
      emit(StudentDadErrorState(
          errorCode: 400,
          errorMessage: "Unknown Error occured || Status Code : 400 "));
    } finally {
      client.close();
    }
  }
}
