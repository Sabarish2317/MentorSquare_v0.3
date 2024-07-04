import 'dart:async';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mentor_square_v3_responsive/Screens/StudentDataPages/models/student_detail_model.dart';

part 'staff_favourites_details_event.dart';
part 'staff_favourites_details_state.dart';

class StaffFavouritesDetailsBloc
    extends Bloc<StaffFavouritesDetailsEvent, StaffFavouritesDetailsState> {
  StaffFavouritesDetailsBloc() : super(StaffFavouritesDetailsInitialState()) {
    on<StaffFavouritesDetailsGetEvent>(staffFavouritesDetailsEvent);
  }

  FutureOr<void> staffFavouritesDetailsEvent(
      StaffFavouritesDetailsGetEvent event,
      Emitter<StaffFavouritesDetailsState> emit) async {
    WidgetsFlutterBinding.ensureInitialized();
    const storage = FlutterSecureStorage();
    String ipAdd = await storage.read(key: 'ipAdd') ?? 'null';
    // print('bloc is called');
    //event while the apis is being called
    emit(StaffFavouritesDetailsFetchingLoadingState());
    // print("staff detail loading state");
    //
    var client = http.Client();
    //var to store the result

    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      // ignore: unrelated_type_equality_checks
      if (connectivityResult == ConnectivityResult.none) {
        emit(StaffFavouritesDetailsFetchingErrorState(
            errorCode: 503, errorMessage: "No internet connection available"));
      } else {
        var response = await client
            .get(Uri.parse(
                'http://$ipAdd:3000/MentorSquare/api/staff/favourites?student_regNos=${event.regNos}'))
            .timeout(const Duration(seconds: 4), onTimeout: () {
          // Return an empty response or handle the timeout error
          return http.Response(
              'Request timeout : Check your internet connection', 408);
        });
        print("favs details api : ${response.statusCode}");
        print(
            '$ipAdd/MentorSquare/api/staff/favourites?student_regNos=${event.regNos.toString()}');
        if (response.statusCode == 200) {
          List<StudentDetail> resultData = [];
          final result = jsonDecode(response.body);
          for (int i = 0; i < result.length; i++) {
            StudentDetail tmpData = StudentDetail(
                studentIdDt: result[i]['Student_id_DT'],
                studentRegNo: result[i]['Student_RegNO'],
                studentName: result[i]['Student_Name'],
                classIdDt: result[i]['Class_Id_DT'],
                departmentIdDt: result[i]['Department_Id_DT'],
                yearIdDt: result[i]['Year_Id_DT'],
                yearName: result[i]['Year_Name'],
                className: result[i]['Class_Name']);
            resultData.add(tmpData);
          }

          // print(result['Staff_id_DT']);
          emit(StaffFavouritesDetailsFetchingSuccessState(
              studentsDetails: resultData));
        } else if (response.statusCode == 400) {
          emit(StaffFavouritesDetailsFetchingErrorState(
              errorCode: 400, errorMessage: "The user doesn't exist"));
        } else if (response.statusCode == 408) {
          emit(StaffFavouritesDetailsFetchingErrorState(
              errorCode: 400,
              errorMessage:
                  "Request timed out : please check your internet connections"));
        } else {
          StaffFavouritesDetailsFetchingErrorState(
              errorCode: response.statusCode, errorMessage: response.body);
        }
      }
    } catch (e) {
      emit(StaffFavouritesDetailsExecuteErrorState(
          message: "Error loadind details"));
    } finally {
      client.close();
    }
  }
}
