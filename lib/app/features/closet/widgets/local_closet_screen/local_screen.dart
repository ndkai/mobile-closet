part of '../../pages/closet_screen.dart';

class _LocalScreen extends StatelessWidget {
  final Closet closet;
  const _LocalScreen({super.key, required this.closet});

  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => DIService.sl<GetClothesBloc>()..add(GetClothesByClosetIdEvent(closet.id))),
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
          body: Column(
            children: [
              _Filter(closet: closet,),
              _Clothes(closet: closet,),
              BlocListener<DeleteClothesBloc, ClothesState>(
                listener: (context, state){
                  if(state is ClothesDeleteSuccessState){
                    Navigator.of(context).pop();
                    context.read<GetClothesBloc>().add(GetClothesByClosetIdEvent(closet.id));
                    UI.showSuccessToast(context, "Delete successful");
                  }
                  if(state is ClothesErrorState){
                    Navigator.of(context).pop();
                  }

                },
                child: const SizedBox(),
              )
            ],
          ),
        ));
  }
}
