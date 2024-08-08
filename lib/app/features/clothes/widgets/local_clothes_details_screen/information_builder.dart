part of '../../pages/clothes_details_screen.dart';

class _InformationBuilder extends StatefulWidget {
  final int clothesId;
  const _InformationBuilder({super.key, required this.clothesId});

  @override
  State<_InformationBuilder> createState() => _InformationBuilderState();
}

class _InformationBuilderState extends State<_InformationBuilder> {
  ClothesDetails clothDetails = ClothesDetails();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    clothDetails.clothesId = widget.clothesId;
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetClothesDetailsBloc, ClothesDetailsState>(builder: (context, state){
      print("asdasdasdasd ${state}");
      if(state is ClothesDetailsGetSuccessState){
        print("asdasdasdasd ${state.clothesDetails.length}");
        clothDetails = state.clothesDetails.first;
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Make us understand your clothes better", style: GoogleFonts.roboto(
              textStyle: const TextStyle(color: Colors.blue, fontWeight: FontWeight.w500, fontSize: 13)
          ),),
          // const Gap(8),
          _buildHorizonItem(title: "Type", widgets: [
            Text("Red", style: GoogleFonts.roboto(
                textStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16)
            ),),
          ]),
          _buildHorizonItem(title: "Color", widgets: _mapColors(clothDetails.colors??[])).onClick((){
            showDialog(context: context, builder: (aContext){
              return Dialog(
                  child: ColorPickerBuilder(colors: clothDetails.colors != null ? clothDetails.colors! : [], onConfirm: (colors){
                    Navigator.pop(context);
                    setState(() {
                      clothDetails.colors = colors;
                    });
                    context.read<CreateClothesDetailsBloc>().add(CreateClothesDetailsEvent(clothDetails));
                    print(colors.toString());
                  },)
              );
            });
          }),
          _buildHorizonItem(title: "Material", widgets: _mapMaterial(clothDetails.material??[])).onClick((){
            showModalBottomSheet(context: context, builder: (context){
              return MaterialSheerBuilder(materials: clothDetails.material??[], onChange: (List<String> value) {
                setState(() {
                  clothDetails.material = value;
                });
              },);
            });
          }),
          _buildHorizonItem(title: "Brand", widgets: [
            Text("Red", style: GoogleFonts.roboto(
                textStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16)
            ),),
          ]).onClick((){
            showDialog(context: context, builder: (context){
              return Dialog(
                child: Container(
                  color: Colors.white,
                  height: 100,
                  child: const Column(
                    children: [
                      Text("Duy", style: TextStyle(),),

                    ],
                  ),
                ),
              );
            });
          }),
          _buildHorizonItem(title: "Price", widgets: [
            Text("Red", style: GoogleFonts.roboto(
                textStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16)
            ),),
          ]),
          _buildHorizonItem(title: "Purchase date", widgets: [
            Text("Red", style: GoogleFonts.roboto(
                textStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16)
            ),),
          ]),
        ],
      ).padding(const EdgeInsets.symmetric(horizontal: 16));
    });
  }

  Widget _buildHorizonItem({required String title, required List<Widget> widgets}){
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: SizeConfig.screenWidth! * 0.2,
              child: Text(title, style: GoogleFonts.roboto(
                  textStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 16)
              ),),
            ),
            Expanded(child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: widgets,
            ))
          ],
        ).padding(const EdgeInsets.symmetric(vertical: 10)),
        const Divider()
      ],
    );
  }

    List<Widget> _mapColors(List<String> colors){
    if(colors.isEmpty){
      return [
        Text("None", style: GoogleFonts.roboto(
            textStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16)
        ),),
      ];
    }
    return colors.map((e) => Text("  ${e}", style: GoogleFonts.roboto(
        textStyle: TextStyle(color: Color(Constant.popularColors.where((element) => element.name == e).first.color), fontWeight: FontWeight.w600, fontSize: 16)
    ),),).toList();
  }
    List<Widget> _mapMaterial(List<String> materials){
    if(materials.isEmpty){
      return [
        Text("None", style: GoogleFonts.roboto(
            textStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16)
        ),),
      ];
    }
    return materials.map((e) => Text("  ${e}", style: GoogleFonts.roboto(
        textStyle: const TextStyle(color: Colors.blue, fontWeight: FontWeight.w600, fontSize: 16)
    ),),).toList();
  }
}
