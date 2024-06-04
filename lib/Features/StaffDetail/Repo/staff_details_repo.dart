import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/Staff_detail_model.dart';

class StaffDetailsRepo {
  static Future<List<StaffDetailInitialFetchModel>> fetchStaffDetail() async {
    var client = http.Client();
    List<StaffDetailInitialFetchModel> staffDetails = [];
    try {
      var response = await client.get(Uri.parse(
          'http://192.168.29.16:3000/MentorSquare/api/staffs?staff_id =9'));
      if (response.statusCode == 200) {
        List result = jsonDecode(response.body);
        for (int i = 0; i < result.length; i++) {
          StaffDetailInitialFetchModel staffDetail =
              StaffDetailInitialFetchModel.fromJson(
                  result[i] as Map<String, dynamic>);
          staffDetails.add(staffDetail);
        }
      }
      return staffDetails;
    } catch (e) {
      print(e);
      return staffDetails;
    } finally {
      client.close();
    }
  }
}
