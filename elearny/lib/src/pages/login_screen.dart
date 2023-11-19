import 'package:elearny/data/globales.dart';
import 'package:elearny/provider/authProviders/login_provider.dart';
import 'package:elearny/provider/themeProvider/theme_provider.dart';
import 'package:elearny/src/widgets/web_appbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final loginProvider = Provider.of<LoginProvider>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: false,
          // leading: IconButton(
          //   icon: Icon(Icons.arrow_back, color: Colors.black),
          //   onPressed: () => Navigator.of(context).pop(),
          // ),
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
            key: context.read<LoginProvider>().formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: context.read<LoginProvider>().emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                    validator: (value) => context
                        .read<LoginProvider>()
                        .validate
                        .validateEmail(value!),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller:
                        context.read<LoginProvider>().passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                    validator: (value) => context
                        .read<LoginProvider>()
                        .validate
                        .validatePassword(value!),
                  ),
                  const SizedBox(height: 16.0),
                  context.watch<LoginProvider>().isLoading
                      ? const SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator())
                      : SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            onPressed: () async {
                              await context.read<LoginProvider>().loginUser(
                                  context
                                      .read<LoginProvider>()
                                      .emailController
                                      .text,
                                  context
                                      .read<LoginProvider>()
                                      .passwordController
                                      .text,
                                  context);
                            },
                            child: const Text('Login'),
                          ),
                        ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          context.push("/register");
                          print("aaa");
                        },
                        child: const Text('sing up'),
                      ),
                    ],
                  ),
                ],
              ),
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
        ),
      ),
    );
  }
}
