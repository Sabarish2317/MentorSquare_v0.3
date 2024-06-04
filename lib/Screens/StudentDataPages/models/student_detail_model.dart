// [
//     {
//         "Student_id_DT": 19,
//         "Student_RegNO": "713522AM061",
//         "Student_Name": "Sridhar S",
//         "Class_Id_DT": 1,
//         "Department_Id_DT": 1,
//         "Year_Id_DT": 22
//     }
// ]

class StudentDetail {
  final int studentIdDt;
  final String studentRegNo;
  final String studentName;
  final int classIdDt;
  final int departmentIdDt;
  final int yearIdDt;
  final int yearName;
  final String className;

  StudentDetail({
    required this.yearName,
    required this.className,
    required this.studentIdDt,
    required this.studentRegNo,
    required this.studentName,
    required this.classIdDt,
    required this.departmentIdDt,
    required this.yearIdDt,
  });
}
