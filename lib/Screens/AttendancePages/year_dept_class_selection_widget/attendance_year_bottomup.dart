import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentor_square_v3_responsive/Screens/AttendancePages/year_dept_class_selection_widget/bloc/department_bloc.dart';
import 'package:mentor_square_v3_responsive/Screens/AttendancePages/year_dept_class_selection_widget/model/classes_data_model.dart';
import 'package:mentor_square_v3_responsive/Screens/AttendancePages/year_dept_class_selection_widget/widgets/bottomup.dart';
import 'package:mentor_square_v3_responsive/Screens/AttendancePages/schedule_page/schedule_page.dart';
import 'package:mentor_square_v3_responsive/Widgets/alert_box.dart';

//inits a funtions which show the bottom up widget
void modalBottomSheetMenu(BuildContext context) {
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return const BottomSheetContent();
    },
  );
}

//main contents inside the popupped widget
class BottomSheetContent extends StatefulWidget {
  const BottomSheetContent({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BottomSheetContentState createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  //tracks the current index of the widget
  int widgetIndex = 0;
  //data to be stored and sent to the attendance page

  Map<int, String> selectedClassIdx = {};

  Map<int, String> selectedDeptIdx = {};

  Map<int, String> selectedYearIdx = {};

  //call back funtions which a sent to the containers depeneding on the button types which help to change the index to the next page and navgate the ui and store the final data

  //@function
  void callBackYear(String year, int yearId) {
    if (widgetIndex < 2) {
      setState(() {
        widgetIndex += 1;

        selectedYearIdx = {yearId: year};
        print("selected year : $selectedYearIdx");
      });
    }
  }

  //@function
  void callBackDept(String dept, int deptId) {
    if (widgetIndex < 2) {
      setState(() {
        widgetIndex += 1;
        selectedDeptIdx = {deptId: dept};
        print("selected dept : $selectedDeptIdx");
      });
    }
  }

  //@function
  void callBackClass(String classes, int classId) {
    if (widgetIndex < 2) {
      setState(() {
        widgetIndex += 1;

        selectedClassIdx = {classId: classes};
      });
    } else {
      selectedClassIdx = {classId: classes};
      print("selected class : ${selectedClassIdx}");
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SchedulePage(
                  selectedClassIdx: selectedClassIdx,
                  selectedDeptIdx: selectedDeptIdx,
                  selectedYearIdx: selectedYearIdx,
                )),
      );
    }
  }
  //
  //
  //
  //
  //build implementations

  @override
  Widget build(BuildContext context) {
    //@variables and datas
    //used static data for years change if your institutions has only 3 years or using an api call

    List<Map<int, String>> yearItemsIdx = [
      {23: '1'},
      {22: '2'},
      {21: '3'},
      {20: '4'},
    ];
    List<Map<int, String>> deptItemsIdx = [
      {1: "AIML"},
      {2: "IT"},
      {3: "CIVIL"},
      {4: "MECH"},
      {5: "FT"},
      {6: "CSE"},
      {7: "AGRI"},
      {8: "ECE"},
    ];
    List<Map<int, String>> classItemsIdx = [];

    //this is a custom implementation of the bottom up widget

    return BlocProvider(
      create: (context) => DepartmentBloc(),
      child: BlocConsumer<DepartmentBloc, DepartmentState>(
        listener: (context, state) {
          if (state is DepartmentDetailFetchingSuccessState) {
            List<ClassesDataModel> stateDataFromBloc = state.classes;
            for (int i = 0; i < stateDataFromBloc.length; i++) {
              classItemsIdx.add({
                stateDataFromBloc[i].classId: stateDataFromBloc[i].className
              });
            }
          }
        },
        builder: (context, state) {
          return GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Wrap(
              children: [
                //@function
                MyBottomUp(
                  widget: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              (widgetIndex == 0)
                                  ? 'Select Year'
                                  : (widgetIndex == 1)
                                      ? 'select department'
                                      : (widgetIndex == 2)
                                          ? 'Select Class'
                                          : "Select",
                              style: const TextStyle(
                                color: Color(0xFF00111C),
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          //changes the widget based on the currentIndex variable above
                          child: IndexedStack(
                            //visiblity is used so that the bottom sheet adapts to the height of each widget instead of defaulting to the largest child
                            index: widgetIndex,
                            children: [
                              Visibility(
                                  visible: (widgetIndex == 0),
                                  //@function
                                  child: buildGrid(yearItemsIdx, context,
                                      callBackYear, 'year')),
                              Visibility(
                                  visible: (widgetIndex == 1),
                                  //@function
                                  child: buildGrid(deptItemsIdx, context,
                                      callBackDept, 'dept')),
                              Visibility(
                                  visible: (widgetIndex == 2),
                                  //@function
                                  child: (state
                                          is DepartmentFetchingLoadingState)
                                      ? const CircularProgressIndicator()
                                      : (state
                                              is DepartmentDetailFetchingSuccessState)
                                          ? buildGrid(classItemsIdx, context,
                                              callBackClass, 'class')
                                          : (state
                                                  is DepartmentFetchingErrorState)
                                              ? alertbox(
                                                  state.errorMessage, context)
                                              : (state
                                                      is DepartmentsDetailExecuteErrorState)
                                                  ? alertbox(
                                                      state.message, context)
                                                  : const Text(
                                                      "Sorry couldn't update your data"))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  //grid builder fintions
  //@function
  Widget buildGrid(List<Map<int, String>> items, BuildContext context,
      Function callBack, String type) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 15,
            crossAxisSpacing: 20,
            childAspectRatio: 2,
          ),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return SizedBox(
              height: 60,
              width: 125,
              child: myCard(items[index], context, callBack, type),
            );
          },
        ),
      ],
    );
  }

//@function
  Widget myCard(
      //{1:"name"}
      Map<int, String> data,
      BuildContext context,
      Function callBack,
      String type) {
    var entry = data.entries.first;
    int key = entry.key;
    String value = entry.value;
    return Container(
      width: 125,
      height: 60,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: const Color(0xFF9672F8),
      ),
      child: Material(
        borderRadius: BorderRadius.circular(15),
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            //calls a bloc event add only after the department is being selecred
            if (type == 'dept') {
              var yearEntry = selectedYearIdx.entries.first;
              print("Requesting class details for ${yearEntry.key} : $key");
              BlocProvider.of<DepartmentBloc>(context).add(
                  DeptButtonPressedEvent(
                      selectedYear: yearEntry.key, selectedDept: key));
            }
            callBack(value, key);
          },
          borderRadius: BorderRadius.circular(15),
          child: Container(
            width: 125,
            height: 60,
            padding: const EdgeInsets.only(left: 34, right: 33),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: Center(
              child: Text(
                (type == 'year') ? "YEAR -$value" : value,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 12,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
