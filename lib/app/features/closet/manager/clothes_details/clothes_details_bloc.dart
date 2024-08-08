import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/services/isar/schemas/clothes_details.dart';
import '../../../../data/clothes_detail/clothes_details_datasource.dart';

part 'clothes_details_event.dart';
part 'clothes_details_state.dart';

class CreateClothesDetailsBloc extends Bloc<ClothesDetailsEvent, ClothesDetailsState> {
  final LocalClothesDetailsDataSource localClothesDetailsDataSource;

  CreateClothesDetailsBloc(this.localClothesDetailsDataSource) : super(ClothesDetailsInitState()) {
    on<CreateClothesDetailsEvent>(_create);
  }

  void _create(CreateClothesDetailsEvent event, Emitter<ClothesDetailsState> emit) async {
    emit(ClothesDetailsLoadingState());
    final data = await localClothesDetailsDataSource.addClothesDetails(event.clothesDetails);
    if (data) {
      emit(ClothesDetailsCreateSuccessState());
    } else {
      emit(ClothesDetailsErrorState("Error"));
    }
  }
}

class UpdateClothesDetailsBloc extends Bloc<ClothesDetailsEvent, ClothesDetailsState> {
  final LocalClothesDetailsDataSource localClothesDetailsDataSource;

  UpdateClothesDetailsBloc(this.localClothesDetailsDataSource) : super(ClothesDetailsInitState()) {
    on<UpdateClothesDetailsEvent>(_update);
  }

  void _update(UpdateClothesDetailsEvent event, Emitter<ClothesDetailsState> emit) async {
    emit(ClothesDetailsLoadingState());
    final data = await localClothesDetailsDataSource.updateClothesDetails(event.clothesDetails);
    if (data) {
      emit(ClothesDetailsUpdateSuccessState());
    } else {
      emit(ClothesDetailsErrorState("Error"));
    }
  }
}

class DeleteClothesDetailsBloc extends Bloc<ClothesDetailsEvent, ClothesDetailsState> {
  final LocalClothesDetailsDataSource localClothesDetailsDataSource;

  DeleteClothesDetailsBloc(this.localClothesDetailsDataSource) : super(ClothesDetailsInitState()) {
    on<DeleteClothesDetailsEvent>(_delete);
  }

  void _delete(DeleteClothesDetailsEvent event, Emitter<ClothesDetailsState> emit) async {
    emit(ClothesDetailsLoadingState());
    final data = await localClothesDetailsDataSource.deleteClothesDetails(event.id);
    if (data) {
      emit(ClothesDetailsDeleteSuccessState());
    } else {
      emit(ClothesDetailsErrorState("Error"));
    }
  }
}

class GetClothesDetailsBloc extends Bloc<ClothesDetailsEvent, ClothesDetailsState> {
  final LocalClothesDetailsDataSource localClothesDetailsDataSource;

  GetClothesDetailsBloc(this.localClothesDetailsDataSource) : super(ClothesDetailsInitState()) {
    on<GetClothesDetailsListEvent>(_getClothesDetails);
    on<GetClothesDetailsEvent>(_getClothesDetailsById);
  }

  void _getClothesDetails(GetClothesDetailsListEvent event, Emitter<ClothesDetailsState> emit) async {
    emit(ClothesDetailsLoadingState());
    final data = await localClothesDetailsDataSource.getClothesDetails();
    if (data.isNotEmpty) {
      emit(ClothesDetailsGetSuccessState(data));
    } else {
      emit(ClothesDetailsErrorState("Error"));
    }
  }

  void _getClothesDetailsById(GetClothesDetailsEvent event, Emitter<ClothesDetailsState> emit) async {
    emit(ClothesDetailsLoadingState());
    final data = await localClothesDetailsDataSource.getClothesDetailsById(event.id);
    if (data != null) {
      emit(ClothesDetailsGetSuccessState([data])); // Wrap single item in a list
    } else {
      emit(ClothesDetailsErrorState("Error"));
    }
  }
}