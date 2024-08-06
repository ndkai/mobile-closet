import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/services/isar/schemas/clothes.dart';
import '../../../../data/clothes/local_clothes_datasource.dart';

part 'clothes_event.dart';
part 'clothes_state.dart';

class CreateClothesBloc extends Bloc<ClothesEvent, ClothesState> {
  final LocalClothesDataSource localClothesDataSource;

  CreateClothesBloc(this.localClothesDataSource) : super(ClothesInitState()) {
    on<CreateClothesEvent>(_create);
  }

  void _create(CreateClothesEvent event, Emitter<ClothesState> emit) async {
    emit(ClothesLoadingState());
    final data = await localClothesDataSource.addClothes(event.clothes);
    if (data) {
      emit(ClothesCreateSuccessState());
    } else {
      emit(ClothesErrorState("Error"));
    }
  }
}

class UpdateClothesBloc extends Bloc<ClothesEvent, ClothesState> {
  final LocalClothesDataSource localClothesDataSource;

  UpdateClothesBloc(this.localClothesDataSource) : super(ClothesInitState()) {
    on<UpdateClothesEvent>(_update);
  }

  void _update(UpdateClothesEvent event, Emitter<ClothesState> emit) async {
    emit(ClothesLoadingState());
    final data = await localClothesDataSource.updateClothes(event.clothes);
    if (data) {
      emit(ClothesUpdateSuccessState());
    } else {
      emit(ClothesErrorState("Error"));
    }
  }
}
class DeleteClothesBloc extends Bloc<ClothesEvent, ClothesState> {
  final LocalClothesDataSource localClothesDataSource;

  DeleteClothesBloc(this.localClothesDataSource) : super(ClothesInitState()) {
    on<DeleteClothesEvent>(_delete);
  }

  void _delete(DeleteClothesEvent event, Emitter<ClothesState> emit) async {
    emit(ClothesLoadingState());
    final data = await localClothesDataSource.deleteClothes(event.id);
    if (data) {
      emit(ClothesDeleteSuccessState());
    } else {
      emit(ClothesErrorState("Error"));
    }
  }
}

class GetClothesBloc extends Bloc<ClothesEvent, ClothesState> {
  final LocalClothesDataSource localClothesDataSource;

  GetClothesBloc(this.localClothesDataSource) : super(ClothesInitState()) {
    on<GetClothesListEvent>(_getClothes);
    on<GetClothesEvent>(_getClothesById);
    on<GetClothesByClosetIdEvent>(_getClothesByClosetId);
  }

  void _getClothesByClosetId(GetClothesByClosetIdEvent event, Emitter<ClothesState> emit) async {
    emit(ClothesLoadingState());
    final data = await localClothesDataSource.getClothesByClosetId(event.id);
    if (data != null) {
      emit(ClothesGetSuccessState(data));
    } else {
      emit(ClothesErrorState("Error"));
    }
  }

  void _getClothes(GetClothesListEvent event, Emitter<ClothesState> emit) async {
    emit(ClothesLoadingState());
    final data = await localClothesDataSource.getClothes();
    if (data.isNotEmpty) {
      emit(ClothesGetSuccessState(data));
    } else {
      emit(ClothesErrorState("Error"));
    }
  }

  void _getClothesById(GetClothesEvent event, Emitter<ClothesState> emit) async {
    emit(ClothesLoadingState());
    final data = await localClothesDataSource.getClothesById(event.id);
    if (data != null) {
      emit(ClothesGetSuccessState([data])); // Wrap single item in a list
    } else {
      emit(ClothesErrorState("Error"));
    }
  }
}