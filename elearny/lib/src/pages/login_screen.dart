import 'package:elearny/data/globales.dart';
import 'package:elearny/provider/authProviders/login_provider.dart';
import 'package:elearny/provider/themeProvider/theme_provider.dart';
import 'package:elearny/routes/app_routes.dart';
import 'package:elearny/services/app_service/app_service.dart';
import 'package:elearny/src/theme/themes.dart';
import 'package:elearny/src/widgets/loading_indicator_widget.dart';
import 'package:elearny/src/widgets/web_appbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appService = Provider.of<AppService>(context);
    // final loginProvider = Provider.of<LoginProvider>(context);
    return SafeArea(
      child: LayoutBuilder(builder: (context, constraint) {
        return Scaffold(
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
          body: Form(
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
                    keyboardType: TextInputType.emailAddress,
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
                      ? const Center(
                          child: SizedBox(
                            width: 50,
                            child: LoadingIndicatorWidget(
                              color: Themes.green,
                              size: 50,
                            ),
                          ),
                        )
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
                          context.pushNamed(
                            AppPage.register.toName,
                          );
                        },
                        child: const Text('sing up'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                heroTag: null,
                onPressed: () {
                  appService.onboarding = false;
                },
                tooltip: 'reset onboarding',
                child: const Icon(Icons.reset_tv),
              ),
              const SizedBox(
                width: 20,
              ),
              FloatingActionButton(
                onPressed: () {
                  context.read<ThemeProvider>().toggleTheme();
                },
                tooltip: 'switch mode',
                child: Icon(Provider.of<ThemeProvider>(context, listen: false)
                        .isDarkMode
                    ? Icons.dark_mode
                    : Icons.light_mode),
              ),
            ],
          ),
        );
      }),
    );
  }
}
