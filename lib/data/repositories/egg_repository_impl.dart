import 'package:flame_game/data/sources/egg_local_datasource.dart';
import 'package:flame_game/domain/entities/egg.dart';
import 'package:flame_game/domain/repositories/egg_repository.dart';

class EggRepositoryImpl implements EggRepository {
  final EggLocalDataSource localDataSource;

  EggRepositoryImpl({required this.localDataSource});

  @override
  Future<List<Egg>> getAllEggs() async {
    return await localDataSource.loadEggs();
  }

  @override
  Future<Egg?> getEggByNumber(int id) async {
    final eggs = await localDataSource.loadEggs();
    return eggs.firstWhere(
      (egg) => egg.id == id,
      orElse: () => throw Exception('Egg $id not found'),
    );
  }
}
