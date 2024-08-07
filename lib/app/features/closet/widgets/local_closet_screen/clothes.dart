part of '../../pages/closet_screen.dart';

class _Clothes extends StatelessWidget {
  final Closet closet;
  const _Clothes({super.key, required this.closet});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetClothesBloc, ClothesState>(
      builder: (context, state) {
        if(state is ClothesGetSuccessState){
          return Expanded(
            child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 3.0,
                  mainAxisSpacing: 3.0,
                  childAspectRatio: 1.0,
                ),
                itemCount: state.clothes.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onLongPress: (){
                      UI.showClothesActionDialog(context, state.clothes[index]);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          image: DecorationImage(
                              image: FileImage(File(state.clothes[index].filePath ?? ""))
                          )
                      ),
                    ),
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClothesDetailsScreen(clothes: state.clothes[index],)));
                    },
                  );
                }),
          );
        }
        return Expanded(child: Container(
          width: SizeConfig.screenWidth,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: const BoxDecoration(
              color: Colors.white
          ),
          child:
          Column(
            children: [
              const Gap(16),
              Image.asset(Assets.imagesEmptyCloset, height: 200,),
              const Gap(16),
              Text("Your closet is empty", style: GoogleFonts.roboto(textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),),
              const Gap(8),
              Text("Please add more clothes to continue your journey",
                style: GoogleFonts.roboto(textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey)), textAlign: TextAlign.center,),
              const Gap(32),
              PositiveButton(onTap: (){
                UI.showCreateNewClothesDialog(context, closetId: closet.id).then((value) => context.read<GetClothesBloc>().add(GetClothesByClosetIdEvent(closet.id)));
              }, width: SizeConfig.screenWidth! * 0.9, height: 44, label: "Add New")
            ],
          ),
        ));
      },
    );
  }
}
