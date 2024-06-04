import 'dart:async';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'aff_favs_event.dart';
part 'aff_favs_state.dart';

class AffFavsBloc extends Bloc<AffFavsEvent, AffFavsState> {
  AffFavsBloc() : super(AffFavsInitial()) {
    on<AffFavsFetchEvent>(affFavsEvent);
  }

  FutureOr<void> affFavsEvent(
      AffFavsFetchEvent event, Emitter<AffFavsState> emit) async {
    print('Entered fav add API bloc');
    WidgetsFlutterBinding.ensureInitialized();
    const storage = FlutterSecureStorage();
    String ipAdd = await storage.read(key: 'ipAdd') ?? 'null';

    // Emit loading state
    emit(AffFavsFetchingLoadingState());

    // Create HTTP client
    var client = http.Client();

    // Check connectivity
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      emit(AffFavsFetchingErrorState(
          errorCode: 400, errorMessage: "No internet connection available"));
      return;
    }

    // Prepare the request body
    Map<String, dynamic> requestBody = event.toJson();

    // Send request
    try {
      String apiUrl = 'http://$ipAdd:3000/MentorSquare/api/staff/favourites';

      final response = await client
          .post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      )
          .timeout(
        const Duration(seconds: 8),
        onTimeout: () {
          return http.Response('Request timeout', 408);
        },
      );

      print("Fav add API response status: ${response.statusCode}");

      if (response.statusCode != 200) {
        emit(AffFavsFetchingErrorState(
            errorCode: response.statusCode,
            errorMessage:
                "Failed to fetch Class data. Status code: ${response.statusCode}"));
      } else {
        emit(AffFavsDetailFetchingSuccessState(
            responseMessage: "Updated successfully"));
      }
    } catch (e) {
      print(e);
      emit(AffFavsFetchingErrorState(
          errorCode: 401,
          errorMessage: "Failed to fetch departments data. Error: $e"));
    } finally {
      client.close();
    }
  }
}
