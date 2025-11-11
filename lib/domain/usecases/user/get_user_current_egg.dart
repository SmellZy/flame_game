import 'package:flame_game/domain/repositories/user_repository.dart';

class GetUserCurrentEgg {
  final UserRepository repository;

  GetUserCurrentEgg(this.repository);

  Future<String?> call() async {
    final user = await repository.getUser();
    return user?.currentEgg;
  }
}
