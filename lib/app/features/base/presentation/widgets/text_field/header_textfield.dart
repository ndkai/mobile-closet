import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../../config/theme/theme.dart';
import '../../../../../../core/models/enums/input_type.dart';
import 'custom_text_form_field.dart';

class HeaderTextField extends StatelessWidget {
  final InputType inputType;
  final String title;
  final String hint;
  final int maxLines;
  final bool allowEmpty;
  final ValueChanged<String> valueChanged;
  const HeaderTextField({
    super.key, 
    this.inputType = InputType.plainText,
    required this.title, 
    required this.hint,
    this.maxLines = 1, 
    this.allowEmpty = false, 
    required this.valueChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(20),
        Text(
          title,
          style: AppTheme.currentTheme.textTheme.titleSmall!
              .merge(const TextStyle(color: Colors.black)),
        ),
        const Gap(5),
        CustomTextFormField(
          controller: TextEditingController(),
          label: hint,
          allowEmpty: allowEmpty,
          maxLines: maxLines,
          inputType: inputType,
          onChanged: (String value) {
            valueChanged(value);
          },
        )
      ],
    );
  }
}
