import 'package:flutter/material.dart';

import '../models/scroll_behavior.dart';

extension WidgetExtension on Widget{
  Widget onClick(Function function) => InkWell(
    onTap: (){
      function();
    },
    child: this,
  );

  Widget align(Alignment alignment) => Align(
    alignment: alignment,
    child: this,
  );

  Widget padding(EdgeInsets edgeInsets) => Padding(
    padding: edgeInsets,
    child: this,
  );

  Widget expanded() => Expanded(
    child: this
  );

  Widget radiusBackground({Color color = Colors.white}) => Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      decoration: BoxDecoration(
        color:color,
        borderRadius: BorderRadius.circular(12)
      ),
      child: this
  );
  ScrollConfiguration noIndicatorListView(){
    return ScrollConfiguration(
      behavior: NoScrollIndicatorBehavior(),
      child: this,
    );
  }


}

