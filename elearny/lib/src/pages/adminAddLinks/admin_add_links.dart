import 'package:cached_network_image/cached_network_image.dart';
import 'package:elearny/data/globales.dart';
import 'package:elearny/model/admin_links.dart';
import 'package:elearny/provider/adminProviders/add_links_provider.dart';
import 'package:elearny/provider/themeProvider/theme_provider.dart';
import 'package:elearny/services/firebase/fireStore/adminAddLinks/add_links.dart';

import 'package:elearny/src/theme/themes.dart';
import 'package:elearny/src/widgets/admin_addlinks_shimmer.dart';
import 'package:elearny/utils/app_bar.dart';
import 'package:elearny/utils/helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class AdminAddLinks extends StatelessWidget {
  AdminAddLinks({super.key});
  final AdminServices adminSocialMediaServices = AdminServices();
  @override
  Widget build(BuildContext context) {
    return FutureProvider<AdminLinksModel?>(
      create: (context) => adminSocialMediaServices.getData(),
      initialData: null, // Set an initial value while the future is resolving
      child: Consumer<AdminLinksModel?>(
        builder: (context, adminLinks, _) {
          if (adminLinks == null) {
            return const AdminAddLinksShimmerWidget(); // Display a progress indicator
          } else {
            // Data is available, call settingControllers
            context.read<AdminAddLinkProvider>().settingControllers(adminLinks);

            return mainScreen(
              context,
            );
          }
        },
      ),
    );
  }
}

Widget mainScreen(BuildContext context) {
  return SafeArea(
    child: Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 100,
          title: kIsWeb
              ? Center(
                  child: Text(
                  'Social Media Links',
                  style: Theme.of(context).textTheme.bodyLarge,
                ))
              : AppBarUtils.appBarWidget(context, "Social Media Links",
                  "Here you can modify social media links")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: context.read<AdminAddLinkProvider>().formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: Text(
                    "Main Page Pictures",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                Center(
                  child: Wrap(
                    spacing: 20,
                    children: [
                      mainPagePictureWidget("The Team logo image", 1, context),
                      mainPagePictureWidget("Landing page image", 2, context),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: Text(
                    "Social Media Links",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                textField(
                  context,
                  null,
                  "assets/icons/facebook.png",
                  context.read<AdminAddLinkProvider>().facebookTextField,
                  "facebook",
                ),
                textField(
                    context,
                    null,
                    "assets/icons/linkedIn2.png",
                    context.read<AdminAddLinkProvider>().linkedInTextfield,
                    "LinkedIn"),
                textField(
                    context,
                    null,
                    "assets/icons/whatsApp.png",
                    context.read<AdminAddLinkProvider>().whatsAppTextfield,
                    "Whats App"),
                textField(
                    context,
                    null,
                    "assets/icons/instagram.png",
                    context.read<AdminAddLinkProvider>().instagramTexfield,
                    "Instagram"),
                textField(
                    context,
                    null,
                    "assets/icons/youtube.png",
                    context.read<AdminAddLinkProvider>().youtubeTexfield,
                    "Youtube"),
                textField(
                    context,
                    FontAwesomeIcons.solidEnvelope,
                    "",
                    context.read<AdminAddLinkProvider>().emailTextfield,
                    "Email Address"),
                textField(
                    context,
                    FontAwesomeIcons.phoneVolume,
                    "",
                    context.read<AdminAddLinkProvider>().phoneNumbertextfield,
                    "Phone Number"),
                const SizedBox(
                  height: 32,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: Text(
                    "App Download URLs ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                downloadApp(
                    "Get it on",
                    "Google Play",
                    "assets/images/GooglePlayIcon.png",
                    context,
                    context.read<AdminAddLinkProvider>().playStoreTextfield,
                    "Google Play Link"),
                downloadApp(
                    "Donwload",
                    "Android APK",
                    "assets/images/ApkIcon.png",
                    context,
                    context.read<AdminAddLinkProvider>().apkTextfield,
                    "Android APk Link"),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: kIsWeb
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.center,
                    children: [
                      Consumer<AdminAddLinkProvider>(
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
                                    await context
                                        .read<AdminAddLinkProvider>()
                                        .createOrUpdateAdminLinks(context);
                                  },
                                  child: const Text('Save'),
                                ));
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Widget mainPagePictureWidget(
    String imageLabel, int widget, BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        height: deviceType != 1
            ? deviceType == 2
                ? 220
                : 200
            : 260,
        width: deviceType != 1
            ? deviceType == 2
                ? 340
                : 280
            : 400,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                imageLabel,
                style: const TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Consumer<AdminAddLinkProvider>(builder: (context, update, _) {
              return SizedBox(
                height: deviceType != 1
                    ? deviceType == 2
                        ? 160
                        : 140
                    : 200,
                width: deviceType != 1
                    ? deviceType == 2
                        ? 340
                        : 280
                    : 400,
                child: Card(
                  elevation: 0.5,
                  child: kIsWeb
                      ? widget == 1
                          ? update.landingImg == null
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: update.landingImgURL.isNotEmpty
                                      ? CachedNetworkImage(
                                          imageUrl: update.landingImgURL,
                                          // progressIndicatorBuilder: (context,
                                          //         url,
                                          //         downloadProgress) =>
                                          //     CircularProgressIndicator(
                                          //         value:
                                          //             downloadProgress
                                          //                 .progress),
                                          errorWidget: (context, url, error) {
                                            print(error);
                                            return const Icon(Icons.error);
                                          })
                                      : Image.asset(
                                          "assets/images/PlaceholderImg.png"),
                                )
                              : Image.memory(update.landingImg!)
                          : update.logoImg == null
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: update.logoImgURL.isNotEmpty
                                      ? CachedNetworkImage(
                                          imageUrl: update.logoImgURL,
                                          // progressIndicatorBuilder: (context,
                                          //         url,
                                          //         downloadProgress) =>
                                          //     CircularProgressIndicator(
                                          //         value:
                                          //             downloadProgress
                                          //                 .progress),
                                          errorWidget: (context, url, error) {
                                            print(error);
                                            return const Icon(Icons.error);
                                          })
                                      : Image.asset(
                                          "assets/images/PlaceholderImg.png"),
                                )
                              : Image.memory(update.logoImg!)
                      : widget == 1
                          ? update.landingImgMobile == null
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: update.landingImgURL.isNotEmpty
                                      ? CachedNetworkImage(
                                          imageUrl: update.landingImgURL,

                                          // progressIndicatorBuilder: (context,
                                          //         url,
                                          //         downloadProgress) =>
                                          //     CircularProgressIndicator(
                                          //         value:
                                          //             downloadProgress
                                          //                 .progress),
                                          errorWidget: (context, url, error) {
                                            print(error);
                                            return const Icon(Icons.error);
                                          })
                                      : Image.asset(
                                          "assets/images/PlaceholderImg.png",
                                        ),
                                )
                              : Image.file(update.landingImgMobile!)
                          : update.logoImgMobile == null
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: update.logoImgURL.isNotEmpty
                                      ? CachedNetworkImage(
                                          imageUrl: update.logoImgURL,
                                          // progressIndicatorBuilder: (context,
                                          //         url,
                                          //         downloadProgress) =>
                                          //     CircularProgressIndicator(
                                          //         value:
                                          //             downloadProgress
                                          //                 .progress),
                                          errorWidget: (context, url, error) {
                                            print(error);
                                            return const Icon(Icons.error);
                                          })
                                      : Image.asset(
                                          "assets/images/PlaceholderImg.png"),
                                )
                              : Image.file(update.logoImgMobile!),
                ),
              );
            }),
            Positioned(
                top: 15,
                right: 10,
                child: iconButton(context, Icons.edit, () {
                  context
                      .read<AdminAddLinkProvider>()
                      .pickImage(widget == 1 ? 1 : 2);
                }))
          ],
        ),
      )
    ],
  );
}

