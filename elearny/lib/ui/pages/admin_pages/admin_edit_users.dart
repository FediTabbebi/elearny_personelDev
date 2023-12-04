import 'package:cached_network_image/cached_network_image.dart';
import 'package:elearny/core/data/globales.dart';
import 'package:elearny/core/models/user_model.dart';
import 'package:elearny/core/services/firestore/admin/admin_edit_users/admin_edit_users.dart';
import 'package:elearny/core/constants/assets.dart';
import 'package:elearny/ui/theme/themes.dart';
import 'package:elearny/ui/widgets/admin_widget/admin_user_management_shimmer.dart';
import 'package:elearny/ui/widgets/shared_widget/loading_indicator_widget.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class AdminUserManagementScreen extends StatelessWidget {
  AdminUserManagementScreen({super.key});
  final AdminUserManagementService adminService = AdminUserManagementService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<UserModel>>(
        create: (context) => adminService.getUsersStream(),
        initialData: const [],
        child: Scaffold(
          appBar: AppBar(
              leadingWidth: kIsWeb ? 0 : 75,
              leading: kIsWeb ? null : const SizedBox(),
              automaticallyImplyLeading: false,
              toolbarHeight: 100,
              centerTitle: kIsWeb ? true : false,
              title: Column(
                crossAxisAlignment: kIsWeb
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                children: [
                  Text(
                    'Edit users',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Here you can manage and edit all users",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ],
              )),
          body: LayoutBuilder(builder: (context, constraint) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: TextField(
                      decoration: InputDecoration(label: Text("Search")),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Selector<List<UserModel>, Map<String, dynamic>>(
                      selector: (context, users) {
                    // Check if the data is still loading
                    bool isLoading = users.isEmpty;

                    // Convert the list of users to a list of TableRow
                    List<TableRow> userRows =
                        List.generate(users.length, (index) {
                      return TableRow(
                          children: getTableCells(
                              users[index], context, index * 100));
                    });

                    // Return a map with the isLoading and the userRows
                    return {'isLoading': isLoading, 'userRows': userRows};
                  }, builder: (context, data, _) {
                    bool isLoading = data['isLoading'];
                    List<TableRow> userRows = data['userRows'];

                    if (isLoading) {
                      // Data is still loading, display shimmer
                      return AdminUserManagementShimmer();
                    } else {
                      // Data has been loaded, display the table
                      return Center(
                        child: Table(

                            // border: TableBorder.all(color: Colors.black),
                            // border:
                            //     TableBorder.symmetric(inside: BorderSide(width: 0.5)),
                            border: const TableBorder(
                              horizontalInside:
                                  BorderSide(width: 0.5, color: Themes.grey),
                            ),
                            columnWidths: deviceType == 1
                                ? {
                                    0: FixedColumnWidth(
                                        MediaQuery.of(context).size.width /
                                            5.5),
                                    1: FixedColumnWidth(
                                        MediaQuery.of(context).size.width / 10),
                                    2: FixedColumnWidth(
                                        MediaQuery.of(context).size.width / 10),
                                    3: FixedColumnWidth(
                                        MediaQuery.of(context).size.width / 10),
                                    4: FixedColumnWidth(
                                        MediaQuery.of(context).size.width / 10),
                                    5: FixedColumnWidth(
                                        MediaQuery.of(context).size.width / 8),
                                  }
                                : kIsWeb
                                    ? {
                                        0: FixedColumnWidth(
                                            MediaQuery.of(context).size.width /
                                                1.3),
                                        // 1: FixedColumnWidth(
                                        //     MediaQuery.of(context).size.width /
                                        //         6),
                                        // 2: FixedColumnWidth(
                                        //     MediaQuery.of(context).size.width /
                                        //         6),
                                      }
                                    : {
                                        0: FixedColumnWidth(
                                            MediaQuery.of(context).size.width),
                                        // 1: FixedColumnWidth(
                                        //     MediaQuery.of(context).size.width /
                                        //         4),
                                        // 2: FixedColumnWidth(
                                        //     MediaQuery.of(context).size.width /
                                        //         6),
                                      },
                            children: getTableRows(userRows)
                            // Use the userRows directly

                            ),
                      );
                    }
                  }),
                ],
              ),
            );
          }),
        ));
  }

  Widget tableHeaderRow(String title, bool end, bool middle) {
    return TableCell(
        child: Text(title,
            style: const TextStyle(color: Themes.grey),
            textAlign: middle
                ? TextAlign.center
                : end
                    ? TextAlign.end
                    : TextAlign.start));
  }

  List<TableRow> getTableRows(List<TableRow> userRows) {
    if (deviceType == 1) {
      // Display these rows for web
      return [
        TableRow(
          children: [
            tableHeaderRow("User", false, false),
            tableHeaderRow("Member Since", false, false),
            tableHeaderRow("Phone", false, false),
            tableHeaderRow("Role", false, false),
            tableHeaderRow("Status", true, false),
            tableHeaderRow("Options", true, deviceType != 1 ? true : false),
          ],
        ),
        ...userRows,
      ];
    } else {
      // Display these rows for other devices
      return [
        TableRow(
          children: [
            tableHeaderRow("", true, false),
          ],
        ),
        ...userRows,
      ];
    }
  }

  List<TableCell> getTableCells(
      UserModel user, BuildContext context, int delayDuration) {
    if (deviceType == 1) {
      return [
        TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: ListTile(
              tileColor: Theme.of(context).scaffoldBackgroundColor,
              contentPadding: EdgeInsets.zero,
              leading: user.profilePicture.isEmpty
                  ? Image.asset(Assets.profilePlaceHolder)
                  : CachedNetworkImage(
                      imageUrl: user.profilePicture,
                      placeholder: (context, url) => const SizedBox(
                          width: 20,
                          height: 20,
                          child: LoadingIndicatorWidget(
                              color: Themes.green, size: 15)),
                      imageBuilder: (context, imageProvider) => Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
              title: Tooltip(
                showDuration: const Duration(milliseconds: 0),
                message: "${user.firstName}" " ${user.lastName}",
                child: Text(
                  "${user.firstName}"
                  " ${user.lastName}",
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  // textAlign: TextAlign.start,
                ),
              ),
              subtitle: Tooltip(
                showDuration: const Duration(milliseconds: 0),
                message: user.email,
                child: Text(
                  user.email,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12, color: Themes.grey),
                ),
              ),
            ).animate().flip(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                delay: Duration(milliseconds: delayDuration))),
        TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Text(
              "${user.createdAt.toLocal()}".split(' ')[0],
              softWrap: true,
              overflow: TextOverflow.ellipsis,
            ).animate().flip(
                duration: const Duration(milliseconds: 250),
                delay: Duration(milliseconds: delayDuration))),
        TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Text(
              user.phoneNumber.isNotEmpty ? user.phoneNumber : "UNKNOWN",
              softWrap: true,
              overflow: TextOverflow.ellipsis,
            ).animate().flip(
                duration: const Duration(milliseconds: 250),
                delay: Duration(milliseconds: delayDuration))),
        TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: PopupMenuButton<String>(
              tooltip: "Edit user role",
              onSelected: (value) {
                // Handle the selected value.
                //   print('Selected value: $value');
              },
              itemBuilder: (context) => [
                const PopupMenuItem<String>(
                  value: 'admin',
                  child: Text('Admin'),
                ),
                const PopupMenuItem<String>(
                  value: 'contentCreator',
                  child: Text('Content Creator'),
                ),
                const PopupMenuItem<String>(
                  value: 'client',
                  child: Text('Client'),
                ),
              ],
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      user.role,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ), // Display the selected value
                  ),
                  const Icon(Icons.arrow_drop_down), // Add dropdown icon
                ],
              ),
            ).animate().flip(
                duration: const Duration(milliseconds: 350),
                delay: Duration(milliseconds: delayDuration))),
        TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Text(
              user.isDeleted ? " Deleted" : "Active",
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
              style: TextStyle(
                color: user.isDeleted ? Colors.red : Themes.green,
              ),
            ).animate().flip(
                duration: const Duration(milliseconds: 350),
                delay: Duration(milliseconds: delayDuration))),
        TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Tooltip(
                  message: "Preview",
                  showDuration: const Duration(milliseconds: 0),
                  child: IconButton(
                    splashRadius: 15,
                    icon: const Icon(FontAwesomeIcons.solidEye,
                        size: 15, color: Color(0xffE3AB0D)),
                    onPressed: () {
                      // Handle edit button click
                      // You can navigate to an edit screen or show a dialog
                    },
                  ),
                ).animate().flip(
                    duration: const Duration(milliseconds: 350),
                    delay: Duration(milliseconds: delayDuration)),
                Tooltip(
                  showDuration: const Duration(milliseconds: 0),
                  message: "Edit",
                  child: IconButton(
                    splashRadius: 15,
                    icon: const Icon(
                      FontAwesomeIcons.pen,
                      size: 15,
                    ),
                    onPressed: () {
                      // Handle display button click
                      // You can navigate to a details screen or show a dialog
                    },
                  ),
                ).animate().flip(
                    duration: const Duration(milliseconds: 350),
                    delay: Duration(milliseconds: delayDuration)),
                Tooltip(
                  showDuration: const Duration(milliseconds: 0),
                  message: user.isDeleted ? "Restore" : "Delete",
                  child: IconButton(
                    splashRadius: 15,
                    icon: Icon(
                      user.isDeleted
                          ? FontAwesomeIcons.trashCanArrowUp
                          : FontAwesomeIcons.trash,
                      color:
                          user.isDeleted ? const Color(0xff0A2342) : Colors.red,
                      size: 15,
                    ),
                    onPressed: () {
                      // Handle remove button click
                      // You can show a confirmation dialog and delete the user
                    },
                  ),
                ).animate().flip(
                    duration: const Duration(milliseconds: 350),
                    delay: Duration(milliseconds: delayDuration)),
              ],
            ))
      ];
    } else {
      return [
        TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5),
                child: ListTile(
                  //  isThreeLine: true,
                  tileColor: Theme.of(context).scaffoldBackgroundColor,
                  leading: user.profilePicture.isEmpty
                      ? Image.asset(
                          Assets.noImagePlaceHolder,
                          width: 40,
                          height: 40,
                        )
                      : CachedNetworkImage(
                          imageUrl: user.profilePicture,
                          placeholder: (context, url) => Container(
                            width: 20,
                            height: 20,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: const LoadingIndicatorWidget(
                                color: Themes.green, size: 15),
                          ),
                          imageBuilder: (context, imageProvider) => Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                  title: Text(
                    "${user.firstName}"
                    " ${user.lastName}",
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    // textAlign: TextAlign.start,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.email,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style:
                            const TextStyle(fontSize: 12, color: Themes.grey),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Member since ${"${user.createdAt.toLocal()}".split(' ')[0]}",
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Color(0xffE3AB0D), fontSize: 10),
                      ),
                    ],
                  ),

                  trailing: Wrap(
                    spacing: 15,
                    children: [
                      Text(
                        user.isDeleted ? " Deleted" : "Active",
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            color: user.isDeleted ? Colors.red : Themes.green,
                            fontSize: 14),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      PopupMenuButton<String>(
                          tooltip: "Options",
                          onSelected: (value) {
                            // Handle the selected value.
                            //   print('Selected value: $value');
                          },
                          itemBuilder: (context) => [
                                const PopupMenuItem<String>(
                                  value: 'Edit',
                                  child: Text('Edit'),
                                ),
                                const PopupMenuItem<String>(
                                  value: 'Preview',
                                  child: Text('Preview'),
                                ),
                                const PopupMenuItem<String>(
                                  value: 'Delete',
                                  child: Text('Delete'),
                                ),
                              ],
                          child: const Icon(
                            FontAwesomeIcons.ellipsisVertical,
                            color: Themes.grey,
                            size: 20,
                          )),
                    ],
                  ),
                ).animate().slideX(
                    duration: const Duration(milliseconds: 550),
                    begin: -1,
                    end: 0,
                    curve: Curves.easeInOut,
                    delay: Duration(milliseconds: delayDuration))))
      ];
    }
  }
}
