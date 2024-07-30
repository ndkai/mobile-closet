import 'package:clean_architechture/core/extensions/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../generated/assets.dart';
import '../../blocs/toggle_cubit.dart';

class CheckBox extends StatelessWidget {
  final double size;
  final ValueChanged<bool> onChanged;
  const CheckBox({super.key, required this.size, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ToggleCubit(),
      child:BlocBuilder<ToggleCubit, bool>(builder: (context, state) {
        onChanged(state);
        return Container(
          height: size,
          width: size,
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
              gradient: state ? const LinearGradient(
                colors: [
                  Color(0xFF08FFFF), // Start color
                  Color(0xFF007AFF), // End color
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.0016, 0.9245], // Adjust stops based on CSS stops
                transform: GradientRotation(230.31 * 3.1415 / 180), // Convert degrees to radians
              ) : null,
              color: Colors.white,
              border: Border.all(color: const Color(0xFFD0E4FF)),
              borderRadius: BorderRadius.circular(6)
          ),
          child: state ? Center(
            child: SvgPicture.asset(Assets.iconsBlueCheck, color: Colors.white, height: 12, fit: BoxFit.fill,),
          ) : const SizedBox(),
        ).onClick(() => context.read<ToggleCubit>().set(!state));
      })
    );
  }
}
