part of 'user_bloc.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserLoaded extends UserState {
    final User user;

  UserLoaded({required this.user});
}

final class UserUpdating extends UserState {}

final class UserUpdated extends UserState {
  final User user;

  UserUpdated({required this.user});
}

final class UserCreating extends UserState {}

final class UserCreated extends UserState {
  final User user;

  UserCreated({required this.user});
}

final class UserError extends UserState {
  final String message;

  UserError({required this.message});
}


