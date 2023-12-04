import 'package:cached_network_image/cached_network_image.dart';
import 'package:elearny/core/data/globales.dart';
import 'package:elearny/core/models/admin_social_links_model.dart';
import 'package:elearny/core/providers/admin_providers/admin_edit_social_links_provider.dart';

import 'package:elearny/core/providers/themeProvider/theme_provider.dart';
import 'package:elearny/core/services/firestore/admin/admin_edit_social_links/add_social_link_services.dart';
import 'package:elearny/core/constants/assets.dart';

import 'package:elearny/ui/theme/themes.dart';
import 'package:elearny/ui/widgets/admin_widget/admin_edit_social_links_shimmer.dart';
import 'package:elearny/ui/widgets/shared_widget/app_bar_widget.dart';
import 'package:elearny/ui/widgets/shared_widget/loading_indicator_widget.dart';
import 'package:elearny/core/utils/helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class AdminAddLinks extends StatelessWidget {
  AdminAddLinks({super.key});
  final AdminServices adminSocialMediaServices = AdminServices();
  @override
  Widget build(BuildContext context) {
    return FutureProvider<List<AdminLinksModel?>?>(
        create: (context) => adminSocialMediaServices.getData(),
        initialData: null, // Set an initial value while the future is resolving
        child: Consumer<List<AdminLinksModel?>?>(
          builder: (context, adminLinksData, _) {
            if (adminLinksData == null) {
              return const AdminAddLinksShimmerWidget();
            } else if (adminLinksData.isEmpty) {
              // Data is is not available so don't set the cotrollers ,display the screen with empty fields,

              return mainScreen(context);
            } else {
              // Data is available, call settingControllers

              context
                  .read<AdminEditSocialLinksProvider>()
                  .settingControllers(adminLinksData.first);

              return mainScreen(context);
            }
          },
        ));
  }
}

Widget mainScreen(
  BuildContext context,
) {
  return LayoutBuilder(builder: (context, constraints) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBarWidget(
          title: 'Social Media Links',
          subtitle: 'Here you can modify social media links',
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: context.read<AdminEditSocialLinksProvider>().formKey,
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
                        mainPagePictureWidget(
                            "The Team logo image", 1, context),
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
                    context
                        .read<AdminEditSocialLinksProvider>()
                        .facebookTextField,
                    "facebook",
                  ),
                  textField(
                      context,
                      null,
                      "assets/icons/linkedIn.png",
                      context
                          .read<AdminEditSocialLinksProvider>()
                          .linkedInTextfield,
                      "LinkedIn"),
                  textField(
                      context,
                      null,
                      "assets/icons/whatsApp.png",
                      context
                          .read<AdminEditSocialLinksProvider>()
                          .whatsAppTextfield,
                      "Whats App"),
                  textField(
                      context,
                      null,
                      "assets/icons/instagram.png",
                      context
                          .read<AdminEditSocialLinksProvider>()
                          .instagramTexfield,
                      "Instagram"),
                  textField(
                      context,
                      null,
                      "assets/icons/youtube.png",
                      context
                          .read<AdminEditSocialLinksProvider>()
                          .youtubeTexfield,
                      "Youtube"),
                  textField(
                      context,
                      FontAwesomeIcons.solidEnvelope,
                      "",
                      context
                          .read<AdminEditSocialLinksProvider>()
                          .emailTextfield,
                      "Email Address"),
                  textField(
                      context,
                      FontAwesomeIcons.phoneVolume,
                      "",
                      context
                          .read<AdminEditSocialLinksProvider>()
                          .phoneNumbertextfield,
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
                      "assets/icons/GooglePlayIcon.png",
                      context,
                      context
                          .read<AdminEditSocialLinksProvider>()
                          .playStoreTextfield,
                      "Google Play Link"),
                  downloadApp(
                      "Donwload",
                      "Android APK",
                      "assets/icons/ApkIcon.png",
                      context,
                      context.read<AdminEditSocialLinksProvider>().apkTextfield,
                      "Android APk Link"),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: kIsWeb
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.center,
                      children: [
                        Consumer<AdminEditSocialLinksProvider>(
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
                                          .read<AdminEditSocialLinksProvider>()
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
  });
}

Widget mainPagePictureWidget(
  String imageLabel,
  int widget,
  BuildContext context,
) {
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
            Consumer<AdminEditSocialLinksProvider>(
                builder: (context, update, _) {
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
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              const UnconstrainedBox(
                                                child: SizedBox(
                                                  width: 50,
                                                  child: LoadingIndicatorWidget(
                                                      color: Themes.green,
                                                      size: 50),
                                                ),
                                              ),
                                          errorWidget: (context, url, error) {
                                            if (kDebugMode) {
                                              print(error);
                                            }
                                            return const Icon(Icons.error);
                                          })
                                      : Image.asset(Assets.noImagePlaceHolder),
                                )
                              : Image.memory(update.landingImg!)
                          : update.logoImg == null
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: update.logoImgURL.isNotEmpty
                                      ? CachedNetworkImage(
                                          imageUrl: update.logoImgURL,
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              const UnconstrainedBox(
                                                child: SizedBox(
                                                  width: 50,
                                                  child: LoadingIndicatorWidget(
                                                      color: Themes.green,
                                                      size: 50),
                                                ),
                                              ),
                                          errorWidget: (context, url, error) {
                                            if (kDebugMode) {
                                              print(error);
                                            }
                                            return const Icon(Icons.error);
                                          })
                                      : Image.asset(Assets.noImagePlaceHolder),
                                )
                              : Image.memory(update.logoImg!)
                      : widget == 1
                          ? update.landingImgMobile == null
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: update.landingImgURL.isNotEmpty
                                      ? CachedNetworkImage(
                                          imageUrl: update.landingImgURL,
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              const UnconstrainedBox(
                                                child: SizedBox(
                                                  width: 30,
                                                  child: LoadingIndicatorWidget(
                                                      color: Themes.green,
                                                      size: 30),
                                                ),
                                              ),
                                          errorWidget: (context, url, error) {
                                            if (kDebugMode) {
                                              print(error);
                                            }
                                            return const Icon(Icons.error);
                                          })
                                      : Image.asset(
                                          Assets.noImagePlaceHolder,
                                        ),
                                )
                              : Image.file(update.landingImgMobile!)
                          : update.logoImgMobile == null
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: update.logoImgURL.isNotEmpty
                                      ? CachedNetworkImage(
                                          imageUrl: update.logoImgURL,
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              const UnconstrainedBox(
                                                child: SizedBox(
                                                  width: 30,
                                                  child: LoadingIndicatorWidget(
                                                      color: Themes.green,
                                                      size: 30),
                                                ),
                                              ),
                                          errorWidget: (context, url, error) {
                                            if (kDebugMode) {
                                              print(error);
                                            }
                                            return const Icon(Icons.error);
                                          })
                                      : Image.asset(Assets.noImagePlaceHolder),
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
                      .read<AdminEditSocialLinksProvider>()
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
            height: deviceType == 1 ? 60 : 30,
            width: deviceType == 1 ? 60 : 30,
            // decoration: BoxDecoration(
            //     border: Border.all(color: Colors.grey), shape: BoxShape.circle),
            child: icon == null
                ? Image.asset(imageIconPath)
                : Icon(icon,
                    size: deviceType == 1 ? 45 : 25, color: Themes.green),
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
            color: Theme.of(context).textTheme.titleSmall!.color!,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(
              50,
            ),
          ),
          color: Theme.of(context).textTheme.titleSmall!.color,
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
