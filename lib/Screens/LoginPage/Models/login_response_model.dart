class StaffLoginResponseModel {
  String? status;
  int? staffId;
  String? token;

  StaffLoginResponseModel({this.status, this.staffId, this.token});

  StaffLoginResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    staffId = json['staff_id'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['staff_id'] = staffId;
    data['token'] = token;
    return data;
  }
}
