import 'package:flame_game/data/sources/level_local_datasource.dart';
import '../../domain/entities/level.dart';
import '../../domain/repositories/level_repository.dart';

class LevelRepositoryImpl implements LevelRepository {
  final LevelLocalDataSource localDataSource;

  LevelRepositoryImpl({required this.localDataSource});

  @override
  Future<List<Level>> getAllLevels() async {
    return await localDataSource.loadLevels();
  }

  @override
  Future<Level?> getLevelByNumber(int levelNumber) async {
    final levels = await localDataSource.loadLevels();
    return levels.firstWhere(
      (level) => level.level == levelNumber,
      orElse: () => throw Exception('Level $levelNumber not found'),
    );
  }
}
