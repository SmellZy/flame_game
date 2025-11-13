import '../entities/egg.dart';

abstract class EggRepository {
  Future<List<Egg>> getAllEggs();
  Future<Egg?> getEggByNumber(int id);
}
