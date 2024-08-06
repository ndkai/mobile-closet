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
                Text("Good morning,", style: GoogleFonts.montserratAlternates(
                    textStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700)
                ),),
                Text("Nguyen Nhat Duy", style: GoogleFonts.montserratAlternates(
                    textStyle: const TextStyle(color: Colors.blue, fontWeight: FontWeight.w700)
                ),)
              ],
            ),
            const CircleAvatar(
              radius: 23,
              backgroundColor: Colors.blueGrey,
              backgroundImage: AssetImage(Assets.imagesNewCategory),
            )
          ],
        ),
        const Gap(12),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(.1),
            borderRadius: BorderRadius.circular(8)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("The weather is rainy to day", style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),),
                  Gap(3),
                  Text("Remember to bring your raincoat", style: TextStyle(
                    color: Color(0xFF014494),
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),),
                ],
              )),
              Column(
                children: [
                    Image.asset(Assets.iconsSunny),
                    Gap(3),
                  Text("20/30 °C", style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),),
                ],
              )
            ],
          ),
        )
      ],
    ).padding(const EdgeInsets.symmetric(horizontal: 16));
  }
}
