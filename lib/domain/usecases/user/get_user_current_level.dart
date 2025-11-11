import 'package:flame_game/domain/repositories/user_repository.dart';

class GetUserCurrentLevel {
  final UserRepository repository;

  GetUserCurrentLevel(this.repository);

  Future<int?> call() async {
    final user = await repository.getUser();
    return user?.currentLevel;
  }
}
