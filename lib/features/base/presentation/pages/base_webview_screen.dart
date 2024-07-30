import 'package:clean_architechture/config/theme/theme.dart';
import 'package:clean_architechture/core/extensions/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BaseWebViewScreen extends StatelessWidget {
  final String url;
  final String title;
  const BaseWebViewScreen({super.key, required this.url, required this.title});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(title, style: AppTheme.currentTheme.textTheme.titleLarge,),
        leading: _buildButton(Icons.arrow_back_ios).onClick(()=> Navigator.of(context).pop()),
        actions: [
          _buildButton(Icons.share)
        ],
      ),
      body:  WebViewWidget(controller: controller),
    );
  }

  Widget _buildButton(IconData iconData){
    return SizedBox(
      height: 48,
      width: 48,
      child: Icon(iconData, color:  const Color(0xff014494),),
    );
  }
}

