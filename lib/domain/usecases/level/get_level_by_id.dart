import 'package:flame_game/domain/entities/level.dart';
import 'package:flame_game/domain/repositories/level_repository.dart';

class GetLevelById {
  final LevelRepository repository;

  GetLevelById(this.repository);

  Future<Level?> call(int levelId) async {
    return await repository.getLevelByNumber(levelId);
  }
}
