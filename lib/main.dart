import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_launch/flutter_launch.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: ThirdScreen(),
    );
  }
}
class ThirdScreen extends StatefulWidget {
  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}
WebViewController controllerGlobal;

Future<bool> _exitApp(BuildContext context) async { // ignore: missing_return
  if (await controllerGlobal.canGoBack()) {
    print("onwill goback");
    controllerGlobal.goBack();
  } else {
    Scaffold.of(context).showSnackBar(
      const SnackBar(content: Text("No back history item")),
    );
    return Future.value(false);
  }
}

class _ThirdScreenState extends State<ThirdScreen> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: () => _exitApp(context),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Efreshly App'),
          // This drop down menu demonstrates that Flutter widgets can be shown over the web view.
        ), body: WebView(
        initialUrl: "http://app.efreshlynow.com",
        javascriptMode: JavascriptMode.unrestricted,
        // ignore: non_constant_identifier_names
        onWebViewCreated: (WebViewController Controller) async {
          _controller.complete(Controller);
        },
      ),
        floatingActionButton: FutureBuilder<WebViewController>(
            future: _controller.future,
            // ignore: non_constant_identifier_names
            builder: (BuildContext Context, AsyncSnapshot<WebViewController>
            // ignore: non_constant_identifier_names
            Controller) {
              if (Controller.hasData) {
                return FloatingActionButton(
                  onPressed: () async{
                    var url = await Controller.data.currentUrl();
                    Share.share ('$url');
                  },
                  child: const Icon(Icons.share),
                );
              }
              return Container();
            }
        ),

        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                alignment: Alignment.center,
                iconSize: 62,
                icon: Image.asset('images/whats.png'),
                onPressed: () {
                  FlutterLaunch.launchWathsApp(
                      phone: "201003000890", message: "Hello");
                },
              ),
              IconButton(
                iconSize: 48,
                icon: Image.asset('images/facebook.png'),
                alignment: Alignment.center,
                onPressed: () async {
                  //await FlutterLaunch.hasApp(name: 'http://fb.com/Efreshlynow-115253199876088/');
                  launch('http://fb.com/Efreshlynow-115253199876088/');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void whatsAppOpen() async {
    await FlutterLaunch.launchWathsApp(phone: "201000864620", message: "Hello");
  }
}


/*
  void  _launchURL() async {
      const url = 'https://flutter.dev';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  whatsAppOpen();
   Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ThirdScreen()),
          );
  class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: 'http://197.51.93.125/efreshly/mobile/',
      appBar: new AppBar(
        title: new Text("Efreshly App"),
      ),

    );
  }
}*/
/*class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TURBO SOLUTION'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('TURBO SOLUTION'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ThirdScreen()),
            );
          },
        ),
      ),
    );
  }
}*/
/*
floatingActionButton: FutureBuilder<WebViewController>(
          future: _controller.future,
          // ignore: non_constant_identifier_names
          builder: (BuildContext Context, AsyncSnapshot<WebViewController>
        // ignore: non_constant_identifier_names
          Controller) {
            if (Controller.hasData) {
              return FloatingActionButton(
                onPressed: () async{
                  var url = await Controller.data.currentUrl();
                  Share.share ('$url');
                },
                child: constflut Icon(Icons.share),
              );
            }
            return Container();
          }
      ),*/