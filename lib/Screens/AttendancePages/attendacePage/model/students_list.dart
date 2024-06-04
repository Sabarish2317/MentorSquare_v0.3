class StudentsList {
  final int studentIdDt;
  final String studentRegNo;
  final String studentName;
  final int classIdDt;
  final int departmentIdDt;
  final int yearIdDt;
  var bool = true;

  StudentsList(
    this.bool, {
    required this.studentIdDt,
    required this.studentRegNo,
    required this.studentName,
    required this.classIdDt,
    required this.departmentIdDt,
    required this.yearIdDt,
  });
}
