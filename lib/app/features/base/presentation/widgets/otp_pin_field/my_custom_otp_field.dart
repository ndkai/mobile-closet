import 'package:clean_architechture/app/features/base/presentation/widgets/otp_pin_field/src/otp_pin_field_input_type.dart';
import 'package:clean_architechture/app/features/base/presentation/widgets/otp_pin_field/src/otp_pin_field_state.dart';
import 'package:clean_architechture/app/features/base/presentation/widgets/otp_pin_field/src/otp_pin_field_widget.dart';
import 'package:flutter/cupertino.dart';

class AppOtpPinTextField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmit;
  const AppOtpPinTextField({super.key, required this.onChanged, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    final otpPinFieldController = GlobalKey<OtpPinFieldState>();
    return  OtpPinField(
      key: otpPinFieldController,
      autoFillEnable: false,
      textInputAction: TextInputAction.done,
      onSubmit: onSubmit,
      onChange: onChanged,
      onCodeChanged: (code) {
        print('onCodeChanged  is $code');
      },
      maxLength: 6,
      showCursor: true,
      cursorColor: const Color(0xff007AFF),
      cursorWidth: 2,
      mainAxisAlignment: MainAxisAlignment.center,
      otpPinFieldDecoration:
      OtpPinFieldDecoration.custom,
    );
  }
}
