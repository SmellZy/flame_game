part of 'level_bloc.dart';

@immutable
sealed class LevelState {}

final class LevelInitial extends LevelState {}

final class LevelLoading extends LevelState {}

final class LevelLoaded extends LevelState {
  final Level level;

  LevelLoaded({required this.level});
}

final class LevelsLoading extends LevelState {}

final class LevelsLoaded extends LevelState {
  final List<Level> levels;

  LevelsLoaded({required this.levels});
}

final class LevelError extends LevelState {
  final String message;

  LevelError({required this.message});
}
