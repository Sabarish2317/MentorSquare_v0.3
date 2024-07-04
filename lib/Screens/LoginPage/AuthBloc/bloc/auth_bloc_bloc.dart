// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../../Models/login_response_model.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBlocBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  AuthBlocBloc() : super(AuthenticationInitialState()) {
    on<LoginButtonPressedEvent>(_handleLoginButtonPressed);
  }

  Future<void> _handleLoginButtonPressed(
      LoginButtonPressedEvent event, Emitter<AuthBlocState> emit) async {
    WidgetsFlutterBinding.ensureInitialized();
    const storage = FlutterSecureStorage();
    String ipAdd = await storage.read(key: 'ipAdd') ?? 'null';
    print("login pressed");
    if (ipAdd == 'null' || ipAdd == '') {
      emit(AuthenticationErrorState(
          errorCode: 408,
          errorMessage: 'Please add the ipaddress to use the api services'));
    }
    emit(AuthenticationLoadingState());
    var client = http.Client();
    StaffLoginResponseModel loginResponseData = StaffLoginResponseModel();
    try {
      String apiUrl = '$ipAdd/MentorSquare/api/signin/staff';

      print(apiUrl);
      //req and res templates
      //{"mail_id" : "Sabarish_7@gmail.com", "password" : "Sabarish_7"}
      //       {
      //     "status": "Success",
      //     "staff_id": 10,
      //     "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE3MTQ1MDY5NTN9.ZBsVhN4g-yJxv42bLLInlgCHoirWIMH1I-B-pyTlKiE"
      // }
      print("trying to get authentiction");
      final response = await http
          .post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'mail_id': event.emailId,
          'password': event.password,
          // Add any other data you want to send in the body
        }),
      )
          .timeout(const Duration(seconds: 4), onTimeout: () {
        // Return an empty response or handle the timeout error
        return http.Response(
            'Request timeout : Check your internet connection', 408);
      });
      print("code: ${response.statusCode}");
      if (response.statusCode == 200) {
        // Authentication successful

        final result = jsonDecode(response.body);

        loginResponseData.staffId = result['staff_id'];
        loginResponseData.status = result['status'];
        loginResponseData.token = result['token'];
        print(loginResponseData.token);
        emit(AuthenticationSuccessState(loginResponseData));
      } else if (response.statusCode == 404) {
        emit(AuthenticationErrorState(
            errorCode: 404,
            errorMessage: "Invalid username or password. Please try again."));
      } else if (response.statusCode == 408) {
        emit(AuthenticationErrorState(
            errorCode: response.statusCode,
            errorMessage:
                "Request timed out : Please check your internet connection"));
      } else {
        // Authentication failed
        emit(AuthenticationErrorState(
            errorCode: response.statusCode,
            errorMessage:
                "Unknown Error occured || Status Code : ${response.statusCode} "));
      }
    } catch (e) {
      // Error occurred during authentication process
      emit(AuthenticationFailureState(
          errorCode: 400,
          errorMessage: "Unknown Error occured || Status Code : 400 "));
    } finally {
      client.close();
    }
  }
}
