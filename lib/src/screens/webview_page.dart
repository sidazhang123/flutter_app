import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebviewPage extends StatelessWidget {
  final String url;

  WebviewPage(this.url);

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: url,
      appBar: new AppBar(
        title: const Text('Widget Webview'),
      ),
      withZoom: true,
      withLocalStorage: true,
    );
  }
}
