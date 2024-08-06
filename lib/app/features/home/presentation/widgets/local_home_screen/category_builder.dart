part of '../../pages/home_screen.dart';

class _Category extends StatefulWidget {
  const _Category({super.key});

  @override
  State<_Category> createState() => _CategoryState();
}

class _CategoryState extends State<_Category> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _filter(),
        GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 3.0,
            mainAxisSpacing: 3.0,
            childAspectRatio: 1.0,
          ),
          shrinkWrap: true,
          itemCount: 4,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(.2),
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        children: [
                          Expanded(child: Row(
                            children: [
                              Expanded(child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: const BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8))),
                                child: Image.asset(Assets.imagesEmptyCloset))),
                              const Gap(2),
                              Expanded(child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: const BoxDecoration(
                                    color: Colors.yellow,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(8))),)),
                            ],
                          )),
                          const Gap(2),
                          Expanded(child: Row(
                            children: [
                              Expanded(child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: const BoxDecoration(
                                    color: Colors.yellow,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(8))),)),
                              const Gap(2),
                              Expanded(child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: const BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(8))),)),
                            ],
                          ))
                        ],
                      ),
                    )),
                const Text("  All Clothes")
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _filter(){
    return Row(
      children: [
        _filterItem(0, "Closet"),
        _filterItem(1, "Outfit"),
        _filterItem(2, "Favorite"),
      ],
    );
  }

  Widget _filterItem(int initItem, String name){
    return Expanded(child: Column(
      children: [
        Text(name, style: TextStyle(
          color: initItem == selectedIndex ?  const Color(0xFF014494) : Colors.grey,
          fontSize: 14,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
        ),),
        Divider(
          color: initItem == selectedIndex ? const Color(0xFF014494) : Colors.grey,
          thickness: initItem == selectedIndex ? 2 : 1,
        )
      ],
    ).onClick((){
      setState(() {
        selectedIndex = initItem;
      });
    }));
  }
}
