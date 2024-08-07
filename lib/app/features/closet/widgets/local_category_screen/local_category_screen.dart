part of '../../pages/category_screen.dart';

class _LocalCategoryScreen extends StatelessWidget {
  const _LocalCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => DIService.sl<GetCategoryBloc>()..add(GetCategoriesEvent())),
          BlocProvider(create: (_) => DIService.sl<UpdateCategoryBloc>()),
          BlocProvider(create: (_) => DIService.sl<DeleteCategoryBloc>())
        ],
        child: BaseBackScreen(
          title: "Categories",
          additionWidgets: [
            BlocBuilder<GetCategoryBloc, CategoryState>(builder: (context, state){
              return Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.2),
                    borderRadius: BorderRadius.circular(8)),
                child: const Icon(
                  Icons.add,
                  color: Colors.blue,
                ),
              ).onClick(() {
                UI.showCreateNewCategory(context).then((value){
                  context.read<GetCategoryBloc>().add(GetCategoriesEvent());
                });
              });
            }),
            const Gap(16)
          ],
          child: BlocConsumer<GetCategoryBloc, CategoryState>(
            builder: (context, state) {

              if (state is CategoryLoadingState) {
                return _buildSkeleton();
              }

              if (state is CategoryGetSuccessState) {
                return Column(
                  children: [
                    BlocListener<DeleteCategoryBloc, CategoryState>(listener: (context, state){
                      if(state is CategoryDeleteSuccessState){
                        context.read<GetCategoryBloc>().add(GetCategoriesEvent());
                      }
                      if(state is CategoryErrorState){

                      }

                    }, child: const SizedBox(),),
                    Expanded(child: _ListBuilder(key: ValueKey(DateTime.now().microsecond),categories: state.categories))
                  ],
                );
              }
              return firstCategory(context);
            },
            listener: (BuildContext context, CategoryState state) {
            },
          ),
        ));
  }

  Widget firstCategory(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [

          const Gap(16),
          Text(
            "Hình như bạn vẫn chưa có loại đồ nào nhỉ?",
            style: GoogleFonts.roboto(
                textStyle: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w700,
                    fontSize: 16)),
          ),
          const Gap(20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF00C9FF), Color(0xFF92FE9D)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ), borderRadius: BorderRadius.circular(16)),
            child: Text(
              "Nhấn vào đây để tạo nhé",
              style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 14)),
            ),
          ).onClick(() => showDialog(
              context: context,
              builder: (context) {
                return Dialog(key: ValueKey(DateTime.now().microsecond), child: AddNewCategoryDialog());
              })),
          const Gap(32),
          Image.asset(
            Assets.imagesNewCategory,
            height: 300,
          ),


        ],
      ),
    );
  }

  Widget _buildSkeleton() {
    return Skeletonizer(
      enabled: true,
      child: Column(
        children: [
          const Gap(16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Áo mặc đi bơi",
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w700,
                            fontSize: 16))),
                Image.asset(
                  Assets.iconsAddNew,
                  width: 50,
                )
              ],
            ),
          ),
          const Gap(16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Áo mặc đi bơi",
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w700,
                            fontSize: 16))),
                Image.asset(
                  Assets.iconsAddNew,
                  width: 50,
                )
              ],
            ),
          ),
          const Gap(16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Áo mặc đi bơi",
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w700,
                            fontSize: 16))),
                Image.asset(
                  Assets.iconsAddNew,
                  width: 50,
                )
              ],
            ),
          )
        ],
      ).padding(const EdgeInsets.symmetric(horizontal: 16)),
    );
  }
}
