import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mentor_square_v3_responsive/Screens/LoginPage/widget/app_logo.dart';
import 'package:mentor_square_v3_responsive/Screens/LoginPage/widget/check_box.dart';
import 'package:mentor_square_v3_responsive/Screens/LoginPage/widget/login_button.dart';
import 'package:mentor_square_v3_responsive/Screens/LoginPage/widget/text_field_main.dart';
import 'package:mentor_square_v3_responsive/Widgets/add_height.dart';

class LoginPage extends StatefulWidget {
  // ignore: use_super_parameters
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //

  late TextEditingController ipTextController;
  @override
  void initState() {
    super.initState();
    ipTextController = TextEditingController();
  }

  void showAlertBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("IP CHANGER"),
          content: const Text("Change the ipaddress of http reqs"),
          actions: <Widget>[
            TextField(
              controller: ipTextController,
              decoration: InputDecoration(
                prefixIcon: Image.asset(
                  'lib/Assets/icons/attendance.png',
                  scale: 4,
                ),
                labelText: 'Enter new ip address',
              ),
            ),
            const Addheight(
              height: 10,
            ),
            ElevatedButton(
              child: const Text("OK"),
              onPressed: () {
                secureStoreIpAdd('ipAdd', ipTextController.text);
                ipTextController.clear();

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> secureStoreIpAdd(String key, String value) async {
    const storage = FlutterSecureStorage();
    await storage.write(key: key, value: value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xffECF2FF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                appLogo(),
                const FormContainer(),
                InkWell(
                  onDoubleTap: () {
                    showAlertBox(context);
                  },
                  child: const Text(
                    'APP FOR MENTORS',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF6B6B6B),
                      fontSize: 11,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FormContainer extends StatefulWidget {
  const FormContainer({
    super.key,
  });

  @override
  State<FormContainer> createState() => _FormContainerState();
}

class _FormContainerState extends State<FormContainer> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  String _email = '';
  String _password = '';

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Email address',
                  style: TextStyle(
                    color: Color(0xFF4F4F4F),
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 0,
                    letterSpacing: 0.28,
                  ),
                ),
              ),
              TextFieldInput(
                preffixIcon: 'lib/Assets/icons/profie_icon.png',
                textEditingController: _emailController,
                labelText: 'Email ID',
                isPassword: false,
                onChanged: (text) {
                  setState(() {
                    _email = text;
                  });
                },
              ),
            ],
          ),
        ),
        const Addheight(height: 18),
        SizedBox(
          height: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Password',
                  style: TextStyle(
                    color: Color(0xFF4F4F4F),
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 0,
                    letterSpacing: 0.28,
                  ),
                ),
              ),
              TextFieldInput(
                textEditingController: _passwordController,
                labelText: 'Password',
                preffixIcon: 'lib/Assets/icons/Password-Lock.png',
                isPassword: true,
                suffixIcon: 'lib/Assets/icons/eyeLock.png',
                suffixIconOn: 'lib/Assets/icons/eyeLockOn.png',
                onChanged: (text) {
                  setState(() {
                    _password = text;
                  });
                },
              ),
            ],
          ),
        ),
        const Addheight(height: 18),
        const MyCheckBox(),
        const Addheight(height: 18),
        LoginButton(
          text: 'LOGIN',
          emailId: _email,
          password: _password,
        ),
      ],
    );
  }
}
