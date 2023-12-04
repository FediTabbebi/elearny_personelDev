import 'package:elearny/model/user_model.dart';
import 'package:elearny/src/theme/themes.dart';
import 'package:elearny/src/widgets/shared_widget/app_bar_widget.dart';
import 'package:elearny/src/widgets/shared_widget/loading_indicator_widget.dart';
import 'package:elearny/src/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../provider/authProviders/register_provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ValidateFields validate = ValidateFields();

    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBarWidget(
          title: "Register",
          subtitle: "",
          centerTitle: true,
          // leading: IconButton(
          //     splashRadius: 20,
          //     onPressed: () {
          //       context.pop();
          //     },
          //     icon: const Icon(
          //       Icons.chevron_left,
          //       size: 40,
          //     )),
        ),
        body: Form(
          key: context.read<RegisterProvider>().formKey,
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: <Widget>[
              TextFormField(
                  controller:
                      context.read<RegisterProvider>().firstNameController,
                  decoration: const InputDecoration(
                    labelText: 'First Name',
                  ),
                  validator: (value) => validate.validateFirstName(value!)),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: context.read<RegisterProvider>().lastNameController,
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                ),
                validator: (value) => validate.validateLastName(value!),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: context.read<RegisterProvider>().emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                validator: (value) => validate.validateEmail(value!),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: context.read<RegisterProvider>().passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                validator: (value) => validate.validatePassword(value!),
              ),
              const SizedBox(height: 16.0),
              context.watch<RegisterProvider>().isLoading
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
                      child: ElevatedButton(
                        onPressed: () async {
                          await context.read<RegisterProvider>().registerUser(
                              UserModel(
                                firstName: context
                                    .read<RegisterProvider>()
                                    .firstNameController
                                    .text,
                                lastName: context
                                    .read<RegisterProvider>()
                                    .lastNameController
                                    .text,
                                email: context
                                    .read<RegisterProvider>()
                                    .emailController
                                    .text,
                                password: context
                                    .read<RegisterProvider>()
                                    .passwordController
                                    .text,
                                address: '',
                                phoneNumber: '',
                                profilePicture: '',
                                bio: '',
                                company: '',
                                role: 'Client',
                                birthDate: DateTime.now(),
                                trainingList: [],
                                userId: '',
                                createdAt: DateTime.now(),
                                updatedAt: DateTime.now(),
                                isDeleted: false,
                              ),
                              context);
                        },
                        child: const Text('Register'),
                      ),
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        context.pop();
                      },
                      child: const Text("Login")),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
