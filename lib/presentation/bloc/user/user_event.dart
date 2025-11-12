part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}

class GetUserEvent extends UserEvent {}

class UpdateUserEvent extends UserEvent {
  final User user;

  UpdateUserEvent({required this.user});
}

class CreateUserEvent extends UserEvent {
  final User user;

  CreateUserEvent({required this.user});
}
