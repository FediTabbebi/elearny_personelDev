import 'package:elearny/data/globales.dart';
import 'package:elearny/provider/authProviders/login_provider.dart';
import 'package:elearny/provider/themeProvider/theme_provider.dart';
import 'package:elearny/routes/app_routes.dart';
import 'package:elearny/src/widgets/web_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
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
        child: Form(
          key: loginProvider.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                validator: (value) => loginProvider.validateEmail(value!),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                validator: (value) => loginProvider.validatePassword(value!),
              ),
              ElevatedButton(
                onPressed: () async {
                  await loginProvider.loginUser(
                      emailController.text, passwordController.text, context);
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
        },
        tooltip: 'switch mode',
        child: Icon(
            Provider.of<ThemeProvider>(context, listen: false).isDarkMode
                ? Icons.dark_mode
                : Icons.light_mode),
      ), // This trailing comma ma
    );
  }
}
