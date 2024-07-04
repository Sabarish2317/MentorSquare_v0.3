import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:bloc/bloc.dart';

import 'package:mentor_square_v3_responsive/Screens/StudentDataPages/models/student_detail_model.dart';

part 'student_details_event.dart';
part 'student_details_state.dart';

class StudentDetailsBloc
    extends Bloc<StudentDetailsEvent, StudentDetailsState> {
  StudentDetailsBloc() : super(StudentDetailsInitialState()) {
    on<SearchButtonPresseddEvent>(_searchButtonPressedEvent);
  }

  FutureOr<void> _searchButtonPressedEvent(SearchButtonPresseddEvent event,
      Emitter<StudentDetailsState> emit) async {
    WidgetsFlutterBinding.ensureInitialized();
    const storage = FlutterSecureStorage();
    String ipAdd = await storage.read(key: 'ipAdd') ?? 'null';
    print("searching started");
    emit(StudentDetailsLoadingState());
    var client = http.Client();

    try {
      String apiUrl = '$ipAdd/MentorSquare/api/students';
      print("trying to get student data");
      final response = await http
          .post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'student_regNo': event.studentRegNo

          // Add any other data you want to send in the body
        }),
      )
          .timeout(const Duration(seconds: 2), onTimeout: () {
        // Return an empty response or handle the timeout error
        return http.Response(
            'Request timeout : Check your internet connection', 408);
      });
      print("code: ${response.statusCode}");
      if (response.statusCode == 200) {
        // Authentication successful

        final result = jsonDecode(response.body);

        StudentDetail tmpData = StudentDetail(
            studentIdDt: result[0]['Student_id_DT'],
            studentRegNo: result[0]['Student_RegNO'],
            studentName: result[0]['Student_Name'],
            classIdDt: result[0]['Class_Id_DT'],
            departmentIdDt: result[0]['Department_Id_DT'],
            yearIdDt: result[0]['Year_Id_DT'],
            yearName: result[0]['Year_Name'],
            className: result[0]['Class_Name']);

        emit(StudentDetailSuccessState(resultData: tmpData));
      } else if (response.statusCode == 408) {
        emit(StudentDetailErrorState(
            errorCode: 408,
            errorMessage:
                "Connection timed out : check your internet connection ${response.statusCode}"));
      } else if (response.statusCode == 404) {
        emit(StudentDetailErrorState(
            errorCode: 404,
            errorMessage:
                "The student id cannot be found please enter valid register number ${response.statusCode}"));
      }
    } catch (e) {
      print(e);
      // Error occurred during authentication process
      emit(StudentDetailErrorState(
          errorCode: 400,
          errorMessage: "Unknown Error occured || Status Code : 400 "));
    } finally {
      client.close();
    }
  }
}
