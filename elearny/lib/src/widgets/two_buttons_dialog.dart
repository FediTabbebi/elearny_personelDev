import 'package:elearny/data/globales.dart';
import 'package:flutter/material.dart';

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
      insetPadding: deviceType != 1
          ? deviceType == 2
              ? const EdgeInsets.only(left: 80, right: 80)
              : const EdgeInsets.only(left: 30, right: 30)
          : const EdgeInsets.only(left: 300, right: 300),
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
                          ? 30
                          : 24
                      : 35,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                ),
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
                  declineBtn(
                    declinebuttonText,
                    onDecline,
                  ),
                  confirmationBtn(
                    confirmbuttonText,
                    onConfirm,
                  ),
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
    );
  }

  Widget confirmationBtn(String text, VoidCallback onPressed) {
    return SizedBox(
      height: deviceType != 1
          ? deviceType == 2
              ? 50
              : 40
          : 50,
      width: deviceType != 1
          ? deviceType == 2
              ? 120
              : 90
          : 160,
      child: ElevatedButton(
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(
              fontSize: deviceType != 1
                  ? deviceType == 2
                      ? 20
                      : 16
                  : 25,
            ),
          )),
    );
  }

  Widget declineBtn(String text, VoidCallback onPressed) {
    return SizedBox(
        height: deviceType != 1
            ? deviceType == 2
                ? 50
                : 40
            : 50,
        width: deviceType != 1
            ? deviceType == 2
                ? 120
                : 90
            : 160,
        child: TextButton(
            onPressed: onPressed,
            child: Text(
              text,
              style: TextStyle(
                fontSize: deviceType != 1
                    ? deviceType == 2
                        ? 20
                        : 16
                    : 25,
              ),
            )));
  }
}
