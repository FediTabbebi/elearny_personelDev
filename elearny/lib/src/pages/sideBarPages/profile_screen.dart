import 'package:cached_network_image/cached_network_image.dart';
import 'package:elearny/data/globales.dart';
import 'package:elearny/provider/themeProvider/theme_provider.dart';
import 'package:elearny/provider/userProvider/update_user_provider.dart';
import 'package:elearny/src/widgets/app_bar_widget.dart';
import 'package:elearny/utils/app_bar.dart';
import 'package:elearny/utils/helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../theme/themes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // context.read<UpdateUserProvider>().settingControllers();
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 100,
          title: kIsWeb
              ? Center(
                  child: Column(
                  children: [
                    Text(
                      'Profile',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      'Add informations about yourself',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ))
              : AppBarUtils.appBarWidget(
                  context, "Profile", "Add informations about yourself")),
      body: Form(
        key: context.read<UpdateUserProvider>().formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Center(
              child: Column(
                children: [
                  context.watch<UpdateUserProvider>().imageData == null
                      ? Stack(
                          children: [
                            CircleAvatar(
                                radius: deviceType == 1 ? 100 : 75,
                                backgroundColor:
                                    context.read<ThemeProvider>().isDarkMode
                                        ? Themes.darkMode
                                        : Colors.grey.shade200,
                                backgroundImage: CachedNetworkImageProvider(
                                  globalUser!.profilePicture == ""
                                      ? "assets/images/manPlaceHolder.png"
                                      : globalUser!.profilePicture,
                                )),
                            Positioned(
                              bottom: 5,
                              right: 20,
                              child: iconButton(context, Icons.edit, () {
                                context.read<UpdateUserProvider>().pickImage();
                              }, false),
                            ),
                          ],
                        )
                      : Stack(
                          alignment: Alignment.center,
                          children: [
                            CircleAvatar(
                                radius: 100,
                                backgroundColor:
                                    context.read<ThemeProvider>().isDarkMode
                                        ? Themes.darkMode4
                                        : Colors.grey.shade200,
                                backgroundImage: MemoryImage(
                                  context.read<UpdateUserProvider>().imageData!,
                                )),
                            Positioned(
                                bottom: 5,
                                right: 20,
                                child: iconButton(context, Icons.edit, () {
                                  context
                                      .read<UpdateUserProvider>()
                                      .pickImage();
                                }, false)),
                            Positioned(
                              top: 5,
                              right: 20,
                              child:
                                  iconButton(context, FontAwesomeIcons.x, () {
                                context.read<UpdateUserProvider>().removeImg();
                              }, true),
                            )
                          ],
                        ),
                  const SizedBox(
                    height: 10,
                  ),
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
                context.read<UpdateUserProvider>().addressController,
                'Local Address',
                false,
                false),
            const SizedBox(height: 16.0),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      flex: 1,
                      child: textfieldWidget(
                          context,
                          context
                              .read<UpdateUserProvider>()
                              .phoneNumberController,
                          'Phone Number',
                          false,
                          false)),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller:
                          context.read<UpdateUserProvider>().birthdayController,
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
                          onPressed: () => context
                              .read<UpdateUserProvider>()
                              .selectDate(context),
                          icon: const Icon(Icons.calendar_today),
                        ),
                      ),
                      readOnly: true,
                    ),
                  ),
                ],
              ),
            ),
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
              mainAxisAlignment:
                  kIsWeb ? MainAxisAlignment.end : MainAxisAlignment.center,
              children: [
                Consumer<UpdateUserProvider>(builder: (context, provider, _) {
                  return provider.isLoading
                      ? const SizedBox(
                          height: 60,
                          width: 60,
                          child: CircularProgressIndicator())
                      : SizedBox(
                          height: 60,
                          width: kIsWeb
                              ? 100
                              : MediaQuery.of(context).size.width / 1.07,
                          child: ElevatedButton(
                            onPressed: () async {
                              provider.updateProfile(context);
                            },
                            child: const Text('Update'),
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

  Widget iconButton(BuildContext context, IconData iconData, Function() onTap,
      bool removeIcon) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              width: 3,
              color: context.read<ThemeProvider>().isDarkMode
                  ? Themes.darkMode
                  : Colors.white,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(
                50,
              ),
            ),
            color: context.read<ThemeProvider>().isDarkMode
                ? Themes.darkMode2
                : Colors.white,
            boxShadow: [
              BoxShadow(
                offset: const Offset(2, 4),
                color: Colors.black.withOpacity(
                  0.3,
                ),
                blurRadius: 3,
              ),
            ]),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Icon(iconData, color: removeIcon ? Colors.red : null),
        ),
      ),
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
