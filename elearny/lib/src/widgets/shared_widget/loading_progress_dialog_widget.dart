import 'package:flutter/material.dart';

class LoadingProgressDialog extends StatelessWidget {
  final String title;
  final String content;
  const LoadingProgressDialog(
      {required this.title, required this.content, super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: SizedBox(
        width: 350,
        height: 150,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                width: 250,
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  const CircularProgressIndicator(
                    strokeWidth: 3,
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Text(
                        content,
                      )),
                ],
              ),
              const SizedBox(
                height: 25,
              )
            ],
          ),
        ),
      ),
    );
  }
}
