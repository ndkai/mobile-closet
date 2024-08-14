import 'dart:io';
import 'dart:math';

import 'package:clean_architechture/config/size/size_config.dart';
import 'package:clean_architechture/core/extensions/widget_extension.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

import '../../../../../core/services/di_service.dart';
import '../../../../../core/services/isar/schemas/closet.dart';
import '../../../closet/manager/closet/closet_bloc.dart';
import '../../../closet/manager/clothes/clothes_bloc.dart';
import '../../blocs/outfit_manager_cubit.dart';

class OutfitCreationScreen extends StatelessWidget {
  const OutfitCreationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BuildContext clothesContext = context;
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) =>
                  DIService.sl<GetClosetBloc>()..add(GetClosetListEvent())),
          BlocProvider(create: (_) => DIService.sl<GetClothesBloc>()),
          BlocProvider(create: (_) => OutfitManagerCubit()),
          BlocProvider(create: (_) => CurrentOutfitCubit()),
        ],
        child: Scaffold(
          appBar: AppBar(
            leading: Container(
              padding: const EdgeInsets.all(16),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.blue,
              ),
            ).onClick(() => Navigator.of(context).pop()),
            surfaceTintColor: Colors.white,
            centerTitle: true,
            title: Text(
              "Your closet",
              style: GoogleFonts.montserratAlternates(
                  textStyle: const TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.w700)),
            ),
            actions: [
              const Icon(Icons.more_vert)
                  .padding(const EdgeInsets.only(left: 16)),
            ],
          ),
          backgroundColor: Colors.white,
          body: Column(
            children: [
              Expanded(
                  child: Container(
                      width: SizeConfig.screenWidth,
                      color: Colors.white,
                      child: DraggableWidgetArea())),
              BlocBuilder<CurrentOutfitCubit, int>(
                  builder: (context, state) {
                if (state == -1) {
                  return const SizedBox();
                }
                return Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(color: Colors.grey.withOpacity(.2)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(),
                        child: const Column(
                          children: [
                            Icon(Icons.zoom_in_map),
                            Text(
                              "Zoom in",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Gap(16),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(),
                        child: const Column(
                          children: [
                            Icon(Icons.zoom_in_map),
                            Text(
                              "Zoom in",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Gap(16),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(),
                        child: const Column(
                          children: [
                            Icon(Icons.flip),
                            Text(
                              "Flip",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ).onClick((){
                        context.read<OutfitManagerCubit>().items.first.key.currentState!.flipWidget();
                      }),
                      const Gap(16),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(),
                        child: const Column(
                          children: [
                            Icon(Icons.delete),
                            Text(
                              "Delete",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ).onClick((){
                        context.read<OutfitManagerCubit>().removeItem(context.read<CurrentOutfitCubit>().currentItem);
                        context.read<CurrentOutfitCubit>().removeItem(-1);
                      }),
                    ],
                  ),
                );
              }),
              Container(
                width: SizeConfig.screenWidth,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(.3),
                          offset: const Offset(0, -3))
                    ],
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16))),
                child: SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Gap(16),
                      BlocBuilder<GetClosetBloc, ClosetState>(
                        builder: (context, closets) {
                          if (closets is ClosetGetSuccessState) {
                            return Column(
                              children: [
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: _BuildClosetFilter(
                                    closets: closets.closet,
                                    onTap: (e) {
                                      clothesContext
                                          .read<GetClothesBloc>()
                                          .add(GetClothesByClosetIdEvent(e.id));
                                    },
                                  ).padding(const EdgeInsets.symmetric(
                                      horizontal: 8)),
                                ),
                                const Gap(16),
                                BlocBuilder<GetClothesBloc, ClothesState>(
                                  builder: (context, state) {
                                    clothesContext = context;
                                    if (state is ClothesInitState) {
                                      context.read<GetClothesBloc>().add(
                                          GetClothesByClosetIdEvent(
                                              closets.closet.first.id));
                                    }
                                    if (state is ClothesGetSuccessState) {
                                      return SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: state.clothes
                                              .map((item) => Container(
                                                    height: 100,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image: FileImage(File(
                                                                item.filePath ??
                                                                    "")))),
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 8),
                                                  ).onClick(() {
                                                    GlobalKey<OutfitItemState> key = GlobalKey<OutfitItemState>();
                                                    int id = DateTime.now().microsecondsSinceEpoch;
                                                    final outfit = OutfitItem(
                                                        top: 100,
                                                        left: 100,
                                                        key: Key(DateTime.now()
                                                            .microsecondsSinceEpoch
                                                            .toString()),
                                                        id: id,
                                                        child: Container(
                                                          height: 100,
                                                          width: 100,
                                                          decoration: BoxDecoration(
                                                              image: DecorationImage(
                                                                  image: FileImage(
                                                                      File(item
                                                                              .filePath ??
                                                                          "")))),
                                                          margin:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      8),
                                                        ));

                                                    context
                                                        .read<
                                                            OutfitManagerCubit>()
                                                        .addItem(OutfitManagerState(key, outfit, id ));
                                                  }))
                                              .toList(),
                                        ).padding(const EdgeInsets.symmetric(
                                            horizontal: 8)),
                                      );
                                    }
                                    return Container(
                                      height: 100,
                                      width: 100,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(.3),
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      child: const Center(
                                        child: Icon(
                                          Icons.add,
                                          size: 30,
                                        ),
                                      ),
                                    ).align(Alignment.centerLeft);
                                  },
                                ),
                              ],
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                      const Gap(16),
                      // Row(
                      //   children: [
                      //     Text(" Duy  ", style: TextStyle(
                      //       color: Colors.red,
                      //       fontSize: 14,
                      //       fontFamily: 'Roboto',
                      //       fontWeight: FontWeight.w500,
                      //     ),),
                      //     Text("Duy  ", style: TextStyle(
                      //       color: Colors.red,
                      //       fontSize: 14,
                      //       fontFamily: 'Roboto',
                      //       fontWeight: FontWeight.w500,
                      //     ),),
                      //     Text("Duy", style: TextStyle(
                      //       color: Colors.red,
                      //       fontSize: 14,
                      //       fontFamily: 'Roboto',
                      //       fontWeight: FontWeight.w500,
                      //     ),),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

class _BuildClosetFilter extends StatefulWidget {
  final List<Closet> closets;
  final Function(Closet) onTap;

  const _BuildClosetFilter(
      {super.key, required this.closets, required this.onTap});

  @override
  State<_BuildClosetFilter> createState() => _BuildClosetFilterState();
}

class _BuildClosetFilterState extends State<_BuildClosetFilter> {
  late int selected;

  @override
  void initState() {
    super.initState();
    selected = widget.closets.first.id;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: widget.closets
          .map(
            (e) => Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                  color: selected == e.id ? Colors.blue : Colors.white,
                  borderRadius: BorderRadius.circular(12)),
              child: Text(e.name ?? "",
                  style: TextStyle(
                    color: selected == e.id ? Colors.white : Colors.black,
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  )).onClick(() {
                setState(() {
                  selected = e.id;
                });
                widget.onTap(e);
              }),
            ),
          )
          .toList(),
    );
  }
}

