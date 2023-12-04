import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WebAppBar extends StatelessWidget {
  const WebAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Elearny", style: Theme.of(context).textTheme.bodyLarge),
        Row(
          children: [
            const Text(
              "Home",
            ),
            SizedBox(
              width: 150.w,
            ),
            const Text(
              "Courses",
            ),
            SizedBox(
              width: 150.w,
            ),
            const Text(
              "contact us",
            ),
            SizedBox(
              width: 150.w,
            ),
            const Text(
              "About us ",
            ),
          ],
        ),
        Row(
          children: [
            ElevatedButton(
                onPressed: () {},
                child: const Text(
                  "Login",
                  style: TextStyle(),
                )),
            const SizedBox(
              width: 20,
            ),
            ElevatedButton(
                onPressed: () {},
                child: const Text(
                  "Sign up",
                  style: TextStyle(),
                ))
          ],
        )
      ],
    );
  }
}
