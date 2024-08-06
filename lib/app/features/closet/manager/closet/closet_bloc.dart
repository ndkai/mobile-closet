import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/services/isar/schemas/closet.dart';
import '../../../../../core/services/isar/schemas/closet.dart';
import '../../../../data/closet/local_closet_datasource.dart';

part 'closet_event.dart';
part 'closet_state.dart';

class CreateClosetBloc extends Bloc<ClosetEvent, ClosetState> {
  final LocalClosetDataSource localClosetDataSource;

  CreateClosetBloc(this.localClosetDataSource) : super(ClosetInitState()) {
    on<CreateClosetEvent>(_create);
  }

  void _create(CreateClosetEvent event, Emitter<ClosetState> emit) async {
    emit(ClosetLoadingState());
    final existed = await localClosetDataSource.getClosetByName(event.closet.name ?? "");
    if(existed != null){
      emit(ClosetErrorState("Name existed"));
      return;
    }
    final data = await localClosetDataSource.addCloset(event.closet);
    if (data) {
      emit(ClosetCreateSuccessState());
    } else {
      emit(ClosetErrorState("Error"));
    }
  }
}

class UpdateClosetBloc extends Bloc<ClosetEvent, ClosetState> {
  final LocalClosetDataSource localClosetDataSource;

  UpdateClosetBloc(this.localClosetDataSource) : super(ClosetInitState()) {
    on<UpdateClosetEvent>(_update);
  }

  void _update(UpdateClosetEvent event, Emitter<ClosetState> emit) async {
    emit(ClosetLoadingState());
    final data = await localClosetDataSource.updateCloset(event.closet);
    if (data) {
      emit(ClosetUpdateSuccessState());
    } else {
      emit(ClosetErrorState("Error"));
    }
  }
}

class DeleteClosetBloc extends Bloc<ClosetEvent, ClosetState> {
  final LocalClosetDataSource localClosetDataSource;

  DeleteClosetBloc(this.localClosetDataSource) : super(ClosetInitState()) {
    on<DeleteClosetEvent>(_delete);
  }

  void _delete(DeleteClosetEvent event, Emitter<ClosetState> emit) async {
    emit(ClosetLoadingState());
    final data = await localClosetDataSource.deleteCloset(event.id);
    if (data) {
      emit(ClosetDeleteSuccessState());
    } else {
      emit(ClosetErrorState("Error"));
    }
  }
}

class GetClosetBloc extends Bloc<ClosetEvent, ClosetState> {
  final LocalClosetDataSource localClosetDataSource;

  GetClosetBloc(this.localClosetDataSource) : super(ClosetInitState()) {
    on<GetClosetListEvent>(_getClosets);
    on<GetClosetEvent>(_getClosetById);
  }

  void _getClosets(GetClosetListEvent event, Emitter<ClosetState> emit) async {
    emit(ClosetLoadingState());
    final data = await localClosetDataSource.getClosets();
    if (data.isNotEmpty) {
      emit(ClosetGetSuccessState(data));
    } else {
      emit(ClosetErrorState("Error"));
    }
  }

  void _getClosetById(GetClosetEvent event, Emitter<ClosetState> emit) async {
    emit(ClosetLoadingState());
    final data = await localClosetDataSource.getClosetById(event.id);
    if (data != null) {
      emit(ClosetGetSuccessState([data])); // Wrap single item in a list
    } else {
      emit(ClosetErrorState("Error"));
    }
  }
}
