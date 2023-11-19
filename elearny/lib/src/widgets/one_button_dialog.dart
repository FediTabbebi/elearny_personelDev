import 'package:elearny/data/globales.dart';
import 'package:elearny/src/theme/themes.dart';
import 'package:flutter/material.dart';

class OneButtonDialogWidget extends StatefulWidget {
  final String title;
  final String contents;
  final String confirmbuttonText;
  final VoidCallback onConfirm;
  final bool onWillPopScopeValue;

  const OneButtonDialogWidget({
    Key? key,
    required this.title,
    required this.contents,
    required this.confirmbuttonText,
    required this.onConfirm,
    required this.onWillPopScopeValue,
  }) : super(key: key);

  @override
  State<OneButtonDialogWidget> createState() => _OneButtonDialogWidgetState();
}

class _OneButtonDialogWidgetState extends State<OneButtonDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return widget.onWillPopScopeValue;
        },
        child: Dialog(
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
                      widget.title,
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
                          padding:
                              const EdgeInsets.only(left: 15.0, right: 15.0),
                          child: Text(
                            widget.contents,
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
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        confirmationBtn(widget.confirmbuttonText,
                            widget.onConfirm, context),
                        const SizedBox(width: 15)
                      ],
                    ),
                    deviceType != 1
                        ? const SizedBox(height: 15)
                        : const SizedBox(
                            height: 30,
                          ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

Widget confirmationBtn(String text, VoidCallback onPressed, context) {
  return SizedBox(
    height: deviceType != 1
        ? deviceType == 2
            ? 50
            : 45
        : 60,
    width: deviceType != 1
        ? deviceType == 2
            ? 100
            : 80
        : 120,
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
