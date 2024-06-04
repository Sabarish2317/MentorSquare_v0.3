import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mentor_square_v3_responsive/Screens/landingPage/bloc/staff_detail_bloc.dart';
import 'package:mentor_square_v3_responsive/Screens/landingPage/widgets/scaffold_types.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  //bloc instance
  late final StaffDetailBloc staffDetailBloc;
  late String? favourites;

  //fetch data on load of the scaffold
  @override
  void initState() {
    super.initState();
    staffDetailBloc = StaffDetailBloc();
    _checkConnectivityAndFetchData();
    getFavourites();
  }

  //@funtionss
  //
  //check connectivity to internet
  Future<void> _checkConnectivityAndFetchData() async {
    // final connectivityResult = await Connectivity().checkConnectivity();
    // ignore: unrelated_type_equality_checks

    int? staffId = await getStaffIdFromSS();

    staffDetailBloc.add(InitalFetchEvent(staffId: staffId ?? 0));
  }

  //local storage retrival
  Future<int?> getStaffIdFromSS() async {
    const storage = FlutterSecureStorage();
    String? value = await storage.read(key: 'staffId');
    return value != null ? int.tryParse(value) : null;
  }

  Future<String?> getFavourites() async {
    const storage = FlutterSecureStorage();
    String? value = await storage.read(key: 'Favourites');
    setState(() {
      favourites = value;
    });
    return value;
  }

  @override
  void dispose() {
    staffDetailBloc.close();
    super.dispose();
  }

  //@main logic
  @override
  Widget build(BuildContext context) {
    //@variables
    String regNo = "Error";
    // ignore: unused_local_variable
    int id = 0;
    String name = "Error";

    return BlocProvider(
      create: (_) => staffDetailBloc,
      child: BlocConsumer<StaffDetailBloc, StaffDetailState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is StaffDetailFetchingSuccessState) {
            id = state.staffData.staffIdDt ?? 0;
            regNo = state.staffData.staffRegNo ?? "error";
            name = state.staffData.staffName ?? "error";
            Map<dynamic, dynamic> fav = state.staffData.staffFavs;

            return mainScaffold(id, name, regNo, context, fav);
          } else if (state is StaffDetailFetchingErrorState) {
            return errorScaffold(context, state);
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}

//main scaffold with ui comps

