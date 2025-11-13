import 'package:flame_game/domain/entities/egg.dart';
import 'package:flame_game/domain/repositories/egg_repository.dart';

class GetEggs {
  final EggRepository repository;

  GetEggs(this.repository);

  Future<List<Egg>> call() async {
    return await repository.getAllEggs();
  }
}
