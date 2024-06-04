// {"Staff_id_DT":9,"Staff_Name":"Rithika Shenoy R","Staff_RegNo":"713522AM082"}
//MentorSquare/api/staffs',staffRoute

// ignore_for_file: file_names

class StaffDetailInitialFetchModel {
  final int? staffIdDt;
  final String? staffName;
  final String? staffRegNo;
  final int staffPhoneNo;
  final String mailId;
  final Map<dynamic, dynamic> staffFavs;

  StaffDetailInitialFetchModel(
      {required this.staffIdDt,
      required this.staffName,
      required this.staffRegNo,
      required this.staffPhoneNo,
      required this.mailId,
      required this.staffFavs});
}
