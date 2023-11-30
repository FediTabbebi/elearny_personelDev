import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final String subtitle;
  final Widget? leading;
  final List<Widget>? actions;

  const CustomAppBarWidget({
    super.key,
    required this.title,
    required this.subtitle,
    this.leading,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: kIsWeb
          ? leading != null
              ? 60
              : 0
          : 75,
      leading: kIsWeb ? leading : const SizedBox(),
      automaticallyImplyLeading: false,
      centerTitle: kIsWeb ? true : false,
      toolbarHeight: 150,
      title: Column(
        crossAxisAlignment:
            kIsWeb ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ],
      ),
      actions: actions != null ? [if (actions!.isNotEmpty) ...actions!] : [],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kIsWeb ? 120 : 80);
}
