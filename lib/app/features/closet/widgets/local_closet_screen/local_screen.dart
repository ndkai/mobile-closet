part of '../../pages/closet_screen.dart';

class _LocalScreen extends StatelessWidget {
  final Closet closet;
  const _LocalScreen({super.key, required this.closet});

  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => DIService.sl<GetClothesBloc>()..add(GetClothesByClosetIdEvent(closet.id))),
          BlocProvider(create: (_) => DIService.sl<DeleteClosetBloc>()),
        ],
        child: BlocBuilder<DeleteClosetBloc, ClosetState>(
          builder: (context, state){
            return Scaffold(
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
                  PopupMenuButton(
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 1,
                        child: Text("Favorite"),
                      ),
                      PopupMenuItem(
                        value: 1,
                        child: const Text("Delete"),
                        onTap: (){
                          context.read<DeleteClosetBloc>().add(DeleteClosetEvent(closet.id));
                        },
                      ),
                    ],
                    child: const Icon(Icons.more_vert)
                        .padding(const EdgeInsets.only(left: 16)),
                  ),
                  const Gap(8)
                ],
              ),
              backgroundColor: const Color(0xFFF8FBFF),
              body: Column(
                children: [
                  BlocListener<DeleteClosetBloc, ClosetState>(
                    listener: (context, state){
                      if(state is ClosetDeleteSuccessState){
                        Navigator.pop(context);
                        UI.showSuccessToast(context, "Delete successfull");
                      }
                      if(state is ClosetErrorState){

                      }
                    },
                    child: const SizedBox(),
                  ),
                  _Filter(closet: closet,),
                  const Gap(8),
                  _Clothes(closet: closet,),

                ],
              ),
            );
          },
        ));
  }
}
