import 'package:cached_network_image/cached_network_image.dart';
import 'package:elearny/data/globales.dart';
import 'package:elearny/provider/themeProvider/theme_provider.dart';
import 'package:elearny/provider/userProvider/update_user_provider.dart';
import 'package:elearny/src/widgets/shared_widget/app_bar_widget.dart';

import 'package:elearny/src/widgets/shared_widget/loading_indicator_widget.dart';
import 'package:elearny/src/utils/helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../../provider/userProvider/user_provider.dart';
import '../../theme/themes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<UpdateUserProvider>().settingControllers(context);
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBarWidget(
          title: 'Profile',
          subtitle: 'Add informations about yourself',
        ),
        body: LayoutBuilder(builder: (context, condtraint) {
          return GestureDetector(
            onTap: () {
              // This will dismiss the keyboard when tapping outside of a text field
              FocusScope.of(context).unfocus();
            },
            child: Form(
              key: context.read<UpdateUserProvider>().formKey,
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  Center(
                    child: Column(
                      children: [
                        kIsWeb
                            ? context.watch<UpdateUserProvider>().imageData ==
                                    null
                                ? Stack(
                                    children: [
                                      context
                                              .read<UserProvider>()
                                              .currentUser!
                                              .profilePicture
                                              .isEmpty
                                          ? Container(
                                              width:
                                                  deviceType == 1 ? 220 : 150,
                                              height:
                                                  deviceType == 1 ? 220 : 150,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                      "assets/images/manPlaceHolder.png",
                                                    ),
                                                    fit: BoxFit.cover),
                                              ),
                                            )
                                          : CachedNetworkImage(
                                              imageUrl: context
                                                  .read<UserProvider>()
                                                  .currentUser!
                                                  .profilePicture,
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      Container(
                                                width:
                                                    deviceType == 1 ? 200 : 150,
                                                height:
                                                    deviceType == 1 ? 200 : 150,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover),
                                                ),
                                              ),
                                              placeholder: (context, url) =>
                                                  const LoadingIndicatorWidget(
                                                      color: Themes.green,
                                                      size: 50),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            ),

                                      // CircleAvatar(
                                      //     radius: deviceType == 1 ? 100 : 75,
                                      //     backgroundColor: context
                                      //             .read<ThemeProvider>()
                                      //             .isDarkMode
                                      //         ? Themes.darkMode
                                      //         : Colors.grey.shade200,
                                      //     backgroundImage:
                                      //        ),
                                      Positioned(
                                        bottom: 5,
                                        right: 20,
                                        child:
                                            iconButton(context, Icons.edit, () {
                                          context
                                              .read<UpdateUserProvider>()
                                              .pickImage();
                                        }, false),
                                      ),
                                    ],
                                  )
                                : Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      CircleAvatar(
                                          radius: deviceType == 1 ? 100 : 75,
                                          backgroundColor: context
                                                  .read<ThemeProvider>()
                                                  .isDarkMode
                                              ? Themes.darkMode4
                                              : Colors.grey.shade200,
                                          backgroundImage: MemoryImage(
                                            context
                                                .read<UpdateUserProvider>()
                                                .imageData!,
                                          )),
                                      Positioned(
                                          bottom: 5,
                                          right: 20,
                                          child: iconButton(context, Icons.edit,
                                              () {
                                            context
                                                .read<UpdateUserProvider>()
                                                .pickImage();
                                          }, false)),
                                      Positioned(
                                        top: deviceType == 1 ? 5 : 0,
                                        right: 20,
                                        child: iconButton(
                                            context, FontAwesomeIcons.x, () {
                                          context
                                              .read<UpdateUserProvider>()
                                              .removeImg();
                                        }, true),
                                      )
                                    ],
                                  )
                            : context
                                        .watch<UpdateUserProvider>()
                                        .imageDataMobile ==
                                    null
                                ? Stack(
                                    children: [
                                      context
                                              .read<UserProvider>()
                                              .currentUser!
                                              .profilePicture
                                              .isEmpty
                                          ? Container(
                                              width:
                                                  deviceType == 1 ? 220 : 150,
                                              height:
                                                  deviceType == 1 ? 220 : 150,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                      "assets/images/manPlaceHolder.png",
                                                    ),
                                                    fit: BoxFit.cover),
                                              ),
                                            )
                                          : CachedNetworkImage(
                                              imageUrl: context
                                                  .read<UserProvider>()
                                                  .currentUser!
                                                  .profilePicture,
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      Container(
                                                width:
                                                    deviceType == 1 ? 220 : 150,
                                                height:
                                                    deviceType == 1 ? 220 : 150,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover),
                                                ),
                                              ),
                                              placeholder: (context, url) =>
                                                  const LoadingIndicatorWidget(
                                                      color: Themes.green,
                                                      size: 50),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            ),
                                      Positioned(
                                        bottom: 5,
                                        right: 20,
                                        child:
                                            iconButton(context, Icons.edit, () {
                                          context
                                              .read<UpdateUserProvider>()
                                              .pickImage();
                                        }, false),
                                      ),
                                    ],
                                  )
                                : Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      CircleAvatar(
                                          radius: deviceType == 1 ? 100 : 75,
                                          backgroundColor: context
                                                  .read<ThemeProvider>()
                                                  .isDarkMode
                                              ? Themes.darkMode4
                                              : Colors.grey.shade200,
                                          backgroundImage: FileImage(
                                            context
                                                .read<UpdateUserProvider>()
                                                .imageDataMobile!,
                                          )),
                                      Positioned(
                                          bottom: 5,
                                          right: 20,
                                          child: iconButton(context, Icons.edit,
                                              () {
                                            context
                                                .read<UpdateUserProvider>()
                                                .pickImage();
                                          }, false)),
                                      Positioned(
                                        top: 5,
                                        right: 20,
                                        child: iconButton(
                                            context, FontAwesomeIcons.x, () {
                                          context
                                              .read<UpdateUserProvider>()
                                              .removeImg();
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
                            controller: context
                                .read<UpdateUserProvider>()
                                .birthdayController,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color:
                                        context.read<ThemeProvider>().isDarkMode
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
                    controller:
                        context.read<UpdateUserProvider>().bioController,
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
                    mainAxisAlignment: kIsWeb
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.center,
                    children: [
                      Consumer<UpdateUserProvider>(
                          builder: (context, provider, _) {
                        return provider.isLoading
                            ? const SizedBox(
                                height: 60,
                                width: 60,
                                child: CircularProgressIndicator())
                            : SizedBox(
                                height: 60,
                                width: kIsWeb
                                    ? 100
                                    : MediaQuery.of(context).size.width / 1.1,
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
        }),
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
        height: deviceType == 1 ? 40 : 30,
        width: deviceType == 1 ? 40 : 30,
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
          child: Center(
              child: Icon(
            iconData,
            color: removeIcon ? Colors.red : null,
            size: deviceType == 1 ? 25 : 20,
          )),
        ),
      ),
    );
  }
}
