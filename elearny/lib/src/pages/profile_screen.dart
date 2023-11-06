import 'package:cached_network_image/cached_network_image.dart';
import 'package:elearny/data/globales.dart';
import 'package:elearny/provider/themeProvider/theme_provider.dart';
import 'package:elearny/provider/userProvider/update_user_provider.dart';
import 'package:elearny/src/widgets/app_bar_widget.dart';
import 'package:elearny/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../theme/themes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // context.read<UpdateUserProvider>().settingControllers();
    return Scaffold(
      appBar: AppBar(
        title: deviceType != 1
            ? deviceType == 2
                ? appBarWidget(context)
                : appBarWidget(context)
            : Center(
                child: Text(
                'Profile',
                style: Theme.of(context).textTheme.bodyLarge,
              )),
      ),
      body: Form(
        key: context.read<UpdateUserProvider>().formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Center(
              child: Column(
                children: [
                  context.watch<UpdateUserProvider>().imageData == null
                      ? SizedBox(
                          height: 200,
                          width: 200,
                          child: CachedNetworkImage(
                              imageUrl: globalUser!.profilePicture == ""
                                  ? "assets/images/manPlaceHolder.png"
                                  : globalUser!.profilePicture,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) => Card(
                                      elevation: 0,
                                      color: context
                                              .read<ThemeProvider>()
                                              .isDarkMode
                                          ? Themes.darkMode
                                          : const Color(0xffE9E8E3)),
                              errorWidget: (context, url, error) {
                                return const Icon(Icons.error);
                              }),
                        )
                      : Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                              color: context.read<ThemeProvider>().isDarkMode
                                  ? Themes.darkMode
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.memory(context
                                  .read<UpdateUserProvider>()
                                  .imageData!),
                              Align(
                                alignment: Alignment.topRight,
                                child: InkWell(
                                  child: Icon(
                                    FontAwesomeIcons.xmark,
                                    color: Colors.red,
                                    size: deviceType != 1
                                        ? deviceType == 2
                                            ? 30
                                            : 20
                                        : 40,
                                  ),
                                  onTap: () {
                                    context
                                        .read<UpdateUserProvider>()
                                        .removeImg();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                      child: const Text(
                        "Pick Image",
                      ),
                      onPressed: () {
                        context.read<UpdateUserProvider>().pickImage();
                      }),
                ],
              ),
            ),
            const SizedBox(height: 32.0),
            textfieldWidget(
                context,
                context.read<UpdateUserProvider>().firstNameController,
                'First Name',
                true,
                false),
            const SizedBox(height: 16.0),
            textfieldWidget(
                context,
                context.read<UpdateUserProvider>().lastNameController,
                'Last Name',
                true,
                false),
            const SizedBox(height: 16.0),
            textfieldWidget(
                context,
                context.read<UpdateUserProvider>().emailController,
                'Email Address',
                true,
                true),
            const SizedBox(height: 16.0),
            textfieldWidget(
                context,
                context.read<UpdateUserProvider>().phoneNumberController,
                'Phone Number',
                false,
                false),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: context.read<UpdateUserProvider>().birthdayController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: context.read<ThemeProvider>().isDarkMode
                          ? Themes.fillColorDark
                          : Themes.fillColorLight,
                      width: 0.25,
                    ),
                    borderRadius: BorderRadius.circular(5)),
                focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Themes.grey,
                    width: 0.25,
                  ),
                ),
                labelText: 'Birthday',
                suffixIcon: IconButton(
                  onPressed: () =>
                      context.read<UpdateUserProvider>().selectDate(context),
                  icon: const Icon(Icons.calendar_today),
                ),
              ),
              readOnly: true,
            ),
            const SizedBox(height: 16.0),
            textfieldWidget(
                context,
                context.read<UpdateUserProvider>().addressController,
                'Local Address',
                false,
                false),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: context.read<UpdateUserProvider>().bioController,
              decoration: InputDecoration(
                  labelText: "bio",
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: context.read<ThemeProvider>().isDarkMode
                            ? Themes.fillColorDark
                            : Themes.fillColorLight,
                        width: 0.25,
                      ),
                      borderRadius: BorderRadius.circular(5)),
                  focusedErrorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Themes.grey,
                      width: 0.25,
                    ),
                  )),
              maxLines: 6,
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Consumer<UpdateUserProvider>(builder: (context, provider, _) {
                  return provider.isLoading
                      ? const SizedBox(
                          height: 60,
                          width: 60,
                          child: CircularProgressIndicator())
                      : SizedBox(
                          height: 60,
                          width: 100,
                          child: ElevatedButton(
                            onPressed: () async {
                              provider.updateProfile(context);
                            },
                            child: const Text('Save'),
                          ),
                        );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget textfieldWidget(BuildContext context, TextEditingController controller,
      String labelText, bool validateField, bool readOnly) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          labelText: labelText,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: context.read<ThemeProvider>().isDarkMode
                    ? Themes.fillColorDark
                    : Themes.fillColorLight,
                width: 0.25,
              ),
              borderRadius: BorderRadius.circular(5)),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Themes.grey,
              width: 0.25,
            ),
          )),
      validator: (value) =>
          validateField ? ValidateFields().validateEmptyField(value) : null,
      readOnly: readOnly,
    );
  }

  Widget appBarWidget(BuildContext context) {
    return AppBarWidget(
      leftIcon: Icons.arrow_back,
      onPressedLeftIcon: () {
        context.pop();
      },
      rightIcon: null,
      title: "Profile",
      subtitle: "Here you can edit your profile informations",
    );
  }
}
