import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentor_square_v3_responsive/Screens/LoginPage/widget/success_snackbar.dart';
import 'package:mentor_square_v3_responsive/Widgets/alert_box.dart';
import '../../../constants/colors.dart';
import '../../landingPage/landing_page.dart';
import '../AuthBloc/bloc/auth_bloc_bloc.dart';
import '../Models/login_response_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginButton extends StatefulWidget {
  final String text;
  final String emailId;
  final String password;
  const LoginButton(
      {super.key,
      required this.text,
      required this.emailId,
      required this.password});

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  String ipAddD = 'null';
  //
  //

  @override
  void initState() {
    super.initState();
    _getipAdd();
  }

  //this pushes the homepage to the stack and clears another if the validation is successful
  _login(BuildContext context, StaffLoginResponseModel loginReponseData) async {
    return Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const LandingPage(),
      ),
      (route) => false,
    );
  }

  _getipAdd() async {
    WidgetsFlutterBinding.ensureInitialized();
    const storage = FlutterSecureStorage();
    String ipAdd = await storage.read(key: 'ipAdd') ?? 'null';
    setState(() {
      ipAddD = ipAdd;
    });
  }

  Future<void> secureStoreStaffId(String key, int value) async {
    const storage = FlutterSecureStorage();
    await storage.write(key: key, value: "$value");
  }

  Future<void> secureStoretkn(String key, String value) async {
    const storage = FlutterSecureStorage();
    await storage.write(key: key, value: value);
  }

  //pop up snack bar to show the creds are wrong
  void _showErrorSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: tdPurePurple,
      ),
      child: Material(
        borderRadius: BorderRadius.circular(15),
        color: Colors.transparent,
        child: BlocProvider(
          create: (context) => AuthBlocBloc(),
          child: BlocListener<AuthBlocBloc, AuthBlocState>(
            listener: (context, state) {
              if (state is AuthenticationSuccessState) {
                // Access success state data here
                final responseDetails = state.loginReponseList;
                showSuccessSnackbar(context);
                var staffId = state.loginReponseList.staffId;
                secureStoreStaffId('staffId', staffId ?? 0);

                var tkn = state.loginReponseList.token;
                secureStoretkn('tkn', tkn ?? "NO_TOKEN");

                _login(context, responseDetails);
              }
              if (state is AuthenticationErrorState) {
                final String message = state.errorMessage;
                _showErrorSnackbar(context, message);
              }
              if (state is AuthenticationFailureState) {
                alertbox(state.errorMessage, context);
              }
            },
            child: BlocBuilder<AuthBlocBloc, AuthBlocState>(
              builder: (context, state) {
                return InkWell(
                  borderRadius: BorderRadius.circular(15),
                  splashColor: const Color(0xffA888FF),
                  onTap: () {
                    // print("login pressed,${widget.emailId} ${widget.password}");

                    // Oonly triggers the event if not already fetching the login api
                    BlocProvider.of<AuthBlocBloc>(context).add(
                        LoginButtonPressedEvent(
                            emailId: widget.emailId,
                            password: widget.password));
                  },
                  child: Container(
                    height: 44,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 0.50,
                          color: Colors.white.withOpacity(0.15),
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x0C000000),
                          blurRadius: 5,
                          offset: Offset(0, 4),
                          spreadRadius: 1,
                        )
                      ],
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        widget.text,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          height: 0,
                          letterSpacing: 0.32,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
