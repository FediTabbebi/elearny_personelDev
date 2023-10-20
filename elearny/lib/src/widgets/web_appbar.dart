import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WebAppBar extends StatelessWidget {
  const WebAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Elearny",
          style: TextStyle(fontSize: 60.sp, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            Text(
              "Home",
              style: TextStyle(fontSize: 30.sp),
            ),
            SizedBox(
              width: 150.w,
            ),
            Text(
              "Courses",
              style: TextStyle(fontSize: 30.sp),
            ),
            SizedBox(
              width: 150.w,
            ),
            Text(
              "contact us",
              style: TextStyle(fontSize: 30.sp),
            ),
            SizedBox(
              width: 150.w,
            ),
            Text(
              "About us ",
              style: TextStyle(fontSize: 30.sp),
            ),
          ],
        ),
        Row(
          children: [
            ElevatedButton(
                onPressed: () {},
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: 22.sp),
                )),
            const SizedBox(
              width: 20,
            ),
            ElevatedButton(
                onPressed: () {},
                child: Text(
                  "Sign up",
                  style: TextStyle(fontSize: 22.sp),
                ))
          ],
        )
      ],
    );
  }
}
