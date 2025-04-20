import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class BackupResultView extends StatefulWidget {
  final String htmlString;
  const BackupResultView({super.key, required this.htmlString});

  @override
  State<BackupResultView> createState() => _BackupResultViewState();
}

class _BackupResultViewState extends State<BackupResultView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nu Result - CGPA App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            HtmlWidget(widget.htmlString),
            //Dev message;
            Text(
              "This is a backup view of the result page. If the main page is not working, you can view the result here.",
              style: TextStyle(
                color: Colors.red,
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
    );
  }
}
