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
        BlocListener<CreateClosetBloc, ClosetState>(listener: (context, state){
          print("CreateClosetBloc ${state}");
          if(state is ClosetCreateSuccessState){
            // Navigator.pop(context);
            context.read<GetClosetBloc>().add(GetClosetListEvent());
          }
          if(state is ClosetErrorState){
            // Navigator.pop(context);
            UI.showAlertDialog(context, msg: "Alert",
                description: Text(state.msg, style: GoogleFonts.roboto(
                    textStyle: const TextStyle(fontSize: 14, color: Colors.black)
                ),), onTap: (){
                  Navigator.pop(context);

                });
          }


        }, child: const SizedBox(),),
        _filter(),
        BlocBuilder<GetClosetBloc, ClosetState>(builder: (ccontext, state) {
          List<Closet> closet = [];
          if (state is ClosetGetSuccessState) {
            closet = state.closet;
          }
          return GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 3.0,
              mainAxisSpacing: 3.0,
              childAspectRatio: 1.0,
            ),
            shrinkWrap: true,
            itemCount: closet.length + 1,
            itemBuilder: (BuildContext gcontext, int index) {
              if (index == closet.length) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Container(
                      width: 1000,
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(.2),
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            Assets.iconsWardrobe,
                            width: 40,
                          ),
                          const Gap(16),
                          Text("Create new closet",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                              ))
                        ],
                      ),
                    )),
                    const Text("")
                  ],
                ).onClick(() => showDialog(context: context, builder: (xcontext){
                  return Dialog(
                    child: NewClosetDialogBuilder(onConfirm: (c){
                      context.read<CreateClosetBloc>().add(CreateClosetEvent(c));
                    },),
                  );
                }));
              }
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
                        Expanded(
                            child: Row(
                          children: [
                            Expanded(
                                child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: const BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8))),
                                    child:
                                        Image.asset(Assets.imagesEmptyCloset))),
                            const Gap(2),
                            Expanded(
                                child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                  color: Colors.yellow,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(8))),
                            )),
                          ],
                        )),
                        const Gap(2),
                        Expanded(
                            child: Row(
                          children: [
                            Expanded(
                                child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                  color: Colors.yellow,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(8))),
                            )),
                            const Gap(2),
                            Expanded(
                                child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(8))),
                            )),
                          ],
                        ))
                      ],
                    ),
                  )),
                  Text(
                    closet[index].name ?? "",
                    style: const TextStyle(
                      color: Color(0xFF014494),
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                    ),
                  ).padding(const EdgeInsets.symmetric(horizontal: 16)),
                ],
              ).onClick(() => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ClosetScreen(closet: closet[index],))));
            },
          );
        }),
      ],
    );
  }

  Widget _filter() {
    return Row(
      children: [
        _filterItem(0, "Closet"),
        _filterItem(1, "Outfit"),
        _filterItem(2, "Favorite"),
      ],
    );
  }

  Widget _filterItem(int initItem, String name) {
    return Expanded(
        child: Column(
      children: [
        Text(
          name,
          style: TextStyle(
            color: initItem == selectedIndex
                ? const Color(0xFF014494)
                : Colors.grey,
            fontSize: 14,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
          ),
        ),
        Divider(
          color:
              initItem == selectedIndex ? const Color(0xFF014494) : Colors.grey,
          thickness: initItem == selectedIndex ? 2 : 1,
        )
      ],
    ).onClick(() {
      setState(() {
        selectedIndex = initItem;
      });
    }));
  }
}
