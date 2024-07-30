import 'package:flutter/material.dart';

class AppScaffold extends StatefulWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Color? backgroundColor;
  const AppScaffold(
      {super.key, required this.body, this.appBar, this.bottomNavigationBar, this.backgroundColor});

  @override
  _AppScaffoldState createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      // onHorizontalDragEnd: (details) {
      //   if (details.primaryVelocity != null) {
      //     // Detect swipe left gesture
      //     if (details.primaryVelocity! < 0) {
      //       Navigator.of(context).pop();
      //     }
      //     // Detect swipe right gesture
      //     else if (details.primaryVelocity! > 0) {
      //       Navigator.of(context).pop();
      //     }
      //   }
      // },
      child: Scaffold(
        backgroundColor: widget.backgroundColor ?? const Color(0xffF2F2F2),
        appBar: widget.appBar,
        body: widget.body,
        bottomNavigationBar: widget.bottomNavigationBar,
      ),
    );
  }
}
