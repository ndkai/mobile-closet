import 'package:clean_architechture/core/commons/date_time_utils.dart';
import 'package:clean_architechture/core/extensions/widget_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../../../config/size/size_config.dart';
import '../sheet_title.dart';
import 'package:timezone/timezone.dart' as tz;
class DateTimeRangePickerResponse{
  final DateTime fromDate;
  final DateTime toDate;


  DateTimeRangePickerResponse(this.fromDate, this.toDate);
}

class DateTimeRangePickerBuilder extends StatefulWidget {
  final ValueChanged<DateTimeRangePickerResponse> onChanged;
  final DateTime? minimumDate;
  final DateTime? maximumDate;
  final DateTime? initDate;
  final Widget? instruction;
  final CupertinoDatePickerMode? mode;
  const DateTimeRangePickerBuilder({super.key, required this.onChanged, this.minimumDate, this.instruction, this.mode, this.maximumDate, this.initDate});
  @override
  State<DateTimeRangePickerBuilder> createState() => _DateTimeRangePickerBuilderState();
}

class _DateTimeRangePickerBuilderState extends State<DateTimeRangePickerBuilder> {
  bool fromDateSelected = true;
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          color: Colors.white),
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SheetTitle(name: "Picker date",),
          const Gap(10),
          widget.instruction ?? Container(
            width: 375,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: const BoxDecoration(color: Color(0xFFF3FCFF)),
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.info_outline, color: Color(0xFF007AFF)),
                      SizedBox(width: 10),
                      Text(
                        'Please choose within a 90-day period.',
                        style: TextStyle(
                          color: Color(0xFF007AFF),
                          fontSize: 12,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Gap(20),
          Row(
            children: [
              Expanded(child: Column(children: [
                Text(
                  'From',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: fromDateSelected ? const Color(0xFF3D4966) : Colors.grey,
                    fontSize: 12,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,

                  ),
                ),
                const Gap(4),
                Text(
                  DateTimeUtils.formatTime(fromDate.toIso8601String(), showHour: false, showDay: widget.mode == CupertinoDatePickerMode.date),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: fromDateSelected ? const Color(0xFF007AFF): Colors.grey,
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Divider(thickness: 1, color: fromDateSelected ? Colors.blue : Colors.transparent)
              ],).onClick(() => setState(() {
                fromDateSelected = true;
              }))),
              Expanded(child: Column(children: [
                Text(
                  'To',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: !fromDateSelected ? const Color(0xFF3D4966) : Colors.grey,
                    fontSize: 12,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,

                  ),
                ),
                const Gap(4),
                Text(
                 DateTimeUtils.formatTime(toDate.toIso8601String(), showHour: false, showDay: widget.mode == CupertinoDatePickerMode.date),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: !fromDateSelected ? const Color(0xFF007AFF): Colors.grey,
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Divider(thickness: 1, color: !fromDateSelected ? Colors.blue : Colors.transparent)
              ]).onClick(() => setState(() {
                fromDateSelected = false;
              }))),
            ],
          ),
          SizedBox(
            height: 200,
            child: CupertinoDatePicker(
              mode: widget.mode ?? CupertinoDatePickerMode.date,
              maximumDate: widget.maximumDate,
              minimumDate: widget.minimumDate,
              initialDateTime: widget.initDate,
              onDateTimeChanged: (date){
                setState(() {
                  if(fromDateSelected){
                    fromDate = date;
                  } else {
                    toDate = date;
                  }
                  if(fromDate.difference(toDate).inDays > 0){
                    fromDate = toDate;
                  }
                });
                widget.onChanged(DateTimeRangePickerResponse(fromDate, toDate));
              },
            ),
          ),
          const Gap(40),
        ],
      ),
    );
  }
}


class DateTimePickerBuilder extends StatefulWidget {
  final ValueChanged<DateTime> onChanged;
  final DateTime? initDate;
  final DateTime? minimumDate;
  final CupertinoDatePickerMode? mode;
  final Widget? instruction;
  final DateTime? maximumDate;
  const DateTimePickerBuilder({super.key, required this.onChanged, required this.initDate, this.mode, this.instruction, this.minimumDate, this.maximumDate});
  @override
  State<DateTimePickerBuilder> createState() => _DateTimePickerBuilderState();
}

class _DateTimePickerBuilderState extends State<DateTimePickerBuilder> {
  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    return Container(
      width: SizeConfig.screenWidth,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          color: Colors.white),
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SheetTitle(name: "",),
          const Gap(10),
          widget.instruction ?? const SizedBox(),
          const Gap(10),
          SizedBox(
            height: 200,
            child: CupertinoDatePicker(
              mode: widget.mode ?? CupertinoDatePickerMode.date,
              initialDateTime: widget.initDate  ?? now,
              showDayOfWeek: true,
              maximumDate: widget.maximumDate,
              minimumDate: widget.minimumDate  ?? now.subtract(const Duration(days: 365)),
              onDateTimeChanged: (date){
                widget.onChanged(date);
              },
            ),
          ),
          const Gap(40),
        ],
      ),
    );
  }
}
