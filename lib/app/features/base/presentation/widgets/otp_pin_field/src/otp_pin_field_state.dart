import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../otp_pin_field.dart';
import '../otp_pin_field_platform_interface.dart';
import 'gradient_outline_input_border.dart';

class OtpPinFieldState extends State<OtpPinField>
    with TickerProviderStateMixin, OtpPinAutoFill {
  late FocusNode _focusNode;
  late List<String> pinsInputed;
  late AnimationController _cursorController;
  late Animation<double> _cursorAnimation;
  final TextEditingController controller = TextEditingController();
  bool ending = false;
  bool hasFocus = false;
  String text = '';

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    pinsInputed = [];
    if (widget.autoFillEnable == true) {
      if (widget.phoneNumbersHint == true) {
        _OtpPinFieldAutoFill().hint;
      }
      _OtpPinFieldAutoFill().getAppSignature.then((value) {
        debugPrint('your hash value is $value');
        _OtpPinFieldAutoFill()
            .listenForCode(smsCodeRegexPattern: widget.smsRegex ?? '\\d{0,4}');
      });
      listenForCode();
    }
    for (var i = 0; i < widget.maxLength; i++) {
      pinsInputed.add('');
    }

    _focusNode.addListener(_focusListener);
    _cursorController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _cursorAnimation = Tween<double>(
      begin: 1,
      end: 0,
    ).animate(CurvedAnimation(
      parent: _cursorController,
      curve: Curves.easeIn,
    ));
    _cursorController.repeat();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    if (widget.autoFillEnable == true) {
      cancel();
      _OtpPinFieldAutoFill().unregisterListener();
    }
    _focusNode.removeListener(_focusListener);
    _focusNode.dispose();
    controller.dispose();
    _cursorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.showCustomKeyboard ?? false
        ? _viewWithCustomKeyBoard()
        : _viewWithOutCustomKeyBoard();
  }

  Widget _viewWithCustomKeyBoard() {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 115,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          widget.upperChild ?? Container(height: 150),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onLongPress: pasteCode,
            onTap: onFieldFocus,
            child: SizedBox(
              height: widget.fieldHeight,
              child: Stack(children: [
                Row(
                    mainAxisAlignment:
                        widget.mainAxisAlignment ?? MainAxisAlignment.center,
                    children: _buildBody(context)),
                AbsorbPointer(
                  child: Opacity(
                    opacity: 0.0,
                    child: TextField(
                      controller: controller,
                      maxLength: widget.maxLength,
                      autofillHints: const [AutofillHints.oneTimeCode],
                      readOnly: widget.showCustomKeyboard ?? true,
                      autofocus: !kIsWeb ? widget.autoFocus : false,
                      enableInteractiveSelection: false,
                      inputFormatters:
                          widget.keyboardType == TextInputType.number
                              ? <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ]
                              : null,
                      focusNode: _focusNode,
                      keyboardType: widget.keyboardType,
                      onSubmitted: (text) {
                        debugPrint(text);
                      },
                      onChanged: (text) {
                        this.text = text;
                        if (ending && text.length == widget.maxLength) {
                          return;
                        }
                        _bindTextIntoWidget(text);
                        setState(() {});
                        widget.onChange(text);
                        ending = text.length == widget.maxLength;
                        if (ending) {
                          widget.onSubmit(text);
                          FocusScope.of(context).unfocus();
                        }
                      },
                    ),
                  ),
                )
              ]),
            ),
          ),
          Expanded(child: widget.middleChild ?? const SizedBox.shrink()),
          Align(
              alignment: Alignment.bottomCenter,
              child: widget.customKeyboard ??
                  OtpKeyboard(
                    callbackValue: (myText) {
                      if (ending && text.length == widget.maxLength) {
                        return;
                      }
                      controller.text = controller.text + myText;
                      text = controller.text;
                      _bindTextIntoWidget(text);
                      setState(() {});
                      widget.onChange(text);
                      ending = text.length == widget.maxLength;
                      if (ending) {
                        FocusScope.of(context).unfocus();
                      }
                    },
                    callbackDeleteValue: () {
                      if (controller.text.isEmpty) {
                        return;
                      }
                      _focusNode.requestFocus();
                      controller.text = controller.text
                          .substring(0, controller.text.length - 1);
                      text = controller.text;
                      _bindTextIntoWidget(text);
                      setState(() {});
                      widget.onChange(text);
                    },
                    callbackSubmitValue: () {
                      if (controller.text.length != widget.maxLength) {
                        return;
                      }
                      widget.onSubmit(controller.text);
                    },
                  ))
        ],
      ),
    );
  }

  Widget _viewWithOutCustomKeyBoard() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onLongPress: pasteCode,
      onTap: onFieldFocus,
      child: SizedBox(
        height: widget.fieldHeight,
        child: Stack(children: [
          Row(
              mainAxisAlignment:
                  widget.mainAxisAlignment ?? MainAxisAlignment.center,
              children: _buildBody(context)),
          AbsorbPointer(
            absorbing: true,
            child: Opacity(
              opacity: 0.0,
              child: TextField(
                controller: controller,
                maxLength: widget.maxLength,
                readOnly: !(widget.showDefaultKeyboard ?? true),
                autofocus: !kIsWeb ? widget.autoFocus : false,
                enableInteractiveSelection: false,
                inputFormatters: widget.keyboardType == TextInputType.number
                    ? <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ]
                    : null,
                focusNode: _focusNode,
                textInputAction: widget.textInputAction,
                keyboardType: widget.keyboardType,
                onSubmitted: (text) {
                  debugPrint(text);
                },
                onChanged: (text) {
                  this.text = text;
                  // FocusScope.of(context).nextFocus();
                  if (ending && text.length == widget.maxLength) {
                    return;
                  }
                  _bindTextIntoWidget(text);
                  setState(() {});
                  widget.onChange(text);
                  ending = text.length == widget.maxLength;
                  if (ending) {
                    widget.onSubmit(text);
                    FocusScope.of(context).unfocus();
                  }
                },
              ),
            ),
          )
        ]),
      ),
    );
  }

  void onFieldFocus() {
    if (View.of(context).viewInsets.bottom <= 0.0 &&
        text.length != widget.maxLength) {
      FocusScope.of(context).unfocus();
      _focusNode = FocusNode();
      _focusNode.addListener(_focusListener);
    }
    _focusNode.requestFocus();
  }

  List<Widget> _buildBody(BuildContext context) {
    var tmp = <Widget>[];
    for (var i = 0; i < widget.maxLength; i++) {
      tmp.add(_buildFieldInput(context, i));
      if (i < widget.maxLength - 1) {
        tmp.add(SizedBox(
          width: widget.otpPinFieldStyle!.fieldPadding,
        ));
      }
    }
    return tmp;
  }

  Widget cursorWidget({Color? cursorColor, double? cursorWidth, int? index}) {
    return Container(
      padding: pinsInputed[index ?? 0].isNotEmpty
          ? const EdgeInsets.only(left: 15)
          : EdgeInsets.zero,
      child: FadeTransition(
        opacity: _cursorAnimation,
        child: CustomPaint(
          size: const Size(0, 25),
          painter: CursorPainter(
            cursorColor: cursorColor,
            cursorWidth: cursorWidth,
          ),
        ),
      ),
    );
  }

  Widget _buildFieldInput(BuildContext context, int i) {
    Color fieldBorderColor;
    Color? fieldBackgroundColor;
    Gradient? fieldBorderGradient;
    BoxDecoration boxDecoration;
    BoxDecoration? foregroundBoxDecoration;

    Widget showCursorWidget() => widget.showCursor!
        ? _shouldHighlight(i)
            ? cursorWidget(
                cursorColor: widget.cursorColor,
                cursorWidth: widget.cursorWidth,
                index: i)
            : const SizedBox.shrink()
        : const SizedBox.shrink();

    fieldBorderColor = widget.highlightBorder && _shouldHighlight(i)
        ? Colors.blue
        : (pinsInputed[i].isNotEmpty &&
                widget.otpPinFieldStyle?.filledFieldBorderColor !=
                    Colors.transparent)
            ? Colors.yellow.withOpacity(.2)
            :Colors.blue.withOpacity(.2);
    fieldBackgroundColor = widget.highlightBorder && _shouldHighlight(i)
        ? widget.otpPinFieldStyle!.activeFieldBackgroundColor
        : (pinsInputed[i].isNotEmpty &&
                widget.otpPinFieldStyle?.filledFieldBackgroundColor !=
                    Colors.transparent)
            ? widget.otpPinFieldStyle!.filledFieldBackgroundColor
            : widget.otpPinFieldStyle!.defaultFieldBackgroundColor;

    fieldBorderGradient = widget.highlightBorder &&
            _shouldHighlight(i) &&
            widget.otpPinFieldStyle?.activeFieldBorderGradient != null
        ? widget.otpPinFieldStyle!.activeFieldBorderGradient
        : (pinsInputed[i].isNotEmpty &&
                widget.otpPinFieldStyle?.filledFieldBorderGradient != null)
            ? widget.otpPinFieldStyle!.filledFieldBorderGradient
            : widget.otpPinFieldStyle?.defaultFieldBorderGradient;

    if (widget.otpPinFieldDecoration ==
        OtpPinFieldDecoration.underlinedPinBoxDecoration) {
      boxDecoration = BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: fieldBorderColor,
            width: 2.0,
          ),
        ),
      );
    } else if (widget.otpPinFieldDecoration ==
        OtpPinFieldDecoration.defaultPinBoxDecoration) {
      boxDecoration = BoxDecoration(
          border: Border.all(color: fieldBorderColor, width: 2.0),
          color: fieldBackgroundColor,
          borderRadius: BorderRadius.circular(5.0));

      if (fieldBorderGradient != null) {
        foregroundBoxDecoration = BoxDecoration(
            border: GradientBoxBorder(
              gradient: fieldBorderGradient,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(5.0));
      }
    } else if (widget.otpPinFieldDecoration ==
        OtpPinFieldDecoration.roundedPinBoxDecoration) {
      boxDecoration = BoxDecoration(
        border: Border.all(
          color: fieldBorderColor,
          width: widget.otpPinFieldStyle!.fieldBorderWidth,
        ),
        shape: BoxShape.circle,
        color: fieldBackgroundColor,
      );
      if (fieldBorderGradient != null) {
        foregroundBoxDecoration = BoxDecoration(
          border: GradientBoxBorder(
            gradient: fieldBorderGradient,
            width: 2.0,
          ),
          shape: BoxShape.circle,
        );
      }
    } else {
      boxDecoration = BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: fieldBorderColor,
              width: 1.0,
            ),
          ),
          color: const Color(0xFFF8FBFF),
          borderRadius: BorderRadius.circular(
              widget.otpPinFieldStyle!.fieldBorderRadius));

    }

    return Container(
        width: widget.fieldWidth,
        alignment: Alignment.center,
        foregroundDecoration: foregroundBoxDecoration,
        decoration: boxDecoration,
        child: Stack(
          children: [
            Center(
              child: showCursorWidget(),
            ),
            Center(
              child: Text(
                _getPinDisplay(i),
                style: widget.otpPinFieldStyle?.textStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ));
  }

  String _getPinDisplay(int position) {
    var display = '';
    var value = pinsInputed[position];
    switch (widget.otpPinFieldInputType) {
      case OtpPinFieldInputType.password:
        display = '*';
        break;
      case OtpPinFieldInputType.custom:
        display = widget.otpPinInputCustom;
        break;
      default:
        display = value;
        break;
    }
    if(display.isEmpty && value.isEmpty){
      return "-";
    }
    return value.isNotEmpty ? display : value;
  }

  void _bindTextIntoWidget(String text) {
    ///Reset value
    for (var i = text.length; i < pinsInputed.length; i++) {
      pinsInputed[i] = '';
    }
    if (text.isNotEmpty) {
      for (var i = 0; i < text.length; i++) {
        pinsInputed[i] = text[i];
      }
    }
  }

  void _focusListener() {
    if (mounted == true) {
      setState(() {
        hasFocus = _focusNode.hasFocus;
      });
    }
  }

  bool _shouldHighlight(int i) {
    return hasFocus &&
        (i == text.length ||
            (i == text.length - 1 && text.length == widget.maxLength));
  }

  clearOtp() {
    controller.text = '';
    setState(() {
      _focusNode = FocusNode();
      pinsInputed = [];
      for (var i = 0; i < widget.maxLength; i++) {
        pinsInputed.add('');
      }
      _focusNode.addListener(_focusListener);
      ending = false;
      hasFocus = widget.highlightBorder;
      text = '';
    });
  }

  @override
  void codeUpdated() {
    debugPrint('auto fill sms code is $code');
    if (controller.text != code && code != null) {
      controller.value = TextEditingValue(text: code ?? '');
      if (widget.onCodeChanged != null) {
        widget.onCodeChanged!(code ?? '');
      }
      FocusManager.instance.primaryFocus?.unfocus();
      setState(() {
        _focusNode = FocusNode();
        if (code?.isNotEmpty == true) {
          for (var i = 0; i < code!.length; i++) {
            pinsInputed[i] = code![i];
          }
        }
        _focusNode.addListener(_focusListener);
        ending = true;
        hasFocus = widget.highlightBorder;
        text = code!;
      });
    }
  }

  void _pasteCopyCode(ClipboardData? data) {
    if (controller.text != data?.text && (data?.text ?? '').isNotEmpty) {
      controller.value = TextEditingValue(
          text: (data?.text ?? '').substring(0, widget.maxLength));

      if ((data?.text ?? '').substring(0, widget.maxLength).isNotEmpty ==
          true) {
        for (var i = 0; i < widget.maxLength; i++) {
          pinsInputed[i] = (data?.text ?? '')[i];
        }
      }
      text = (data?.text ?? '').substring(0, widget.maxLength);
      setState(() {});

      widget.onChange(text);
      ending = text.length == widget.maxLength;
      if (ending) {
        widget.onSubmit(text);
        FocusScope.of(context).unfocus();
        hideKeyboard();
      }
    }
  }

  void pasteCode() async {
    var data = await Clipboard.getData('text/plain');
    if (data?.text?.isNotEmpty ?? false) {
      if (widget.beforeTextPaste != null) {
        if (widget.beforeTextPaste!(data!.text)) {
          _pasteCopyCode(data);
        }
      } else {
        _pasteCopyCode(data);
      }
    }
  }
}

class _OtpPinFieldAutoFill {
  static _OtpPinFieldAutoFill? _singleton;
  static const MethodChannel _channel = MethodChannel('otp_pin_field');
  final StreamController<String> _code = StreamController.broadcast();

  factory _OtpPinFieldAutoFill() => _singleton ??= _OtpPinFieldAutoFill._();

  _OtpPinFieldAutoFill._() {
    _channel.setMethodCallHandler(_didReceive);
  }

  Future<String?> getPlatformVersion() {
    return OtpPinFieldPlatform.instance.getPlatformVersion();
  }

  Future<void> _didReceive(MethodCall method) async {
    if (method.method == 'smsCode') {
      _code.add(method.arguments);
    }
  }

  Stream<String> get code => _code.stream;

  Future<String?> get hint async {
    return OtpPinFieldPlatform.instance.requestPhoneHint();
  }

  Future<void> listenForCode({String smsCodeRegexPattern = '\\d{0,4}'}) async {
    OtpPinFieldPlatform.instance.listenForCode(
        <String, String>{'smsCodeRegexPattern': smsCodeRegexPattern});
  }

  Future<void> unregisterListener() async {
    OtpPinFieldPlatform.instance.unregisterListener();
  }

  Future<String> get getAppSignature async {
    return OtpPinFieldPlatform.instance.getAppSignature();
  }
}

mixin OtpPinAutoFill {
  final _OtpPinFieldAutoFill _autoFill = _OtpPinFieldAutoFill();
  String? code;
  StreamSubscription? _subscription;

  void listenForCode({String? smsCodeRegexPattern}) {
    _subscription = _autoFill.code.listen((code) {
      this.code = code;
      codeUpdated();
    });

    (smsCodeRegexPattern == null)
        ? _autoFill.listenForCode()
        : _autoFill.listenForCode(smsCodeRegexPattern: smsCodeRegexPattern);
  }

  Future<void> cancel() async {
    return _subscription?.cancel();
  }

  Future<void> unregisterListener() {
    return _autoFill.unregisterListener();
  }

  void codeUpdated();
}
