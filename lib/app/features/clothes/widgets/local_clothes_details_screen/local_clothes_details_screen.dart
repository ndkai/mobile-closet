part of '../../pages/clothes_details_screen.dart';

class _LocalScreen extends StatelessWidget {
  final Clothes clothes;

  const _LocalScreen({super.key, required this.clothes});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => DIService.sl<GetClothesBloc>()),
          BlocProvider(create: (_) => DIService.sl<CreateClothesDetailsBloc>()),
          BlocProvider(
              create: (_) => DIService.sl<GetClothesDetailsBloc>()
                ..add(GetClothesDetailsEvent(clothes.id))),
          BlocProvider(create: (_) => ToggleCubit()..set(true)),
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
              PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 1,
                    onTap: () async {
                      final editedImage = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ImageEditor(
                            image: File(clothes.filePath??"").readAsBytesSync()
                          ),
                        ),
                      );
                      // to png
                      print("editedImage ${editedImage}");

                      Helper.replaceImage(editedImage, File(clothes.filePath??""));
                    },
                    child: const Text("Edit image"),
                  ),
                  const PopupMenuItem(
                    value: 1,
                    child: Text("Favorite"),
                  ),
                  const PopupMenuItem(
                    value: 1,
                    child: Text("Delete"),
                  ),
                ],
                child: const Icon(Icons.more_vert)
                    .padding(const EdgeInsets.only(left: 16)),
              ),
              const Gap(8)
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppFileImage(
                        path: clothes.filePath ?? "", height: 200, width: 200)
                    .align(Alignment.center),
                const Gap(24),
                const _Filter(),
                const Gap(16),
                BlocBuilder<ToggleCubit, bool>(builder: (context, state) {
                  return state
                      ? _InformationBuilder(
                          clothesId: clothes.id,
                        )
                      : const _OutFit();
                })
              ],
            ),
          ),
        ));
  }
}
