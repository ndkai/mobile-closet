part of 'closet_bloc.dart';

@immutable
sealed class ClosetEvent {}
class GetClosetEvent extends ClosetEvent {
  final int id;

  GetClosetEvent(this.id);
}

class GetClosetListEvent extends ClosetEvent {}

class UpdateClosetEvent extends ClosetEvent {
  final Closet closet;

  UpdateClosetEvent(this.closet);
}

class CreateClosetEvent extends ClosetEvent {
  final Closet closet;

  CreateClosetEvent(this.closet);
}

class DeleteClosetEvent extends ClosetEvent {
  final int id;

  DeleteClosetEvent(this.id);
}