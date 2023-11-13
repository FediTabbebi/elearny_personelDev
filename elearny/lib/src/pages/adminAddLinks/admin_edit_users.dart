import 'package:cached_network_image/cached_network_image.dart';
import 'package:elearny/model/user.dart';
import 'package:elearny/provider/widgetProviders/dropdownvalue_provider.dart';
import 'package:elearny/services/firebase/fireStore/adminEditUsers/admin_edit_users.dart';
import 'package:elearny/src/theme/themes.dart';
import 'package:elearny/utils/app_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class AdminEditUserScreen extends StatelessWidget {
  AdminEditUserScreen({super.key});
  final AdminEditUserService adminService = AdminEditUserService();
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<UserModel>>(
        create: (context) => adminService.getUsersStream(),
        initialData: const [], // Provide initial data if needed
        // Provide initial data if needed
        child: Scaffold(
          appBar: AppBar(
              toolbarHeight: 100,
              title: kIsWeb
                  ? Center(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Edit users',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          "Here you can manage and edit all users",
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ],
                    ))
                  : AppBarUtils.appBarWidget(context, "Edit users",
                      "Here you can manage and edit all users")),
          body: // Display the table
              Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                // Use constraints to dynamically set the width
                double dropdownWidth = constraints.maxWidth;
                print(dropdownWidth);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const TextField(
                      decoration: InputDecoration(label: Text("Search")),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Selector<List<UserModel>, List<TableRow>>(
                        selector: (context, users) {
                      // Convert the list of users to a list of TableRow
                      return users.map((user) {
                        return TableRow(
                          children: [
                            TableCell(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 14, bottom: 8),
                                child: Wrap(
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Themes.shimmerColorWhite),
                                      child: CachedNetworkImage(
                                          imageUrl:
                                              "assets/images/manPlaceHolder.png"),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      "${user.firstName}" " ${user.lastName}",
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 14, bottom: 8),
                                child: Text(
                                  user.email,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 14, bottom: 8),
                                child: Text(
                                  user.phoneNumber.isNotEmpty
                                      ? user.phoneNumber
                                      : "UNKNOWN",
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 14, bottom: 8),
                                child: PopupMenuButton<String>(
                                  itemBuilder: (BuildContext context) {
                                    return [
                                      const PopupMenuItem<String>(
                                        value: 'Option 1',
                                        child: Text('Option 1'),
                                      ),
                                      const PopupMenuItem<String>(
                                        value: 'Option 2',
                                        child: Text('Option 2'),
                                      ),
                                    ];
                                  },
                                  onSelected: (value) {
                                    // Handle item selection
                                    // You can use value to determine which option was selected
                                  },
                                  child: const Row(
                                    children: [
                                      Text('Selected'),
                                      Icon(Icons
                                          .arrow_drop_down), // Add dropdown icon
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 14, bottom: 8),
                                child: Text(
                                  user.isDeleted ? " Deleted" : "Active",
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      color: user.isDeleted
                                          ? Colors.red
                                          : Themes.green),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 14, bottom: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Tooltip(
                                      message: "Preview",
                                      child: IconButton(
                                        splashRadius: 15,
                                        icon: const Icon(
                                            FontAwesomeIcons.solidEye,
                                            size: 15,
                                            color: Color(0xffE3AB0D)),
                                        onPressed: () {
                                          // Handle edit button click
                                          // You can navigate to an edit screen or show a dialog
                                        },
                                      ),
                                    ),
                                    Tooltip(
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
                                    ),
                                    Tooltip(
                                      message:
                                          user.isDeleted ? "Restore" : "Delete",
                                      child: IconButton(
                                        splashRadius: 15,
                                        icon: Icon(
                                          user.isDeleted
                                              ? FontAwesomeIcons.trashCanArrowUp
                                              : FontAwesomeIcons.trash,
                                          color: Colors.red,
                                          size: 15,
                                        ),
                                        onPressed: () {
                                          // Handle remove button click
                                          // You can show a confirmation dialog and delete the user
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList();
                    }, builder: (context, userRows, _) {
                      return Center(
                        child: Table(
                          // border:
                          //     TableBorder.symmetric(inside: BorderSide(width: 0.5)),
                          border: const TableBorder(
                            horizontalInside:
                                BorderSide(width: 0.5, color: Themes.grey),
                          ),
                          columnWidths: const {
                            0: FixedColumnWidth(200),
                            1: FixedColumnWidth(200),
                            2: FixedColumnWidth(200),
                            3: FixedColumnWidth(107),
                            4: FixedColumnWidth(200),
                            5: FixedColumnWidth(200),
                          },
                          children: [
                            TableRow(
                              children: [
                                tableHeaderRow("Name", false),
                                tableHeaderRow("Email Address", false),
                                tableHeaderRow("Phone Number", false),
                                tableHeaderRow("Role", false),
                                tableHeaderRow("isDeleted", true),
                                tableHeaderRow("Options", true),
                              ],
                            ),
                            // Use the userRows directly
                            ...userRows,
                          ],
                        ),
                      );
                    }),
                  ],
                );
              }),
            ),
          ),
        ));
  }

  Widget tableHeaderRow(String title, bool end) {
    return Padding(
      padding: const EdgeInsets.only(top: 14, bottom: 8, right: 14),
      child: TableCell(
        child: Text(title,
            style: const TextStyle(color: Themes.grey),
            textAlign: end ? TextAlign.end : TextAlign.start),
      ),
    );
  }

  Widget tableContentRows(String title, bool end) {
    return Padding(
      padding: const EdgeInsets.only(top: 14, bottom: 8, right: 14),
      child: TableCell(
        child: Text(title,
            style: const TextStyle(color: Themes.grey),
            textAlign: end ? TextAlign.end : TextAlign.start),
      ),
    );
  }
}