class DraggableWidgetArea extends StatefulWidget {
  const DraggableWidgetArea({super.key});

  @override
  _DraggableWidgetAreaState createState() => _DraggableWidgetAreaState();
}

class _DraggableWidgetAreaState extends State<DraggableWidgetArea> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OutfitManagerCubit, List<OutfitManagerState>>(
        builder: (context, state) {
      return Stack(
        children: state.map((e) => e.item).toList(),
      ).onClick(() {
        context.read<CurrentOutfitCubit>().removeItem(-1);
      });
    });
  }
}

class OutfitItem extends StatefulWidget {
  final Widget child;
  final double top;
  final double left;
  final int id;

  const OutfitItem(
      {super.key, required this.child, required this.top, required this.left, required this.id});

  @override
  State<OutfitItem> createState() => OutfitItemState();
}

class OutfitItemState extends State<OutfitItem> {
  late double top;
  late double left;
  double height = 100;
  double width = 100;
  bool focus = false;
  //flip
  double flip = 0;
  //scale
  double scale = 1.0;
  double previousScale = 1.0;
  @override
  void initState() {
    super.initState();
    top = widget.top;
    left = widget.left;
  }

  void toggleEnable() {
    setState(() {
      focus = !focus;
    });
  }

  void flipWidget(){
    setState(() {
      if(flip == 0){
        flip = pi;
      } else {
        flip = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentOutfitCubit, int>(builder: (context, state) {
      focus = state == widget.id;
      return Positioned(
        top: top,
        left: left,
        child: GestureDetector(
          onPanUpdate: (details) {
            setState(() {
              top += details.delta.dy;
              left += details.delta.dx;
            });
          },
          child: GestureDetector(
            onTap: () {
              if (focus) {
                context.read<CurrentOutfitCubit>().removeItem(-1);
              } else {
                context
                    .read<CurrentOutfitCubit>()
                    .addItem(widget.id);
              }
            },
            // onScaleStart: (details) {
            //   previousScale = scale;
            // },
            // onScaleUpdate: (ScaleUpdateDetails details) {
            //   setState(() {
            //     scale = previousScale * details.scale;
            //   });
            // },
            // onScaleEnd: (details) {
            //   previousScale = 1.0;
            // },
            child: Transform.scale(
              scale: scale,
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(flip), //
                child: focus
                    ? DottedBorder(
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(2),
                  // padding: const EdgeInsets.all(6),
                  child: SizedBox(
                    height: height,
                    width: width,
                    child: widget.child,
                  ),
                )
                    : SizedBox(
                  height: height,
                  width: width,
                  child: widget.child,
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
