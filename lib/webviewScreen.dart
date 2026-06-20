import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewPage extends StatefulWidget {
  final String webString;
  const WebViewPage({super.key,required this.webString,});

  @override
  // State<WebViewPage> createState() => _WebViewPageState();
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  bool isLoading = true;
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/cristal_logo.png',
                height: 45,
                width: 150,
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: (){
                  print('clicked');
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WebViewPage(webString: widget.webString),
                    ),
                  );
                },
                  child: Icon(Icons.refresh))
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(
              // url: WebUri("https://fspfedgedgede.cristaledu.com"),
              url: WebUri(widget.webString),
            ),
            initialSettings: InAppWebViewSettings(
              javaScriptEnabled: true,
              mediaPlaybackRequiresUserGesture: false,
            ),
            onLoadStart: (controller, url) {
              setState(() {
                isLoading = true;
              });
            },
            onLoadStop: (controller, url) {
              setState(() {
                isLoading = false;
              });
            },
            onProgressChanged: (controller, progressValue) {
              setState(() {
                progress = progressValue / 100;
              });
            },
          ),

          // Loader
          if (isLoading)
            Center(
              child: CircularProgressIndicator(
                value: progress == 0 ? null : progress,
              ),
            ),
        ],
      ),
    );
  }
}