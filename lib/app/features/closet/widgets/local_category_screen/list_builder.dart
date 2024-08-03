part of '../../pages/category_screen.dart';

class _ListBuilder extends StatefulWidget {
  final List<Category> categories;

  const _ListBuilder({super.key, required this.categories});

  @override
  State<_ListBuilder> createState() => _ListBuilderState();
}

class _ListBuilderState extends State<_ListBuilder> {
  String searchKey = "";
  ScrollController scrollController = ScrollController();
  late List<Category> categories;

  @override
  void initState() {
    super.initState();
    categories = widget.categories.reversed.toList();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("rebuild");
    return Column(
      children: [
        SearchWidget(
          title: "Search by category name",
          height: 55,
          onChanged: (s) {
            setState(() {
              searchKey = s.toLowerCase();
              categories = widget.categories.reversed
                  .toList()
                  .where((element) => element.name!
                      .toLowerCase()
                      .contains(searchKey.toLowerCase()))
                  .toList();
            });
          },
        ).padding(const EdgeInsets.symmetric(horizontal: 8)),
        Expanded(
            child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: ListView.builder(
              // reverse: true,
              controller: scrollController,
              itemCount: categories.length + 1,
              itemBuilder: (_, index) {
                if (index == categories.length) {
                  return const SizedBox(height: 60);
                }
                return _buildItem(categories[index], context);
              }),
        ))
      ],
    );
  }

  Widget _buildItem(Category category, BuildContext context) {
    return Slidable(
        additionItems: [
          // SlidableItem(
          //     name: "Edit",
          //     icon: Icons.edit,
          //     onTap: () {},
          //     color: Colors.green),
          SlidableItem(
              name: "Delete",
              icon: Icons.delete,
              onTap: () {
                UI.showConfirmDialog(context,
                    msg: "Alert",
                    description: Text(
                      "Are you to sure delete?",
                      style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              fontSize: 13)),
                    ), onTap: () {
                  Navigator.pop(context);
                  context.read<DeleteCategoryBloc>().add(DeleteCategoryEvent(category.id));
                });
              },
              color: Colors.red),
        ],
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(category.name ?? "",
                  style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 16))),
              AppFileImage(path: category.filePath, height: 50, width: 50)
            ],
          ),
        ));
  }
}