Widget textField(BuildContext context, IconData? icon, String imageIconPath,
    TextEditingController textEditingController, String? labelText) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20.0, left: 10),
          child: SizedBox(
            height: 60,
            width: 60,
            // decoration: BoxDecoration(
            //     border: Border.all(color: Colors.grey), shape: BoxShape.circle),
            child: icon == null
                ? Image.asset(imageIconPath)
                : Icon(icon, size: 45, color: Themes.green),
          ),
        ),
        Expanded(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child:
                  textFieldWidget(textEditingController, labelText, context)),
        ),
      ],
    ),
  );
}

Widget downloadApp(
    String firstText,
    String secondText,
    String imagePath,
    BuildContext context,
    TextEditingController textEditingController,
    String? labelText) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Padding(
            padding: const EdgeInsets.only(right: 20.0, left: 10),
            child: SizedBox(
              width: 160,
              height: 65,
              child: Card(
                child: Row(children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Image.asset(imagePath),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        firstText,
                        style: const TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 10),
                      ),
                      Text(
                        secondText,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      )
                    ],
                  )
                ]),
              ),
            )),
        Expanded(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child:
                  textFieldWidget(textEditingController, labelText, context)),
        ),
      ],
    ),
  );
}

Widget textFieldWidget(TextEditingController textEditingController,
    String? labelText, BuildContext context) {
  return TextFormField(
    controller: textEditingController,
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
    validator: (value) => ValidateFields().validateEmptyField(value),
  );
}

Widget iconButton(
  BuildContext context,
  IconData iconData,
  Function() onTap,
) {
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
        child: Icon(
          iconData,
        ),
      ),
    ),
  );
}
