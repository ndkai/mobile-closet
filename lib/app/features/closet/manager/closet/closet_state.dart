part of 'closet_bloc.dart';

abstract class ClosetState {}

class ClosetInitState extends ClosetState {}

class ClosetLoadingState extends ClosetState {}

class ClosetErrorState extends ClosetState {
  final String msg;

  ClosetErrorState(this.msg);
}

class ClosetCreateSuccessState extends ClosetState {}

class ClosetGetSuccessState extends ClosetState {
  final List<Closet> closet;

  ClosetGetSuccessState(this.closet);
}

class ClosetDeleteSuccessState extends ClosetState {}

class ClosetUpdateSuccessState extends ClosetState {}

