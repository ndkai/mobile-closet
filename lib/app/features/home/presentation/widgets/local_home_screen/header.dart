part of '../../pages/home_screen.dart';

class _Header extends StatefulWidget {
  const _Header({super.key});

  @override
  State<_Header> createState() => _HeaderState();
}

class _HeaderState extends State<_Header> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Good morning", style: GoogleFonts.montserratAlternates(
                    textStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700)
                ),),
                Text("Nguyen Nhat Duy", style: GoogleFonts.montserratAlternates(
                    textStyle: const TextStyle(color: Colors.blue, fontWeight: FontWeight.w700)
                ),)
              ],
            ),
            CircleAvatar(
              radius: 23,
              backgroundColor: Colors.blueGrey,
              backgroundImage: AssetImage(Assets.imagesNewCategory),
            )
          ],
        )
      ],
    ).padding(const EdgeInsets.symmetric(horizontal: 16));
  }
}
