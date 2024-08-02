part of  '../../pages/closet_screen.dart';

class _Filter extends StatelessWidget {
  const _Filter({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _addNewButton(context),
        Expanded(child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildCategoryItem(),
              _buildCategoryItem(),
              _buildCategoryItem(),
              _buildCategoryItem(),
              _buildCategoryItem(),
            ],
          ),
        ))
      ],
    );
  }

  Widget _buildCategoryItem(){
    return Column(
      children: [
        const CircleAvatar(
          radius: 25,
          child: Icon(Icons.add),
        ),
        const Gap(3),
        Text("Add new", style: GoogleFonts.poppins(textStyle: const TextStyle(fontSize: 12)),)
      ],
    ).padding(const EdgeInsets.symmetric(horizontal: 8, vertical: 8));
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
      // showAddNewStuffDialog(context);
    });
  }




}
