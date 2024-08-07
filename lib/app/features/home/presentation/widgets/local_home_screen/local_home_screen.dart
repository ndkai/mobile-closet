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
          BlocProvider(create: (_) => DIService.sl<CreateClosetBloc>()),
          BlocProvider(create: (_) => DIService.sl<UpdateClosetBloc>()),
          BlocProvider(create: (_) => DIService.sl<DeleteClosetBloc>()),
          BlocProvider(create: (_) => DIService.sl<GetClosetBloc>()..add(GetClosetListEvent())),
        ],
        child: MultiBlocProvider(
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
          body: Container(
            height: SizeConfig.screenHeight,
            child: SingleChildScrollView(
              child: Column(
                children: [

                  header,
                  const Gap(16),
                  // recent,
                  category,
                  const Gap(200)
                ],
              ),
            ),
          ),
        )));
  }
}
