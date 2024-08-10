import 'package:clean_architechture/core/extensions/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

import '../../../../../core/services/di_service.dart';
import '../../../closet/manager/clothes/clothes_bloc.dart';

class OutfitCreationScreen extends StatelessWidget {
  const OutfitCreationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
        providers:  [
          // BlocProvider(create: (_) => DIService.sl<GetClothesBloc>()..add(GetClothesByClosetIdEvent(closet.id))),
          BlocProvider(create: (_) => DIService.sl<DeleteClothesBloc>()),
        ],
        child: Scaffold(
          appBar: AppBar(
            leading: Container(
              padding: const EdgeInsets.all(16),
              child: const Icon(Icons.arrow_back_ios_new, color: Colors.blue,),
            ).onClick(() => Navigator.of(context).pop()),
            surfaceTintColor: Colors.white,
            centerTitle: true,
            title: Text("Your closet", style: GoogleFonts.montserratAlternates(
                textStyle: const TextStyle(color: Colors.blue, fontWeight: FontWeight.w700)
            ),),
            actions: [
              const Icon(Icons.more_vert).padding(const EdgeInsets.only(left: 16)),
            ],
          ),
          backgroundColor: Colors.white70,
          body: SingleChildScrollView(
            child: ,
          ),
        ));
  }
}
