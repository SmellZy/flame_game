import 'package:flame_game/domain/entities/egg.dart';
import 'package:flame_game/domain/repositories/egg_repository.dart';

class GetEggById {
  final EggRepository repository;

  GetEggById(this.repository);

  Future<Egg?> call(int id) async {
    return await repository.getEggByNumber(id);
  }
}
