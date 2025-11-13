import 'package:bloc/bloc.dart';
import 'package:flame_game/domain/entities/user.dart';
import 'package:flame_game/domain/repositories/user_repository.dart';
import 'package:flutter/foundation.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository repository;

  UserBloc(this.repository) : super(UserInitial()) {
    on<GetUserEvent>(_onGetUser);
    on<UpdateUserEvent>(_onUpdateUser);
    on<CreateUserEvent>(_onCreateUser);
  }

  Future<void> _onGetUser(GetUserEvent event, Emitter<UserState> emit) async {
    try {
      if (state is! UserLoaded) {
        emit(UserLoading());
      }
      final user = await repository.getUser();
      emit(UserLoaded(user: user!));
    } catch (error) {
      emit(UserError(message: error.toString()));
    }
  }

  Future<void> _onUpdateUser(
    UpdateUserEvent event,
    Emitter<UserState> emit,
  ) async {
    try {
      emit(UserUpdating());
      await repository.updateUser(event.user);
      emit(UserLoaded(user: event.user));
    } catch (error) {
      emit(UserError(message: error.toString()));
    }
  }

  Future<void> _onCreateUser(
    CreateUserEvent event,
    Emitter<UserState> emit,
  ) async {
    try {
      emit(UserCreating());
      await repository.createUser(event.user);
      emit(UserLoaded(user: event.user));
    } catch (error) {
      emit(UserError(message: error.toString()));
    }
  }
}