import 'package:elearny/model/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/authProviders/register_provider.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final registrationProvider = Provider.of<RegisterProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Form(
        key: registrationProvider.formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(
                  labelText: 'First Name',
                ),
                validator: (value) =>
                    registrationProvider.validateFirstName(value!)),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _lastNameController,
              decoration: const InputDecoration(
                labelText: 'Last Name',
              ),
              validator: (value) =>
                  registrationProvider.validateLastName(value!),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
              validator: (value) => registrationProvider.validateEmail(value!),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              validator: (value) =>
                  registrationProvider.validatePassword(value!),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                await registrationProvider.registerUser(
                    User(
                      firstName: _firstNameController.text,
                      lastName: _lastNameController.text,
                      email: _emailController.text,
                      password: _passwordController.text,
                      address: '',
                      phoneNumber: '',
                      profilePicture: '',
                      bio: '',
                      company: '',
                      role: '',
                      birthDate: DateTime.now(),
                      trainigList: [],
                      userId: '',
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                      isDeleted: false,
                    ),
                    context);
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
