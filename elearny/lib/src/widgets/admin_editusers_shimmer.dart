import 'package:elearny/data/globales.dart';
import 'package:elearny/services/firebase/fireStore/adminEditUsers/admin_edit_users.dart';
import 'package:elearny/src/theme/themes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AdminEditUserShimmer extends StatelessWidget {
  AdminEditUserShimmer({super.key});
  final AdminEditUserService adminService = AdminEditUserService();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.2,
      child: Column(
        children: [
          Center(
            child: Table(
                border: const TableBorder(
                  horizontalInside: BorderSide(width: 0.5, color: Themes.grey),
                ),
                columnWidths: deviceType == 1
                    ? {
                        0: FixedColumnWidth(
                            MediaQuery.of(context).size.width / 5.5),
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
                                MediaQuery.of(context).size.width / 1.3),
                          }
                        : {
                            0: FixedColumnWidth(
                                MediaQuery.of(context).size.width),
                          },
                children: [
                  ...getTableRows(context),
                  ...List.generate(12, (index) {
                    return TableRow(children: getTableCells(context));
                  }),
                ]),
          ),
        ],
      ),
    );
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

  List<TableRow> getTableRows(BuildContext context) {
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
      ];
    } else {
      // Display these rows for other devices
      return [
        TableRow(
          children: [
            // tableHeaderRow("user info", false, false),
            // tableHeaderRow("Role", false, false),
            // tableHeaderRow("Options", true, false),
            tableHeaderRow("", false, true),
          ],
        ),
      ];
    }
  }

  List<TableCell> getTableCells(BuildContext context) {
    if (deviceType == 1) {
      return [
        TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ListTile(
                //  isThreeLine: true,
                tileColor: Theme.of(context).scaffoldBackgroundColor,
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).textTheme.headlineMedium!.color,
                  ),
                ),
                title: Container(
                  height: 7.5,
                  color: Theme.of(context).textTheme.headlineMedium!.color,
                ),
                subtitle: Container(
                  height: 7.5,
                  color: Theme.of(context).textTheme.headlineMedium!.color,
                ),
              ),
            )),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Row(
              children: [
                Container(
                  height: 10,
                  width: 80,
                  color: Theme.of(context).textTheme.headlineMedium!.color,
                ),
              ],
            ),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Row(
              children: [
                Container(
                  width: 80,
                  height: 10,
                  color: Theme.of(context).textTheme.headlineMedium!.color,
                ),
              ],
            ),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Container(
              height: 10,
              color: Theme.of(context).textTheme.headlineMedium!.color,
            ),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 10,
                  width: 50,
                  color: Theme.of(context).textTheme.headlineMedium!.color,
                ),
              ],
            ),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).textTheme.headlineMedium!.color,
                ),
              ),
              SizedBox(width: 20),
              Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).textTheme.headlineMedium!.color,
                ),
              ),
              SizedBox(width: 20),
              Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).textTheme.headlineMedium!.color,
                ),
              ),
              SizedBox(width: 20),
            ],
          ),
        )
      ];
    } else {
      return [
        TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Padding(
              padding: const EdgeInsets.only(top: 5.0, bottom: 5),
              child: ListTile(
                // isThreeLine: true,
                tileColor:
                    kIsWeb ? Theme.of(context).scaffoldBackgroundColor : null,
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).textTheme.headlineMedium!.color,
                  ),
                ),
                title: UnconstrainedBox(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    height: 7.5,
                    width: 150,
                    color: Theme.of(context).textTheme.headlineMedium!.color,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    UnconstrainedBox(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        height: 7.5,
                        width: 200,
                        color:
                            Theme.of(context).textTheme.headlineMedium!.color,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    UnconstrainedBox(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        height: 5,
                        width: 100,
                        color:
                            Theme.of(context).textTheme.headlineMedium!.color,
                      ),
                    )
                  ],
                ),
                trailing: Icon(
                  FontAwesomeIcons.ellipsisVertical,
                  color: Theme.of(context).textTheme.headlineMedium!.color,
                ),
              ),
            ))
      ];
    }
  }
}
