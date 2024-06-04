import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../models/staff_detail_model.dart';

part 'staff_detail_event.dart';
part 'staff_detail_state.dart';

class StaffDetailBloc extends Bloc<StaffDetailEvent, StaffDetailState> {
  StaffDetailBloc() : super(StaffDetailInitialState()) {
    //when the page loads this event fetches data automatically
    on<InitalFetchEvent>(_staffDetailInitialFetchEvent);
  }
  //
  //event function
  Future<void> _staffDetailInitialFetchEvent(
      InitalFetchEvent event, Emitter<StaffDetailState> emit) async {
    WidgetsFlutterBinding.ensureInitialized();
    const storage = FlutterSecureStorage();
    String ipAdd = await storage.read(key: 'ipAdd') ?? 'null';
    // print('bloc is called');
    //event while the apis is being called
    emit(StaffDetailFetchingLoadingState());
    // print("staff detail loading state");
    //
    var client = http.Client();
    //var to store the result
    if (event.staffId != 0) {
      try {
        final connectivityResult = await Connectivity().checkConnectivity();
        // ignore: unrelated_type_equality_checks
        if (connectivityResult == ConnectivityResult.none) {
          emit(StaffDetailFetchingErrorState(
              errorCode: 503,
              errorMessage: "No internet connection available"));
        } else {
          var response = await client
              .get(Uri.parse(
                  'http://$ipAdd:3000/MentorSquare/api/staffs?staff_id=${event.staffId}'))
              .timeout(Duration(seconds: 4), onTimeout: () {
            // Return an empty response or handle the timeout error
            return http.Response(
                'Request timeout : Check your internet connection', 408);
          });
          print("Landing page api : ${response.statusCode}");

          if (response.statusCode == 200) {
            final result = jsonDecode(response.body);
            StaffDetailInitialFetchModel staffData =
                StaffDetailInitialFetchModel(
                    staffIdDt: result['Staff_id_DT'],
                    staffName: result['Staff_Name'],
                    staffRegNo: result['Staff_RegNo'],
                    staffPhoneNo: result['Staff_phoneNo'],
                    mailId: result['Mail_id'],
                    staffFavs: result['Staff_Favs']);
            // print(result['Staff_id_DT']);
            emit(StaffDetailFetchingSuccessState(staffData: staffData));
          } else if (response.statusCode == 400) {
            emit(StaffDetailFetchingErrorState(
                errorCode: 400, errorMessage: "The user doesn't exist"));
          } else if (response.statusCode == 408) {
            emit(StaffDetailFetchingErrorState(
                errorCode: 400,
                errorMessage:
                    "Request timed out : please check your internet connections"));
          } else {
            StaffDetailFetchingErrorState(
                errorCode: response.statusCode, errorMessage: response.body);
          }
        }
      } catch (e) {
        emit(StaffDetailExecuteErrorState(message: "Error loadind details"));
      } finally {
        client.close();
      }
    } else {
      emit(StaffDetailExecuteErrorState(message: "The user doesnt exist "));
    }
  }
}
