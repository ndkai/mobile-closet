import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:clean_architechture/config/theme/theme.dart';
import 'package:clean_architechture/core/extensions/widget_extension.dart';
import 'package:clean_architechture/generated/assets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class BasePDFViewScreen extends StatefulWidget {
  final String title;
  final String url;

  const BasePDFViewScreen({super.key, required this.title, required this.url});

  @override
  State<BasePDFViewScreen> createState() => _BaseWebViewScreenState();
}

class _BaseWebViewScreenState extends State<BasePDFViewScreen> {
  String remotePDFpath = "";

  Future<String> createFileOfPdfUrl() async {
    Completer<String> completer = Completer();
    try {
      final url = widget.url;
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      print("Error parsing asset fil");
      print("${dir.path}/$filename");
      File file = File("${dir.path}/$filename");
      remotePDFpath = "${dir.path}/$filename";
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file.path);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            widget.title,
            style: AppTheme.currentTheme.textTheme.titleLarge,
          ),
          leading: _buildButton(Icons.arrow_back_ios)
              .onClick(() => Navigator.of(context).pop()),
          actions: [_buildShare()],
        ),
        body: FutureBuilder<String>(
          future: createFileOfPdfUrl(),
          builder: (context, snapshot){
            print("ConnectionState ${snapshot.connectionState}");
            if(snapshot.data == null){
              return const Center(
                child: CircularProgressIndicator(color: Colors.blue,),
              );
            }
            return PDFView(
              filePath: snapshot.data,
              enableSwipe: true,
              swipeHorizontal: false,
              autoSpacing: false,
              pageFling: false,
              pageSnap: true,
              defaultPage: 0,
              fitPolicy: FitPolicy.BOTH,
              preventLinkNavigation: false,
              // if set to true the link is handled in flutter
              onRender: (_pages) {
                setState(() {});
              },
              onError: (error) {
                setState(() {});
                print(error.toString());
              },
              onPageError: (page, error) {
                setState(() {});
                print('$page: ${error.toString()}');
              },
              onViewCreated: (PDFViewController pdfViewController) {},
              onLinkHandler: (String? uri) {
                print('goto uri: $uri');
              },
              onPageChanged: (int? page, int? total) {
                print('page change: $page/$total');
                setState(() {});
              },
            );

          },
        ));
  }

  Widget _buildShare() {
    return SizedBox(
      height: 48,
      width: 48,
      child: Image.asset(Assets.iconsShare),
    ).onClick((){
      Share.shareXFiles([XFile(remotePDFpath)], text: '');
    });
  }

  Widget _buildButton(IconData iconData) {
    return SizedBox(
      height: 48,
      width: 48,
      child: Icon(iconData),
    );
  }
}

class BaseContentPDFScreen extends StatefulWidget {
  final String content;
  final String title;
  final String fileName;
  const BaseContentPDFScreen({super.key, required this.content, required this.title, required this.fileName});

  @override
  State<BaseContentPDFScreen> createState() => _BaseContentPDFScreenState();
}

class _BaseContentPDFScreenState extends State<BaseContentPDFScreen> {
  late String _filePath;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            widget.title,
            style: const TextStyle(
              color: Color(0xFF001F7B),
              fontSize: 16,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
            ),
          ),
          leading: _buildButton(Icons.arrow_back_ios)
              .onClick(() => Navigator.of(context).pop()),
          actions: [SizedBox(
            height: 48,
            width: 20,
            child: SvgPicture.asset(Assets.iconsShare,width: 24, height: 24),
          )
              .padding(const EdgeInsets.only(right: 16))
              .onClick(() async {
            await Share.shareXFiles([XFile(_filePath)]);
          })],
        ),
        body: FutureBuilder<String>(
          future: saveBase64AsPdf(),
          builder: (context, snapshot){
            if(snapshot.data == null){
              return const Center(
                child: CircularProgressIndicator(color: Colors.blue,),
              );
            }
            return PDFView(
              filePath: snapshot.data,
              enableSwipe: true,
              swipeHorizontal: false,
              autoSpacing: false,
              pageFling: true,
              pageSnap: true,
              defaultPage: 0,
              fitPolicy: FitPolicy.BOTH,
              preventLinkNavigation: false,
              onRender: (_pages) {
                setState(() {});
              },
              onError: (error) {
                setState(() {});
                print("ádasdasd ${error.toString()}");
              },
              onPageError: (page, error) {
                setState(() {});
                print('$page: ${error.toString()}');
              },
              onViewCreated: (PDFViewController pdfViewController) {},
              onLinkHandler: (String? uri) {
                print('goto uri: $uri');
              },
              onPageChanged: (int? page, int? total) {
                print('page change: $page/$total');
                setState(() {});
              },
            );

          },
        ));
  }
  Widget _buildButton(IconData iconData) {
    return SizedBox(
      height: 48,
      width: 48,
      child: Icon(
        iconData,
        color: const Color(0xff014494),
      ),
    );
  }

  Future<String> saveBase64AsPdf() async {
    Uint8List bytes = base64Decode(widget.content);
    print("hay za ${widget.content}");
    Directory directory = await getApplicationDocumentsDirectory();
    String filePath = '${directory.path}/${widget.fileName}';
    _filePath = filePath;
    File file = File(filePath);
    print('ádassad ád${_filePath}');
    await file.writeAsBytes(bytes);
    return filePath;
  }
}

