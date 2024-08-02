part of '../../pages/category_screen.dart';

class _LocalCategoryScreen extends StatelessWidget {
  const _LocalCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DIService.sl<CategoryBloc>()..add(GetCategoriesEvent()),
      child: BaseBackScreen(
        title: "Categories",
        additionWidgets: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(.2),
              borderRadius: BorderRadius.circular(8)
            ),
            child: const Icon(Icons.add, color: Colors.blue,),
          ).onClick((){
            UI.showCreateNewCategory(context);
          }),
          const Gap(16)
        ],
        child: BlocConsumer<CategoryBloc, CategoryState>(
          builder: (context, state) {
            if (state.isLoading) {
              return _buildSkeleton();
            } else {
              if (state.data.isNotEmpty) {
                  return _ListBuilder(categories:state.data);
              }
            }
            return firstCategory(context);
          },
          listener: (BuildContext context, CategoryState state) {},
        ),
      ),
    );
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
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                    fontSize: 14)),
          ),
          const Gap(8),
          Text(
            "Hãy tạo thêm nào!!!",
            style: GoogleFonts.roboto(
                textStyle: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w700,
                    fontSize: 16)),
          ),
          const Gap(32),
          Image.asset(
            Assets.iconsAddNew,
            height: 100,
          ),
          const Gap(32),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
                color: Colors.green, borderRadius: BorderRadius.circular(16)),
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
                return const Dialog(child: AddNewCategoryDialog());
              }))
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
