part of  '../../pages/closet_screen.dart';

class _Filter extends StatelessWidget {
  const _Filter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: Colors.white,
      child: Row(
        children: [
          _addNewButton(context),
          BlocProvider(create: (_) => DIService.sl<GetCategoryBloc>()..add(GetCategoriesEvent()),
            child: BlocBuilder<GetCategoryBloc, CategoryState>(
              builder: (context, state){
                if(state is CategoryGetSuccessState){
                  return Expanded(child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: state.categories.map((e) => _buildCategoryItem(e)).toList(),
                      )
                  ));
                }
                return const Gap(1);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCategoryItem(Category category){
    return Column(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: Colors.red,
          backgroundImage: category.filePath != null ? FileImage(File(category.filePath!)) : null,
        ),
        const Gap(3),
        Text(category.name ?? "", style: GoogleFonts.poppins(textStyle: const TextStyle(fontSize: 12)), overflow: TextOverflow.ellipsis,)
      ],
    ).padding(const EdgeInsets.symmetric(horizontal: 12, vertical: 8));
  }

  Widget _addNewButton(BuildContext context){
    return Column(
      children: [
        const CircleAvatar(
          radius: 25,
          child: Icon(Icons.add),
        ),
        const Gap(3),
        Text("Add new", style: GoogleFonts.poppins(textStyle: const TextStyle(fontSize: 12)),)
      ],
    ).padding(const EdgeInsets.only(right: 8)).onClick((){
      UI.showCreateNewClothesDialog(context);
    });
  }




}
