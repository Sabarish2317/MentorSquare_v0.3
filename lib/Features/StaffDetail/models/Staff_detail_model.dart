// {"Staff_id_DT":9,"Staff_Name":"Rithika Shenoy R","Staff_RegNo":"713522AM082"}
//MentorSquare/api/staffs',staffRoute

class StaffDetailInitialFetchModel {
  StaffDetailInitialFetchModel({
    required this.staffIdDt,
    required this.staffName,
    required this.staffRegNo,
  });

  final int? staffIdDt;
  final String? staffName;
  final String? staffRegNo;

  factory StaffDetailInitialFetchModel.fromJson(Map<String, dynamic> json) {
    return StaffDetailInitialFetchModel(
      staffIdDt: json["Staff_id_DT"],
      staffName: json["Staff_Name"],
      staffRegNo: json["Staff_RegNo"],
    );
  }

  Map<String, dynamic> toJson() => {
        "Staff_id_DT": staffIdDt,
        "Staff_Name": staffName,
        "Staff_RegNo": staffRegNo,
      };

  @override
  String toString() {
    return "$staffIdDt, $staffName, $staffRegNo, ";
  }
}
