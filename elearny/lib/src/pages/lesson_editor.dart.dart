import 'package:elearny/data/globales.dart';
import 'package:elearny/src/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';

import 'package:flutter_quill/flutter_quill.dart';

import 'package:html_editor_enhanced/html_editor.dart';

class LessonEditor extends StatelessWidget {
  LessonEditor({super.key});

  // String result = '';

  final HtmlEditorController controller = HtmlEditorController();

  final QuillController _controller = QuillController.basic();

  ///late final WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: deviceType != 1
            ? deviceType == 2
                ? appBarWidget(context)
                : appBarWidget(context)
            : Center(
                child: Text(
                'Html Editor',
                style: Theme.of(context).textTheme.bodyLarge,
              )),
      ),
      body: QuillProvider(
        configurations: QuillConfigurations(
          controller: _controller,
          sharedConfigurations: const QuillSharedConfigurations(),
        ),
        child: Column(
          children: [
            QuillToolbarProvider(
              toolbarConfigurations: const QuillToolbarConfigurations(),
              child: QuillBaseToolbar(
                configurations: QuillBaseToolbarConfigurations(
                  toolbarSize: 15 * 2,
                  multiRowsDisplay: true,
                  childrenBuilder: (context) {
                    final controller = context.requireQuillController;
                    return [
                      QuillToolbarHistoryButton(
                        controller: controller,
                        options: const QuillToolbarHistoryButtonOptions(
                            isUndo: true),
                      ),
                      QuillToolbarHistoryButton(
                        controller: controller,
                        options: const QuillToolbarHistoryButtonOptions(
                            isUndo: false),
                      ),
                      QuillToolbarToggleStyleButton(
                        attribute: Attribute.bold,
                        controller: controller,
                        options: const QuillToolbarToggleStyleButtonOptions(
                          iconData: Icons.format_bold,
                          iconSize: 20,
                        ),
                      ),
                      QuillToolbarToggleStyleButton(
                        attribute: Attribute.italic,
                        controller: controller,
                        options: const QuillToolbarToggleStyleButtonOptions(
                          iconData: Icons.format_italic,
                          iconSize: 20,
                        ),
                      ),
                      QuillToolbarToggleStyleButton(
                        attribute: Attribute.underline,
                        controller: controller,
                        options: const QuillToolbarToggleStyleButtonOptions(
                          iconData: Icons.format_underline,
                          iconSize: 20,
                        ),
                      ),
                      QuillToolbarClearFormatButton(
                        controller: controller,
                        options: const QuillToolbarClearFormatButtonOptions(
                          iconData: Icons.format_clear,
                          iconSize: 20,
                        ),
                      ),
                      VerticalDivider(
                        indent: 12,
                        endIndent: 12,
                        color: Colors.grey.shade400,
                      ),
                      QuillToolbarSelectHeaderStyleButtons(
                        controller: controller,
                        options:
                            const QuillToolbarSelectHeaderStyleButtonsOptions(
                          iconSize: 20,
                        ),
                      ),
                      QuillToolbarToggleStyleButton(
                        attribute: Attribute.ol,
                        controller: controller,
                        options: const QuillToolbarToggleStyleButtonOptions(
                          iconData: Icons.format_list_numbered,
                          iconSize: 20,
                        ),
                      ),
                      QuillToolbarToggleStyleButton(
                        attribute: Attribute.ul,
                        controller: controller,
                        options: const QuillToolbarToggleStyleButtonOptions(
                          iconData: Icons.format_list_bulleted,
                          iconSize: 20,
                        ),
                      ),
                      QuillToolbarToggleStyleButton(
                        attribute: Attribute.blockQuote,
                        controller: controller,
                        options: const QuillToolbarToggleStyleButtonOptions(
                          iconData: Icons.format_quote,
                          iconSize: 20,
                        ),
                      ),
                      VerticalDivider(
                        indent: 12,
                        endIndent: 12,
                        color: Colors.grey.shade400,
                      ),
                      QuillToolbarIndentButton(
                          controller: controller,
                          isIncrease: true,
                          options: const QuillToolbarIndentButtonOptions(
                            iconData: Icons.format_indent_increase,
                            iconSize: 20,
                          )),
                      QuillToolbarIndentButton(
                        controller: controller,
                        isIncrease: false,
                        options: const QuillToolbarIndentButtonOptions(
                          iconData: Icons.format_indent_decrease,
                          iconSize: 20,
                        ),
                      ),
                    ];
                  },
                ),
              ),
            ),
            Expanded(
              child: QuillEditor.basic(
                configurations: const QuillEditorConfigurations(
                  readOnly: false,
                  placeholder: 'Write your notes',
                  padding: EdgeInsets.all(16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget appBarWidget(BuildContext context) {
    return AppBarWidget(
      leftIcon: Icons.arrow_back,
      onPressedLeftIcon: () {
        Navigator.pop(context);
      },
      rightIcon: null,
      title: "Html Editor",
      subtitle: "Here you can add and edit your lessons",
    );
  }
}
