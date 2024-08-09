part of '../../pages/clothes_details_screen.dart';

class _InformationBuilder extends StatefulWidget {
  final int clothesId;
  const _InformationBuilder({super.key, required this.clothesId});

  @override
  State<_InformationBuilder> createState() => _InformationBuilderState();
}

class _InformationBuilderState extends State<_InformationBuilder> {
  ClothesDetails clothDetails = ClothesDetails();
  TextEditingController priceController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    clothDetails.clothesId = widget.clothesId;
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetClothesDetailsBloc, ClothesDetailsState>(builder: (context, state){
      if(state is ClothesDetailsGetSuccessState){
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
            Text(clothDetails.type ?? "None", style: GoogleFonts.roboto(
                textStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16)
            ),),
          ]).onClick((){
            UI.showInputFieldDialog(context, title: "Your clothes type", hint: "Input your type",onConfirm: (s) {
              setState(() {
                clothDetails.type = s;
              });
              context.read<CreateClothesDetailsBloc>().add(CreateClothesDetailsEvent(clothDetails));
            }, addition: Constant.fashionCategories);
          }),
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
            showModalBottomSheet(context: context, builder: (acontext){
              return MaterialSheerBuilder(materials: clothDetails.material??[], onChange: (List<String> value) {
                setState(() {
                  clothDetails.material = value;
                });
                context.read<CreateClothesDetailsBloc>().add(CreateClothesDetailsEvent(clothDetails));
              },);
            });
          }),
          _buildHorizonItem(title: "Brand", widgets: [
            Text(clothDetails.brand ?? "None", style: GoogleFonts.roboto(
                textStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16)
            ),),
          ]).onClick((){
            UI.showInputFieldDialog(context, title: "Your clothes brand", hint: "Input your brand",onConfirm: (s) {
              setState(() {
                clothDetails.brand = s;
              });
              context.read<CreateClothesDetailsBloc>().add(CreateClothesDetailsEvent(clothDetails));
            }, addition: Constant.clothingBrands);
          }),
          _buildHorizonItem(title: "Price", widgets: [
            Text(Helper.formatCurrency(clothDetails.price ?? 0), style: GoogleFonts.roboto(
                textStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16)
            ),),
          ]).onClick((){
            showDialog(context: context, builder: (acontext){
              return Dialog(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                    Text("Input money", style: GoogleFonts.roboto(
                      textStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16),
                  ),),
                      const Gap(8),
                      CustomTextFormField(label: "Input the clothes price", onChanged: (s){

                      }, controller: priceController, textInputType: TextInputType.number,),
                      const Gap(25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          NegativeButton(width:  SizeConfig.screenWidth! * 0.3, height: 40, onTap: (){
                            Navigator.pop(context);
                          }),
                          PositiveButton(onTap: (){
                            Navigator.pop(context);
                            setState(() {
                              clothDetails.price = priceController.text.isEmpty ? 0 : double.parse(priceController.text);
                            });
                            context.read<CreateClothesDetailsBloc>().add(CreateClothesDetailsEvent(clothDetails));
                          }, width: SizeConfig.screenWidth! * 0.3, height: 40, label: "Ok")
                        ],
                      ),
                    ],
                ),
              ),
              );
            });
          }),
          _buildHorizonItem(title: "Purchase date", widgets: [
            Text(clothDetails.dateCreated != null ? DateTimeUtils.formatTime(clothDetails.dateCreated!, showHour: false) : "None", style: GoogleFonts.roboto(
                textStyle: const TextStyle(color: Colors.blue, fontWeight: FontWeight.w600, fontSize: 16)
            ),),
          ]).onClick((){
            UI.showDateTimePickerBottomSheet(context, onChanged: (d){
              setState(() {
                clothDetails.dateCreated = d.toIso8601String();
              });
              context.read<CreateClothesDetailsBloc>().add(CreateClothesDetailsEvent(clothDetails));
            });
          }),
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
