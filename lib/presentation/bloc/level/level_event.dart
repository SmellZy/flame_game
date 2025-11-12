part of 'level_bloc.dart';

@immutable
sealed class LevelEvent {}

class GetAllLevelsEvent extends LevelEvent {}

class GetLevelByIdEvent extends LevelEvent {
  final int levelNumber;

  GetLevelByIdEvent({required this.levelNumber});
}
