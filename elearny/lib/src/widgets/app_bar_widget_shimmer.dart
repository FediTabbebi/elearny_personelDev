import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomAppBarShimmerWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppBarShimmerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: kIsWeb ? 0 : 75,
      leading: kIsWeb ? null : const SizedBox(),
      automaticallyImplyLeading: false,
      centerTitle: kIsWeb ? true : false,
      toolbarHeight: 150,
      title: Column(
        crossAxisAlignment:
            kIsWeb ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          Container(
            height: 15,
            width: 150,
            decoration: BoxDecoration(
                color: Theme.of(context).textTheme.headlineMedium!.color,
                borderRadius: BorderRadius.circular(30)),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            height: 10,
            width: 250,
            decoration: BoxDecoration(
                color: Theme.of(context).textTheme.headlineMedium!.color,
                borderRadius: BorderRadius.circular(30)),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kIsWeb ? 120 : 80);
}
