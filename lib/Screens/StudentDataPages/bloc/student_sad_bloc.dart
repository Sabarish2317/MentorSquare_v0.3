import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:bloc/bloc.dart';
import 'package:mentor_square_v3_responsive/Screens/StudentDataPages/models/student_detail_model.dart';
import 'package:mentor_square_v3_responsive/Screens/StudentDataPages/models/student_sad_model.dart';

part 'student_sad_event.dart';
part 'student_sad_state.dart';

class StudentSadBloc extends Bloc<StudentSadEvent, StudentSadState> {
  StudentSadBloc() : super(StudentSadInitialState()) {
    on<StudentSADfetchEvent>(_studentSadEvent);
  }

  FutureOr<void> _studentSadEvent(
      StudentSADfetchEvent event, Emitter<StudentSadState> emit) async {
    WidgetsFlutterBinding.ensureInitialized();
    const storage = FlutterSecureStorage();
    String ipAdd = await storage.read(key: 'ipAdd') ?? 'null';
    print("searching started");
    emit(StudentSadLoadingState());
    var client = http.Client();
    List<StudentSad> studentSad = [];
    try {
      String apiUrl =
          'http://$ipAdd:3000/attentiveAid/api/students/Attendance/subjects';
      print("trying to get student subject attednance data");
      final response = await http
          .post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "student_id": event.studentDetail.studentIdDt,
          "sem_no": event.semNo
        }),
      )
          .timeout(const Duration(seconds: 5), onTimeout: () {
        // Return an empty response or handle the timeout error
        return http.Response(
            'Request timeout : Check your internet connection', 408);
      });
      print("student sad code : ${response.statusCode}");
      if (response.statusCode == 200) {
        // Authentication successful

        final result = jsonDecode(response.body);
        for (int i = 0; i < result.length; i++) {
          double percentage = result[i]['Subject_Percentage'] is int
              ? (result[i]['Subject_Percentage'] as int).toDouble()
              : result[i]['Subject_Percentage'] as double;
          StudentSad tmpdata = StudentSad(
              periodAttendanceId: result[i]['Period_Attendance_id'],
              studentIdPat: result[i]['Student_id_PAT'],
              semNo: result[i]['sem_no'],
              subjectIdPat: result[i]['Subject_id_PAT'],
              presentClassCount: result[i]['Present_Class_Count'],
              totalClassCount: result[i]['Total_Class_Count'],
              subjectPercentage: percentage,
              subjectId: result[i]['Subject_id'],
              subjectCode: result[i]['Subject_code'],
              subjectName: result[i]['Subject_name'],
              subjectClip: result[i]['Subject_Clip']);

          studentSad.add(tmpdata);
        }
        print(studentSad);
        emit(StudentSadSuccessState(resultData: studentSad));
      } else if (response.statusCode == 408) {
        emit(StudentSadErrorState(
            errorCode: 408,
            errorMessage:
                "Connection timed out : check your internet connection ${response.statusCode}"));
      } else if (response.statusCode == 404) {
        emit(StudentSadErrorState(
            errorCode: 404,
            errorMessage:
                "Please enter valid register number or Change semester "));
      }
    } catch (e) {
      print(e);
      // Error occurred during authentication process
      emit(StudentSadErrorState(
          errorCode: 400,
          errorMessage: "Unknown Error occured || Status Code : 400 "));
    } finally {
      client.close();
    }
  }
}
