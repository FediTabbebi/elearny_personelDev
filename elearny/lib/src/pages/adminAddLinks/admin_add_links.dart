import 'package:cached_network_image/cached_network_image.dart';
import 'package:elearny/data/globales.dart';
import 'package:elearny/model/admin_links.dart';
import 'package:elearny/provider/adminProviders/add_links_provider.dart';
import 'package:elearny/provider/themeProvider/theme_provider.dart';

import 'package:elearny/src/theme/themes.dart';
import 'package:elearny/src/widgets/admin_addlinks_shimmer.dart';
import 'package:elearny/src/widgets/loading_indicator_widget.dart';
import 'package:elearny/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../widgets/app_bar_widget.dart';

class AdminAddLinks extends StatelessWidget {
  const AdminAddLinks({super.key});

  @override
  Widget build(BuildContext context) {
    return context.read<AdminAddLinkProvider>().isInitialized
        ? mainScreen(context)
        : FutureBuilder<void>(
            future: context.read<AdminAddLinkProvider>().getLinks(context),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const AdminAddLinksShimmerWidget();
              } else {
                context.read<AdminAddLinkProvider>().initi();
                return mainScreen(context);
              }
            },
          );
  }
}

Widget mainScreen(BuildContext context) {
  return SafeArea(
    child: Scaffold(
      appBar: AppBar(
        title: deviceType != 1
            ? deviceType == 2
                ? appBarWidget(context)
                : appBarWidget(context)
            : Center(
                child: Text(
                'Social Media Links',
                style: Theme.of(context).textTheme.bodyLarge,
              )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: context.read<AdminAddLinkProvider>().formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Main Page Pictures",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Center(
                  child: Wrap(
                    children: [
                      mainPagePictureWidget("The Team logo image", 1, context),
                      mainPagePictureWidget("Landing page image", 2, context),
                    ],
                  ),
                ),
                const Text(
                  "Social Media Links",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                textField(
                    context,
                    FontAwesomeIcons.facebookF,
                    context.read<AdminAddLinkProvider>().facebookTextField,
                    "facebook"),
                textField(
                    context,
                    FontAwesomeIcons.linkedin,
                    context.read<AdminAddLinkProvider>().linkedInTextfield,
                    "LinkedIn"),
                textField(
                    context,
                    FontAwesomeIcons.whatsapp,
                    context.read<AdminAddLinkProvider>().whatsAppTextfield,
                    "Whats App"),
                textField(
                    context,
                    FontAwesomeIcons.instagram,
                    context.read<AdminAddLinkProvider>().instagramTexfield,
                    "Instagram"),
                textField(
                    context,
                    FontAwesomeIcons.youtube,
                    context.read<AdminAddLinkProvider>().youtubeTexfield,
                    "Youtube"),
                textField(
                    context,
                    FontAwesomeIcons.envelope,
                    context.read<AdminAddLinkProvider>().emailTextfield,
                    "Email Address"),
                textField(
                    context,
                    FontAwesomeIcons.phone,
                    context.read<AdminAddLinkProvider>().phoneNumbertextfield,
                    "Phone Number"),
                const Text(
                  "App Download URLs ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
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
                    mainAxisAlignment: MainAxisAlignment.end,
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
                                width: 100,
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
                  child: widget == 1
                      ? update.landingImg == null
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CachedNetworkImage(
                                  imageUrl: update.landingImgURL.isNotEmpty
                                      ? update.landingImgURL
                                      : "assets/images/PlaceholderImg.png",
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
                                  }),
                            )
                          : Image.memory(update.landingImg!)
                      : update.logoImg == null
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CachedNetworkImage(
                                  imageUrl: update.logoImgURL.isNotEmpty
                                      ? update.logoImgURL
                                      : "assets/images/PlaceholderImg.png",
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
                                  }),
                            )
                          : Image.memory(update.logoImg!),
                ),
              );
            }),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                  child: const Text(
                    "Edit",
                  ),
                  onPressed: () {
                    context
                        .read<AdminAddLinkProvider>()
                        .pickImage(widget == 1 ? 1 : 2);
                  }),
            ),
          ],
        ),
      )
    ],
  );
}

Widget textField(BuildContext context, IconData icon,
    TextEditingController textEditingController, String? labelText) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20.0, left: 10),
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey), shape: BoxShape.circle),
            child: Icon(
              icon,
              size: 35,
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
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

Widget appBarWidget(BuildContext context) {
  return AppBarWidget(
    leftIcon: Icons.arrow_back,
    onPressedLeftIcon: () {
      Navigator.pop(context);
    },
    rightIcon: null,
    title: "Social Media Link",
    subtitle: "Here you can modify social media links",
  );
}
