import 'package:elearny/data/globales.dart';
import 'package:elearny/provider/deviceTypeProvider/device_type_provider.dart';
import 'package:elearny/src/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TwoButtonsDialogWidget extends StatelessWidget {
  final String title;
  final String contents;
  final String confirmbuttonText;
  final VoidCallback onConfirm;
  final String declinebuttonText;
  final VoidCallback onDecline;

  const TwoButtonsDialogWidget({
    Key? key,
    required this.title,
    required this.contents,
    required this.confirmbuttonText,
    required this.onConfirm,
    required this.declinebuttonText,
    required this.onDecline,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: deviceType != 1
            ? deviceType == 2
                ? 400
                : 350
            : 600,
        child: Wrap(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                deviceType != 1
                    ? deviceType == 2
                        ? const SizedBox(
                            height: 25,
                          )
                        : const SizedBox(height: 15)
                    : const SizedBox(
                        height: 30,
                      ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: deviceType != 1
                        ? deviceType == 2
                            ? 24
                            : 20
                        : 28,
                    fontWeight: FontWeight.bold,
                    color: Themes.green,
                  ),
                  textAlign: TextAlign.center,
                ),
                deviceType != 1
                    ? deviceType == 2
                        ? const SizedBox(
                            height: 25,
                          )
                        : const SizedBox(height: 15)
                    : const SizedBox(
                        height: 30,
                      ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Text(
                        contents,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                deviceType != 1
                    ? deviceType == 2
                        ? const SizedBox(
                            height: 50,
                          )
                        : const SizedBox(height: 30)
                    : const SizedBox(
                        height: 60,
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    declineBtn(declinebuttonText, onDecline, context),
                    confirmationBtn(confirmbuttonText, onConfirm, context),
                  ],
                ),
                deviceType != 1
                    ? deviceType == 2
                        ? const SizedBox(
                            height: 20,
                          )
                        : const SizedBox(height: 15)
                    : const SizedBox(
                        height: 30,
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget confirmationBtn(
      String text, VoidCallback onPressed, BuildContext context) {
    return SizedBox(
      height: deviceType != 1
          ? deviceType == 2
              ? 50
              : 45
          : 60,
      width: deviceType != 1
          ? deviceType == 2
              ? 120
              : 120
          : 140,
      child: ElevatedButton(
          onPressed: onPressed,
          child: Text(
            text,
          )),
    );
  }

  Widget declineBtn(String text, VoidCallback onPressed, BuildContext context) {
    return SizedBox(
      height: deviceType != 1
          ? deviceType == 2
              ? 50
              : 45
          : 60,
      width: deviceType != 1
          ? deviceType == 2
              ? 120
              : 120
          : 140,
      child: TextButton(
          onPressed: onPressed,
          child: Text(
            text,
            // style: TextStyle(
            //   fontSize: deviceType != 1
            //       ? deviceType == 2
            //           ? 16
            //           : 16
            //       : 16,
            // ),
          )),
    );
  }
}
