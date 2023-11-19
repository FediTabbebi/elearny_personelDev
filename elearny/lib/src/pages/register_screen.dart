import 'package:elearny/model/user.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../provider/authProviders/register_provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final registrationProvider = Provider.of<RegisterProvider>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // leading: IconButton(
          //   icon: Icon(Icons.arrow_back, color: Colors.black),
          //   onPressed: () => Navigator.of(context).pop(),
          // ),
          automaticallyImplyLeading: false,
          title: Center(
              child: Text(
            'Register',
            style: Theme.of(context).textTheme.bodyLarge,
          )),
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
                  validator: (value) => context
                      .read<RegisterProvider>()
                      .validate
                      .validateFirstName(value!)),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: context.read<RegisterProvider>().lastNameController,
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                ),
                validator: (value) => context
                    .read<RegisterProvider>()
                    .validate
                    .validateLastName(value!),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: context.read<RegisterProvider>().emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                validator: (value) => context
                    .read<RegisterProvider>()
                    .validate
                    .validateEmail(value!),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: context.read<RegisterProvider>().passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                validator: (value) => context
                    .read<RegisterProvider>()
                    .validate
                    .validatePassword(value!),
              ),
              const SizedBox(height: 16.0),
              context.watch<RegisterProvider>().isLoading
                  ? const SizedBox(
                      height: 50, width: 50, child: CircularProgressIndicator())
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
                                role: '',
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
