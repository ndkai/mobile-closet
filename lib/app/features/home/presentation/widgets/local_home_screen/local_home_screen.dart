part of '../../pages/home_screen.dart';


class _LocalHomeScreen extends StatelessWidget {
  final Widget header;
  final Widget recent;
  final Widget category;
  final Widget clothes;
  const _LocalHomeScreen({super.key, required this.header, required this.category, required this.clothes, required this.recent});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => DIService.sl<GetClothesBloc>()..add(GetClothesListEvent())),
          BlocProvider(create: (_) => DIService.sl<DeleteClothesBloc>()),
        ],
        child: Scaffold(
          // backgroundColor: Colors.grey.withOpacity(.1),
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
              header,
              const Gap(16),
              recent
            ],
          ),
        ));
  }
}
