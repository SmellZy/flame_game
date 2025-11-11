import 'package:flame_game/domain/repositories/user_repository.dart';

class GetUserCoins {
  final UserRepository repository;

  GetUserCoins(this.repository);

  Future<int?> call() async {
    final user = await repository.getUser();
    return user?.coins;
  }
}
