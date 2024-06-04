import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentor_square/Presentation/Screens/AttendancePages/3_attendance_sheet_page/data/sf_data_grid_data.dart';
import 'package:mentor_square/ui_consts/colors.dart';
import 'package:mentor_square/ui_consts/them_data.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class MySfDataGrid extends StatefulWidget {
  const MySfDataGrid({super.key});

  @override
  MySfDataGridState createState() => MySfDataGridState();
}

class MySfDataGridState extends State<MySfDataGrid> {
  final DataGridController _dataGridController = DataGridController();
  List<StudentAttendance> studentAttendance = <StudentAttendance>[];
  late StudentDataSource studentAttendanceDataSource;

  @override
  void initState() {
    super.initState();

    studentAttendanceDataSource =
        StudentDataSource(studentAttendanceData: getStudentAttendaceData());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(color: tddivider))),
        height: 540.h,
        padding: EdgeInsets.symmetric(horizontal: 1.w),
        width: MediaQuery.of(context).size.width,
        child: ClipRect(
          child: SfDataGridTheme(
            data: SfDataGridThemeData(
                selectionColor: Colors.white,
                headerColor: Color.fromARGB(24, 255, 255, 255),
                gridLineColor: tddivider,
                gridLineStrokeWidth: 1.w),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: SfDataGrid(
                allowPullToRefresh: true,
                shrinkWrapRows: true,
                showCheckboxColumn: true,
                checkboxShape: RoundedRectangleBorder(
                  side: const BorderSide(
                      style: BorderStyle.solid,
                      width: 1,
                      color: Color(0xFF9672F8)),
                  borderRadius: BorderRadius.circular(5),
                ),
                checkboxColumnSettings: DataGridCheckboxColumnSettings(
                  width: MediaQuery.of(context).size.width / 3.5,
                ),
                showVerticalScrollbar: true,
                selectionMode: SelectionMode.multiple,
                gridLinesVisibility: GridLinesVisibility.vertical,
                headerGridLinesVisibility: GridLinesVisibility.both,
                source: studentAttendanceDataSource,
                columnWidthMode: ColumnWidthMode.fill,
                columns: <GridColumn>[
                  GridColumn(
                      columnName: 'Student Name',
                      label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: Text(
                            'Student Name',
                            style: appTheme.textTheme.titleSmall?.copyWith(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: tdTxtBlk),
                          ))),
                  GridColumn(
                      columnName: 'Reg No',
                      label: Container(
                          padding: const EdgeInsets.all(16.0),
                          alignment: Alignment.center,
                          child: Text('Reg.No',
                              style: appTheme.textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                  color: tdTxtBlk)))),
                ],
                controller: _dataGridController,
              ),
            ),
          ),
        ));
  }
}

//
//
//
//
//custom rect clup by sf

