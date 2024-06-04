//
//
//
//
//class for specifying the format of the data source
import 'package:flutter/material.dart';
import 'package:mentor_square/ui_consts/them_data.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class StudentAttendance {
  StudentAttendance(this.regNo, this.studentName);

  final String regNo;

  final String studentName;
}

//
//
//
//
//populating the class and storing it in a list
List<StudentAttendance> getStudentAttendaceData() {
  return [
    StudentAttendance("713522AM060", 'John Doe'),
    StudentAttendance("713522AM061", 'Jane Smith'),
    StudentAttendance("713522AM062", 'Bob Johnson'),
    StudentAttendance("713522AM063", 'Alice Williams'),
    StudentAttendance("713522AM064", 'Charlie Brown'),
    StudentAttendance("713522AM065", 'Emma Davis'),
    StudentAttendance("713522AM066", 'Frank Miller'),
    StudentAttendance("713522AM067", 'Grace Wilson'),
    StudentAttendance("713522AM068", 'Henry Jones'),
    StudentAttendance("713522AM069", 'Ivy Parker'),
    StudentAttendance("713522AM070", 'John Doe'),
    StudentAttendance("713522AM071", 'Jane Smith'),
    StudentAttendance("713522AM072", 'Bob Johnson'),
    StudentAttendance("713522AM073", 'Alice Williams'),
    StudentAttendance("713522AM074", 'Charlie Brown'),
    StudentAttendance("713522AM075", 'Emma Davis'),
    StudentAttendance("713522AM076", 'Frank Miller'),
    StudentAttendance("713522AM077", 'Grace Wilson'),
    StudentAttendance("713522AM078", 'Henry Jones'),
    StudentAttendance("713522AM079", 'Ivy Parker'),
    StudentAttendance("713522AM080", 'John Doe'),
    StudentAttendance("713522AM081", 'Jane Smith'),
    StudentAttendance("713522AM082", 'Bob Johnson'),
    StudentAttendance("713522AM083", 'Alice Williams'),
    StudentAttendance("713522AM084", 'Charlie Brown'),
    StudentAttendance("713522AM085", 'Emma Davis'),
    StudentAttendance("713522AM086", 'Frank Miller'),
    StudentAttendance("713522AM087", 'Grace Wilson'),
    StudentAttendance("713522AM088", 'Henry Jones'),
    StudentAttendance("713522AM089", 'Ivy Parker'),
  ];
}

//
//
//
//
//creating a list with sources mapped to match the data format specified by the sfdata grifd
class StudentDataSource extends DataGridSource {
  StudentDataSource({required List<StudentAttendance> studentAttendanceData}) {
    _studentAttendanceData = studentAttendanceData
        .map<DataGridRow>((student) => DataGridRow(cells: [
              DataGridCell<String>(
                  columnName: 'Student Name', value: student.studentName),
              DataGridCell<String>(columnName: 'Reg No', value: student.regNo),
            ]))
        .toList();
  }

  List<DataGridRow> _studentAttendanceData = [];

  @override
  List<DataGridRow> get rows => _studentAttendanceData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((e) {
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: Text(e.value.toString(),
              style: appTheme.textTheme.labelMedium
                  ?.copyWith(color: const Color(0xFF334149), fontSize: 12)),
        );
      }).toList(),
    );
  }
}

//
//
//
//
