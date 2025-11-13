import 'package:bloc/bloc.dart';
import 'package:flame_game/domain/entities/level.dart';
import 'package:flame_game/domain/repositories/level_repository.dart';
import 'package:flutter/material.dart';

part 'level_event.dart';
part 'level_state.dart';

class LevelBloc extends Bloc<LevelEvent, LevelState> {
  final LevelRepository repository;

  LevelBloc(this.repository) : super(LevelInitial()) {
    on<GetAllLevelsEvent>(_onGetAllLevels);
    on<GetLevelByIdEvent>(_onGetLevelById);
  }

  Future<void> _onGetAllLevels(
    GetAllLevelsEvent event,
    Emitter<LevelState> emit,
  ) async {
    try {
      emit(LevelsLoading());
      final levels = await repository.getAllLevels();
      emit(LevelsLoaded(levels: levels));
    } catch (error) {
      emit(LevelError(message: error.toString()));
    }
  }

  Future<void> _onGetLevelById(
    GetLevelByIdEvent event,
    Emitter<LevelState> emit,
  ) async {
    try {
      emit(LevelLoading());
      final level = await repository.getLevelByNumber(event.levelNumber);

      if (level != null) {
        emit(LevelLoaded(level: level));
      } else {
        emit(LevelError(message: 'Level ${event.levelNumber} not found.'));
      }
    } catch (error) {
      emit(LevelError(message: error.toString()));
    }
  }
}
