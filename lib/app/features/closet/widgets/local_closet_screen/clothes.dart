part of '../../pages/closet_screen.dart';

class _Clothes extends StatelessWidget {
  const _Clothes({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => DIService.sl<GetClothesBloc>()..add(GetClothesListEvent()))
        ],
        child: BlocBuilder<GetClothesBloc, ClothesState>(
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
                          showDialog(context: context, builder: (context){
                            return Scaffold(
                              backgroundColor: Colors.transparent,
                              body: SizedBox(
                                width: SizeConfig.screenWidth,
                                height: SizeConfig.screenHeight,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: SizeConfig.screenWidth! * 0.8,
                                      height: SizeConfig.screenHeight! * 0.3,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                          image: DecorationImage(
                                              image: FileImage(File(state.clothes[index].filePath ?? ""))
                                          )
                                      ),
                                    ),
                                    const Gap(16),
                                    Container(
                                      width: SizeConfig.screenWidth! * 0.6,
                                      padding: EdgeInsets.symmetric(vertical: 8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),color: Colors.white
                                      ),
                                      child: const Column(
                                        children: [
                                         Row(
                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                           children: [
                                             Text("Save"),
                                             Icon(Icons.save_rounded)
                                           ],
                                         ),
                                          Divider(color: Colors.blue,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Save"),
                                              Icon(Icons.save_rounded)
                                            ],
                                          ),
                                          Divider(color: Colors.blue,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Save"),
                                              Icon(Icons.save_rounded)
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ).onClick(() => Navigator.pop(context)),
                            );
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              image: DecorationImage(
                                  image: FileImage(File(state.clothes[index].filePath ?? ""))
                              )
                          ),
                        ),
                      );
                    }),
              );
            }
            return const Text("Empty");
          },
        ));
  }
}
