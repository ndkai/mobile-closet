part of '../../pages/clothes_details_screen.dart';

class _Filter extends StatefulWidget {
  const _Filter({super.key});

  @override
  State<_Filter> createState() => _FilterState();
}

class _FilterState extends State<_Filter> {
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return _filter();
  }
  Widget _filter(){
    return Row(
      children: [
        Expanded(child: Column(
          children: [
            Text("Information", style: GoogleFonts.montserratAlternates(
                textStyle:  TextStyle(color: selected == 0 ? Colors.blue: Colors.black, fontWeight: FontWeight.w700)
            ),),
            const Gap(6),
            Divider(thickness: selected == 0 ? 3 : 1, color: selected == 0 ? Colors.blue : Colors.black,)
          ],
        ).onClick((){setState(() {
          selected = 0;
          context.read<ToggleCubit>().set(true);
        });})),
        Expanded(child: Column(
          children: [
            Text("Outfit", style: GoogleFonts.montserratAlternates(
                textStyle: TextStyle(color: selected == 1 ? Colors.blue: Colors.black, fontWeight: FontWeight.w700)
            ),),
            Gap(6),
            Divider(thickness: selected == 1? 3 : 1, color: selected == 1 ? Colors.blue : Colors.black,)
          ],
        ).onClick((){setState(() {
          selected = 1;
          context.read<ToggleCubit>().set(false);
        });})),
      ],
    );
  }
}
