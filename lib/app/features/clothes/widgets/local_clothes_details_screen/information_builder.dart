part of '../../pages/clothes_details_screen.dart';

class _InformationBuilder extends StatefulWidget {
  const _InformationBuilder({super.key});

  @override
  State<_InformationBuilder> createState() => _InformationBuilderState();
}

class _InformationBuilderState extends State<_InformationBuilder> {
  @override
  Widget build(BuildContext context) {
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
        _buildHorizonItem(title: "Color", widgets: [
          Text("Red", style: GoogleFonts.roboto(
              textStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16)
          ),),
        ]).onClick((){
          showDialog(context: context, builder: (context){
            return Dialog(
                child: ColorPickerBuilder(colors: const [], onConfirm: (colors){
                  print(colors.toString());
                },)
            );
          });
        }),
        _buildHorizonItem(title: "Material", widgets: [
          Text("Red", style: GoogleFonts.roboto(
              textStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16)
          ),),
        ]),
        _buildHorizonItem(title: "Brand", widgets: [
          Text("Red", style: GoogleFonts.roboto(
              textStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16)
          ),),
        ]),
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
  }

  Widget _buildHorizonItem({required String title, required List<Widget> widgets}){
    return Column(
      children: [
        Row(
          children: [
            Text(title, style: GoogleFonts.roboto(
                textStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 16)
            ),),
            Expanded(child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: widgets,
            ))
          ],
        ).padding(const EdgeInsets.symmetric(vertical: 10)),
        Divider()
      ],
    );
  }
}
