import 'package:cached_network_image/cached_network_image.dart';
import 'package:elearny/data/globales.dart';
import 'package:elearny/model/user.dart';
import 'package:elearny/services/firebase/fireStore/adminEditUsers/admin_edit_users.dart';
import 'package:elearny/src/theme/themes.dart';
import 'package:elearny/src/widgets/loading_indicator_widget.dart';
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
        initialData: const [],
        //  updateShouldNotify: (previous, next) => false,
        // Provide initial data if needed
        // Provide initial data if needed
        child: Scaffold(
          appBar: AppBar(
              automaticallyImplyLeading: false,
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
              LayoutBuilder(builder: (context, constraint) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                //crossAxisAlignment: CrossAxisAlignment.center,
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
                      return TableRow(children: getTableCells(user, context));
                    }).toList();
                  }, builder: (context, userRows, _) {
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
                                      MediaQuery.of(context).size.width / 8),
                                  1: FixedColumnWidth(
                                      MediaQuery.of(context).size.width / 6.5),
                                  2: FixedColumnWidth(
                                      MediaQuery.of(context).size.width / 6.5),
                                  3: FixedColumnWidth(
                                      MediaQuery.of(context).size.width / 12),
                                  4: FixedColumnWidth(
                                      MediaQuery.of(context).size.width / 13.5),
                                  5: FixedColumnWidth(
                                      MediaQuery.of(context).size.width / 7.5),
                                }
                              : kIsWeb
                                  ? {
                                      0: FixedColumnWidth(
                                          MediaQuery.of(context).size.width /
                                              2.3),
                                      1: FixedColumnWidth(
                                          MediaQuery.of(context).size.width /
                                              6),
                                      2: FixedColumnWidth(
                                          MediaQuery.of(context).size.width /
                                              6),
                                    }
                                  : {
                                      0: FixedColumnWidth(
                                          MediaQuery.of(context).size.width /
                                              2),
                                      1: FixedColumnWidth(
                                          MediaQuery.of(context).size.width /
                                              4),
                                      2: FixedColumnWidth(
                                          MediaQuery.of(context).size.width /
                                              6),
                                    },
                          children: getTableRows(userRows)
                          // Use the userRows directly

                          ),
                    );
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
            tableHeaderRow("Name", false, false),
            tableHeaderRow("Email Address", false, false),
            tableHeaderRow("Phone Number", false, false),
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
            tableHeaderRow("user info", false, false),
            tableHeaderRow("Role", false, false),
            tableHeaderRow("Options", true, false),
          ],
        ),
        ...userRows,
      ];
    }
  }

  List<TableCell> getTableCells(UserModel user, BuildContext context) {
    if (deviceType == 1) {
      return [
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Wrap(
            alignment: WrapAlignment.center,
            children: [
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Themes.shimmerColorWhite),
                child: user.profilePicture.isEmpty
                    ? Image.asset("assets/images/manPlaceHolder.png")
                    : CachedNetworkImage(
                        imageUrl: user.profilePicture,
                        placeholder: (context, url) =>
                            const LoadingIndicatorWidget(
                                color: Themes.green, size: 15),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                //  CachedNetworkImage(
                //     imageUrl:),
              ),
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                width: 120,
                child: Tooltip(
                  showDuration: const Duration(milliseconds: 0),
                  message: "${user.firstName}" " ${user.lastName}",
                  child: Center(
                    child: Text(
                      "${user.firstName}" " ${user.lastName}",
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Tooltip(
            showDuration: const Duration(milliseconds: 0),
            message: user.email,
            child: Text(
              user.email,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Text(
            user.phoneNumber.isNotEmpty ? user.phoneNumber : "UNKNOWN",
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
        ),
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
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Text(
            user.isDeleted ? " Deleted" : "Active",
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.end,
            style: TextStyle(color: user.isDeleted ? Colors.red : Themes.green),
          ),
        ),
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
              ),
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
              ),
              Tooltip(
                showDuration: const Duration(milliseconds: 0),
                message: user.isDeleted ? "Restore" : "Delete",
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
        )
      ];
    } else {
      return [
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Row(
            children: [
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Themes.shimmerColorWhite),
                child: user.profilePicture.isEmpty
                    ? Image.asset("assets/images/manPlaceHolder.png")
                    : CachedNetworkImage(
                        imageUrl: user.profilePicture,
                        placeholder: (context, url) =>
                            const LoadingIndicatorWidget(
                                color: Themes.green, size: 15),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${user.firstName}" " ${user.lastName}",
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3.3,
                    child: Text(
                      user.email,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  user.phoneNumber.isEmpty
                      ? const Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.circleXmark,
                              color: Colors.grey,
                              size: 15,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "No Phone Number",
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        )
                      : Text(
                          user.phoneNumber,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                        ),
                  const SizedBox(height: 10),
                  Text(
                    user.isDeleted ? " Deleted" : "Active",
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                    style: TextStyle(
                        color: user.isDeleted ? Colors.red : Themes.green),
                  ),
                ],
              )
            ],
          ),
        ),
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
          ),
        ),
        TableCell(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Tooltip(
                message: "Preview",
                child: IconButton(
                  splashRadius: 15,
                  icon: const Icon(FontAwesomeIcons.solidEye,
                      size: 15, color: Color(0xffE3AB0D)),
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
                message: user.isDeleted ? "Restore" : "Delete",
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
      ];
    }
  }
}
