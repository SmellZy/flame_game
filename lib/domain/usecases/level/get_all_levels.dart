import 'package:flame_game/domain/entities/level.dart';
import 'package:flame_game/domain/repositories/level_repository.dart';

class GetLevels {
  final LevelRepository repository;

  GetLevels(this.repository);

  Future<List<Level>> call() async {
    return await repository.getAllLevels();
  }
}
