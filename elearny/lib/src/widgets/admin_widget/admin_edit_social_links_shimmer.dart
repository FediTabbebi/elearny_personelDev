import 'package:elearny/data/globales.dart';
import 'package:elearny/src/widgets/app_bar_widget_shimmer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AdminAddLinksShimmerWidget extends StatelessWidget {
  const AdminAddLinksShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: const CustomAppBarShimmerWidget(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.only(left: deviceType == 1 ? 20 : 0),
                    child: titleShimmerContainer(context, 15, 200)),
                const SizedBox(
                  height: 16,
                ),
                Center(
                  child: Wrap(
                    spacing: 20,
                    children: [
                      mainPagePictureWidget(context),
                      mainPagePictureWidget(context),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                Padding(
                    padding: EdgeInsets.only(left: deviceType == 1 ? 20 : 0),
                    child: titleShimmerContainer(context, 15, 200)),
                const SizedBox(
                  height: 32,
                ),
                textField(
                  context,
                ),
                textField(
                  context,
                ),
                textField(
                  context,
                ),
                textField(
                  context,
                ),
                textField(
                  context,
                ),
                textField(
                  context,
                ),
                textField(
                  context,
                ),
                const SizedBox(
                  height: 32,
                ),
                Padding(
                    padding: EdgeInsets.only(left: deviceType == 1 ? 20 : 0),
                    child: titleShimmerContainer(context, 15, 200)),
                const SizedBox(
                  height: 32,
                ),
                downloadApp(
                  context,
                ),
                downloadApp(
                  context,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget mainPagePictureWidget(BuildContext context) {
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
              Positioned(
                top: 10,
                left: kIsWeb
                    ? deviceType == 1
                        ? 120
                        : 60
                    : 20,
                child: titleShimmerContainer(context, 12, 160),
              ),
              SizedBox(
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
                    elevation: 0,
                    color: Theme.of(context).textTheme.headlineMedium!.color),
              ),
              Positioned(
                  top: 15,
                  right: 10,
                  child: Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            Theme.of(context).textTheme.headlineMedium!.color,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(2, 4),
                            color: Colors.black.withOpacity(
                              0.3,
                            ),
                            blurRadius: 3,
                          ),
                        ]),
                  ))
            ],
          ),
        )
      ],
    );
  }

  Widget textField(
    BuildContext context,
  ) {
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
                  color: Theme.of(context).textTheme.headlineMedium!.color,
                  shape: BoxShape.circle),
            ),
          ),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: textFieldWidget(context)),
          ),
        ],
      ),
    );
  }

  Widget downloadApp(
    BuildContext context,
  ) {
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
                  color: Theme.of(context).textTheme.headlineMedium!.color,
                  elevation: 0,
                ),
              )),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: textFieldWidget(context)),
          ),
        ],
      ),
    );
  }

  Widget textFieldWidget(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
          color: Theme.of(context).textTheme.headlineMedium!.color,
          borderRadius: BorderRadius.circular(10)),
    );
  }

  Widget titleShimmerContainer(
      BuildContext context, double height, double width) {
    return Row(
      children: [
        kIsWeb
            ? const SizedBox()
            : const SizedBox(
                width: 40,
              ),
        Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              color: Theme.of(context).textTheme.headlineMedium!.color,
              borderRadius: BorderRadius.circular(10)),
        ),
      ],
    );
  }
}
