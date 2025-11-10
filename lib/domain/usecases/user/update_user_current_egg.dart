import 'package:flame_game/domain/entities/user.dart';
import 'package:flame_game/domain/repositories/user_repository.dart';

class UpdateUserCurrentEgg {
  final UserRepository repository;

  UpdateUserCurrentEgg(this.repository);

  Future<void> call(User user, String newUserEgg) async {
    final updatedUser = user.copyWith(
      currentEgg: newUserEgg,
    );
    await repository.updateUser(updatedUser);
  }
}
