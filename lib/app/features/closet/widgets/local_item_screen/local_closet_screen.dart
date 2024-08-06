part of '../../pages/items_screen.dart';

class _LocalScreen extends StatefulWidget {
  final Widget filter;
  final Widget clothes;
  final Widget deleteClothesBuilder;
  const _LocalScreen({super.key, required this.filter, required this.clothes, required this.deleteClothesBuilder});

  @override
  State<_LocalScreen> createState() => _LocalScreenState();
}

class _LocalScreenState extends State<_LocalScreen> {
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => DIService.sl<GetClothesBloc>()..add(GetClothesListEvent())),
          BlocProvider(create: (_) => DIService.sl<DeleteClothesBloc>()),
        ],
        child: Scaffold(
          backgroundColor: Colors.grey.withOpacity(.1),
          appBar: AppBar(
            surfaceTintColor: Colors.white,
            title: Text("Your closet", style: GoogleFonts.montserratAlternates(
                textStyle: const TextStyle(color: Colors.blue, fontWeight: FontWeight.w700)
            ),),
            actions: [
              const Icon(Icons.more_vert).padding(const EdgeInsets.only(left: 16)),

            ],
          ),
          body: Column(
            children: [
              widget.filter,
              const Gap(8),
              widget.clothes,
              widget.deleteClothesBuilder
            ],
          ),
        ));
  }


}

