part of '../../pages/closet_screen.dart';

class _Clothes extends StatelessWidget {
  const _Clothes({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 3.0,
            mainAxisSpacing: 3.0,
            childAspectRatio: 1.0,
          ),
          itemCount: 100,
          itemBuilder: (context, index){
            return Container(
              decoration: BoxDecoration(
                color: Colors.green
              ),
              child: const Center(
                child: Text("duy"),
              ),
            );
          }),
    );
  }
}
