import 'dart:async';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:bloc/bloc.dart';

import 'package:mentor_square_v3_responsive/Screens/AttendancePages/year_dept_class_selection_widget/model/classes_data_model.dart';

part 'department_event.dart';
part 'department_state.dart';

class DepartmentBloc extends Bloc<DepartmentEvent, DepartmentState> {
  DepartmentBloc() : super(DepartmentInitialState()) {
    on<DeptButtonPressedEvent>(_departmentsDetailsFetechEvent);
  }

  FutureOr<void> _departmentsDetailsFetechEvent(
      DeptButtonPressedEvent event, Emitter<DepartmentState> emit) async {
    WidgetsFlutterBinding.ensureInitialized();
    const storage = FlutterSecureStorage();
    String ipAdd = await storage.read(key: 'ipAdd') ?? 'null';
//state is emitted to show the loading indic while fetching the api
    emit(DepartmentFetchingLoadingState());

//@variables and instances
    var client = http.Client();
    int selectedYear = event.selectedYear;
    int selectedDept = event.selectedDept;
    //variable to store all the responses as models
    List<ClassesDataModel> resultDatas = [];

//checking if the value is null
    if (selectedYear == 0) {
      emit(DepartmentsDetailExecuteErrorState(
          message: "Year value cannot be null or zero."));
      return;
    }

    final connectivityResult = await Connectivity().checkConnectivity();
    // ignore: unrelated_type_equality_checks
    if (connectivityResult == ConnectivityResult.none) {
      emit(DepartmentsDetailExecuteErrorState(
          message: "No internet connection available"));
      return;
    } else {
      try {
        var response = await client
            .get(Uri.parse(
                "http://$ipAdd:3000/MentorSquare/api/classes?year_name=$selectedYear&dept_id=$selectedDept"))
            .timeout(const Duration(seconds: 8), onTimeout: () {
          // Return an empty response or handle the timeout error
          return http.Response(
              'Request timeout : Check your internet connection', 408);
        });
        print("classess api :${response.statusCode}");
        if (response.statusCode != 200) {
          emit(DepartmentsDetailExecuteErrorState(
              message:
                  "Failed to fetch Class data. Status code: ${response.statusCode}"));
          return;
        }

        final result = jsonDecode(response.body);

        List<dynamic> decodedResult = result;

        for (int i = 0; i < decodedResult.length; i++) {
          ClassesDataModel tmpData = ClassesDataModel(
              classId: decodedResult[i]["Class_id"],
              className: decodedResult[i]["Class_Name"],
              departmentIdCc: decodedResult[i]["Department_id_CC"],
              yearIdCc: decodedResult[i]["Year_id_CC"]);

          resultDatas.add(tmpData);
        }
        emit(DepartmentDetailFetchingSuccessState(classes: resultDatas));
      } catch (e) {
        emit(DepartmentsDetailExecuteErrorState(
            message: "Failed to fetch departments data. Error: $e"));
      }
    }
  }
}
