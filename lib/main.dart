import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage());
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  void _handleURLButtonPress(BuildContext context, String url, String title) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => WebViewPage(url, title)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("WebView Flutter Example"),
      ),
      body: Center(
          child: Column(
        children: [
          MaterialButton(
            color: Colors.blue,
            child: const Text(
              "Open pub.dev",
              style:
                  TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              _handleURLButtonPress(context, "https://pub.dev", "pub.dev");
            },
          ),
          MaterialButton(
            color: Colors.blue,
            child: const Text(
              "Open publichappinessmovement.com",
              style:
                  TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              _handleURLButtonPress(
                  context, "https://publichappinessmovement.com", "PHM");
            },
          ),
        ],
      )),
    );
  }
}

class WebViewPage extends StatefulWidget {
  final String url;
  final String title;

  const WebViewPage(this.url, this.title, {Key? key}) : super(key: key);

  @override
  WebViewPageState createState() => WebViewPageState(this.url, this.title);
}

class WebViewPageState extends State<WebViewPage> {
  final String url;
  final String title;

  WebViewPageState(this.url, this.title);

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(this.title),
        ),
        body: Column(children: [
          Expanded(
              child: WebView(
                  initialUrl: this.url,
                  javascriptMode: JavascriptMode.unrestricted))
        ]));
  }
}
