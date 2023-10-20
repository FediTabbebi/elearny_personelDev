import 'package:elearny/data/globales.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OneButtonDialogWidget extends StatelessWidget {
  final String title;
  final String contents;
  final String confirmbuttonText;
  final VoidCallback onConfirm;
  final bool? onWillPopScopeValue;

  const OneButtonDialogWidget({
    Key? key,
    required this.title,
    required this.contents,
    required this.confirmbuttonText,
    required this.onConfirm,
    required this.onWillPopScopeValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return onWillPopScopeValue ?? false;
      },
      child: Dialog(
        insetPadding: deviceType != 1
            ? deviceType == 2
                ? const EdgeInsets.only(left: 80, right: 80)
                : const EdgeInsets.only(left: 30, right: 30)
            : EdgeInsets.only(left: 200.w, right: 200.w),
        child: Wrap(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                deviceType != 1
                    ? deviceType == 2
                        ? SizedBox(
                            height: 35.h,
                          )
                        : SizedBox(height: 30.h)
                    : SizedBox(
                        height: 25.h,
                      ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: deviceType != 1
                          ? deviceType == 2
                              ? 5
                              : 5
                          : 10),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: deviceType != 1
                          ? deviceType == 2
                              ? 35
                              : 24
                          : 30,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                deviceType != 1
                    ? deviceType == 2
                        ? const SizedBox(
                            height: 25,
                          )
                        : const SizedBox(height: 30)
                    : const SizedBox(
                        height: 15,
                      ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Text(
                        contents,
                        style: TextStyle(
                          fontSize: deviceType != 1
                              ? deviceType == 2
                                  ? 20
                                  : 25
                              : 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                deviceType != 1
                    ? deviceType == 2
                        ? const SizedBox(
                            height: 60,
                          )
                        : const SizedBox(height: 50)
                    : const SizedBox(
                        height: 30,
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: confirmationBtn(
                          confirmbuttonText, onConfirm, context),
                    ),
                  ],
                ),
                deviceType != 1
                    ? deviceType == 2
                        ? const SizedBox(
                            height: 25,
                          )
                        : const SizedBox(height: 30)
                    : const SizedBox(
                        height: 15,
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget confirmationBtn(String text, VoidCallback onPressed, context) {
    return SizedBox(
      height: deviceType != 1
          ? deviceType == 2
              ? 50
              : 60
          : 45,
      width: deviceType != 1
          ? deviceType == 2
              ? 120
              : 200
          : 120,
      child: TextButton(
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(
              fontSize: deviceType != 1
                  ? deviceType == 2
                      ? 20
                      : 25
                  : 16,
            ),
          )),
    );
  }
}
