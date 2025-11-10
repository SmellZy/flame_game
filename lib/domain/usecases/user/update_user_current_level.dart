import 'package:flame_game/domain/entities/user.dart';
import 'package:flame_game/domain/repositories/user_repository.dart';

class UpdateUserCurrentLevel {
  final UserRepository repository;

  UpdateUserCurrentLevel(this.repository);

  Future<void> call(User user, int newUserLevel) async {
    final updatedUser = user.copyWith(
      currentLevel: newUserLevel,
    );
    await repository.updateUser(updatedUser);
  }
}
