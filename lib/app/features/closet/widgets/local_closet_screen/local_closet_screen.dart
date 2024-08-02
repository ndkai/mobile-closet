part of  '../../pages/closet_screen.dart';

class _LocalScreen extends StatefulWidget {
  final Widget filter;
  final Widget clothes;
  const _LocalScreen({super.key, required this.filter, required this.clothes});

  @override
  State<_LocalScreen> createState() => _LocalScreenState();
}

class _LocalScreenState extends State<_LocalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: Text("Your closet", style: GoogleFonts.montserratAlternates(
            textStyle: const TextStyle(color: Colors.blue, fontWeight: FontWeight.w700)
        ),),
        actions: [
          const Icon(Icons.more_vert).padding(const EdgeInsets.only(left: 16)),

        ],
      ),
      body: Column(
        children: [
          widget.filter,
          const Gap(16),
          widget.clothes
        ],
      ).padding(const EdgeInsets.symmetric(horizontal: 16)),
    );
  }


}

