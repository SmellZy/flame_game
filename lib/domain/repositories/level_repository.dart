import '../entities/level.dart';

abstract class LevelRepository {
  Future<List<Level>> getAllLevels();
  Future<Level?> getLevelByNumber(int levelNumber);
}
