import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:mentor_square_v3_responsive/Screens/AttendancePages/attendacePage/model/students_list.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'get_students_list_event.dart';
part 'get_students_list_state.dart';

class GetStudentsListBloc
    extends Bloc<GetStudentsListEvent, GetStudentsListState> {
  GetStudentsListBloc() : super(GetStudentsListInitialState()) {
    on<GetStudentListActionEvent>(_getStudentList);
  }

  FutureOr<void> _getStudentList(GetStudentListActionEvent event,
      Emitter<GetStudentsListState> emit) async {
    WidgetsFlutterBinding.ensureInitialized();
    const storage = FlutterSecureStorage();
    String ipAdd = await storage.read(key: 'ipAdd') ?? 'null';
    emit(GetStudentsListsLoadingState());
    int responseCode = 500;
    var client = http.Client();
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult == ConnectivityResult.none) {
        emit(GetStudentsListFailedState(
            errorCode: 503, errorMessage: "No internet connection available"));
      } else {
        var response = await client.get(Uri.parse(
            'http://$ipAdd:3000/MentorSquare/api/students?class_id=${event.classId}'));
        print("get students list page api : ${response.statusCode}");

        if (response.statusCode == 200) {
          List<StudentsList> studentsListData = [];
          final result = jsonDecode(response.body);

          for (int i = 0; i < result.length; i++) {
            StudentsList tmpData = StudentsList(true,
                classIdDt: result[i]['Class_Id_DT'],
                departmentIdDt: result[i]['Department_Id_DT'],
                studentIdDt: result[i]['Student_id_DT'],
                studentName: result[i]['Student_Name'],
                studentRegNo: result[i]['Student_RegNO'],
                yearIdDt: result[i]['Year_Id_DT']);
            studentsListData.add(tmpData);
          }
          emit(GetStudentsListSuccesState(studentsList: studentsListData));
          print(studentsListData[0].studentName);
        } else {
          responseCode = response.statusCode;
          emit(GetStudentsListFailedState(
              errorMessage: "Unable to retrive the student data",
              errorCode: responseCode));
        }
      }
    } catch (e) {
      emit(GetStudentsListFailedState(
          errorMessage: "Unable to retrive the student data",
          errorCode: responseCode));
    } finally {
      client.close();
    }
  }
}
