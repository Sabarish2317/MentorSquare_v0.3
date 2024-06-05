class Attendance {
  final int attendanceId;
  final int studentId;
  final int semesterNo;
  final String date;
  final int dayId;
  final Map<String, dynamic>? period1Status;
  final Map<String, dynamic>? period2Status;
  final Map<String, dynamic>? period3Status;
  final Map<String, dynamic>? period4Status;
  final Map<String, dynamic>? period5Status;
  final Map<String, dynamic>? period6Status;
  final Map<String, dynamic>? period7Status;
  final Map<String, dynamic>? period8Status;

  Attendance({
    required this.attendanceId,
    required this.studentId,
    required this.semesterNo,
    required this.date,
    required this.dayId,
    required this.period1Status,
    required this.period2Status,
    required this.period3Status,
    required this.period4Status,
    required this.period5Status,
    required this.period6Status,
    required this.period7Status,
    required this.period8Status,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      attendanceId: json['Attendance_id'],
      studentId: json['Student_id_DAT'],
      semesterNo: json['Semester_No'],
      date: json['Date'],
      dayId: json['Day_id_DAT'],
      period1Status: Map<String, dynamic>.from(json['Period1_Status']),
      period2Status: Map<String, dynamic>.from(json['Period2_status']),
      period3Status: Map<String, dynamic>.from(json['Period3_Status']),
      period4Status: Map<String, dynamic>.from(json['Period4_Status']),
      period5Status: Map<String, dynamic>.from(json['Period5_Status']),
      period6Status: Map<String, dynamic>.from(json['Period6_Status']),
      period7Status: Map<String, dynamic>.from(json['Period7_Status']),
      period8Status: Map<String, dynamic>.from(json['Period8_Status']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Attendance_id': attendanceId,
      'Student_id_DAT': studentId,
      'Semester_No': semesterNo,
      'Date': date,
      'Day_id_DAT': dayId,
      'Period1_Status': period1Status,
      'Period2_status': period2Status,
      'Period3_Status': period3Status,
      'Period4_Status': period4Status,
      'Period5_Status': period5Status,
      'Period6_Status': period6Status,
      'Period7_Status': period7Status,
      'Period8_Status': period8Status,
    };
  }
}
