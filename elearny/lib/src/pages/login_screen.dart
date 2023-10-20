import 'package:elearny/data/globales.dart';
import 'package:elearny/routes/app_routes.dart';
import 'package:elearny/services/firebase/fireStore/auth/login_services.dart';
import 'package:elearny/src/widgets/one_button_dialog.dart';
import 'package:elearny/src/widgets/web_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:elearny/provider/deviceTypeProvider/device_type_provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final LoginService loginService = LoginService();

  @override
  Widget build(BuildContext context) {
    return Consumer<DeviceTypeProvider>(builder: (context, splashProvider, _) {
      return Scaffold(
        appBar: AppBar(
          toolbarHeight: 120.w,
          automaticallyImplyLeading: false,
          title: deviceType != 1
              ? deviceType == 2
                  ? const Center(
                      child: Text(
                        "Tablet View",
                        style: TextStyle(fontSize: 30),
                      ),
                    )
                  : const Center(
                      child: Text(
                        "Mobile View",
                        style: TextStyle(fontSize: 30),
                      ),
                    )
              : const WebAppBar(),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(hintText: 'Enter your email'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: passwordController,
                decoration:
                    const InputDecoration(hintText: 'Enter your password'),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () async {
                  await loginService.loginUser(
                      emailController.text, passwordController.text);
                },
                child: const Text('Login'),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, Routes.register);
                },
                child: const Text('sing up'),
              ),
            ],
          ),
        ),
      );
    });
  }

  Future<void> showDialoge(BuildContext context) {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return OneButtonDialogWidget(
              title: "Test Dialog",
              contents: "login success",
              confirmbuttonText: "Back",
              onConfirm: () {},
              onWillPopScopeValue: true);
        });
  }
}
