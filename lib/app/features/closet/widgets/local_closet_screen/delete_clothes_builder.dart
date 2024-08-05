part of  '../../pages/closet_screen.dart';

class _DeleteClothesBuilder extends StatelessWidget {
  const _DeleteClothesBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeleteClothesBloc, ClothesState>(
        listener: (context, state){
          if(state is ClothesDeleteSuccessState){
            Navigator.of(context).pop();
            context.read<GetClothesBloc>().add(GetClothesListEvent());
            UI.showSuccessToast(context, "Delete successful");
          }
          if(state is ClothesErrorState){
            Navigator.of(context).pop();
          }

        },
        child: SizedBox(),
    );
  }




}
