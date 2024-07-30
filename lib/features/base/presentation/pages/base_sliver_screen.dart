
import 'package:clean_architechture/core/extensions/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../config/size/size_config.dart';

class BaseSliverPage extends StatefulWidget {
  final Widget title;
  final Widget? child;
  final double? offSet;
  final Widget? leading;
  final double? leadingWidth;
  final List<Widget>? actions;
  final Widget? itemList;
  final int? itemCount;
  final ScrollController? scrollController;
  final PreferredSizeWidget? bottom;
  final SystemUiOverlayStyle? systemOverlayStyle;
  final SliverList? sliverList;
  final TextStyle? titleTextStyle;
  final Function(bool)? onHandleResult;
  final Function? customBack;
  const BaseSliverPage(
      {super.key,
      required this.title,
      this.child,
      this.leading,
      this.itemList,
      this.itemCount,
      this.bottom,
      this.systemOverlayStyle,
      this.sliverList,
      this.titleTextStyle,
      this.leadingWidth,
      this.actions,
      this.onHandleResult,
      this.offSet,
      this.scrollController, this.customBack});

  @override
  State<BaseSliverPage> createState() => _BaseSliverPageState();
}

class _BaseSliverPageState extends State<BaseSliverPage> {
  late ScrollController _scrollController;
  double leftPadding = 16;
  double previousOffset = 0;
  bool showTitle = false;
  _scrollListener() {
    setState(() {
      showTitle = _scrollController.offset >= 50;
      if (widget.onHandleResult != null) {
        widget.onHandleResult!(showTitle);
      }
    });
    if (_scrollController.offset > previousOffset) {
      //scroll up
      if (_scrollController.offset <= 50) {
        setState(() {
          leftPadding =
              (SizeConfig.screenWidth! * 0.3) * (_scrollController.offset / 50);
        });
        if (leftPadding > SizeConfig.screenWidth! / 2) {
          leftPadding = SizeConfig.screenWidth! / 2;
        }
      }
    }
    if (_scrollController.offset < previousOffset) {
      // scroll down
      if (_scrollController.offset < 0) {
        setState(() {
          leftPadding = 16;
        });
        return;
      }
      setState(() {
        leftPadding =
            (SizeConfig.screenWidth! * 0.3) * (_scrollController.offset / 50);
        if (leftPadding <= 16) {
          leftPadding = 16;
        }
      });
    }
    previousOffset = _scrollController.offset;
  }

  double get scrollOffset {
    return _scrollController.offset;
  }

  double? leadingWidth;
  @override
  void initState() {
    _scrollController = widget.scrollController ?? ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
    if (widget.leading != null) {
      if (widget.leadingWidth != null) {
        leadingWidth = widget.leadingWidth;
      } else {
        leadingWidth = SizeConfig.screenWidth! * 0.2;
      }
    } else {
      leadingWidth = null;
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
      child: CustomScrollView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            backgroundColor: Colors.white,
            centerTitle: true,
            elevation: 0,
            title: showTitle ? widget.title : const SizedBox(),
            titleTextStyle: !showTitle ? widget.titleTextStyle : null,
            leading: widget.leading ??
                const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Color(0xff014494),
                ).onClick((){
                  if(widget.customBack == null){
                    Navigator.of(context).pop();
                  } else {
                    widget.customBack!();
                  }
                }),
            expandedHeight: 100.0,
            bottom: showTitle ? widget.bottom : null,
            systemOverlayStyle: widget.systemOverlayStyle,
            leadingWidth: leadingWidth,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: Colors.white,
              ),
              titlePadding: EdgeInsets.only(left: leftPadding),
              title: !showTitle ? widget.title : const SizedBox(),
            ),
            actions: widget.actions,
            shadowColor: Colors.white,
            surfaceTintColor: Colors.white,
          ),
          if (widget.child != null)
            SliverToBoxAdapter(
              child: widget.child,
            ),
          //if you want make list view in sliver
          if (widget.itemList != null && widget.itemCount != null)
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return widget.itemList!;
                },
                childCount: widget.itemCount ?? 0,
              ),
            ),
          // if you want to make column in sliver like singlechildscrollview
          if (widget.sliverList != null) widget.sliverList!,
        ],
      ).noIndicatorListView(),
    );
  }
}
