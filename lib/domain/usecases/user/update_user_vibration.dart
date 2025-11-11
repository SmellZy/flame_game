import 'package:flame_game/domain/entities/user.dart';
import 'package:flame_game/domain/repositories/user_repository.dart';

class UpdateUserVibration {
  final UserRepository repository;

  UpdateUserVibration(this.repository);

  Future<void> call(User user, bool newVibroSet) async {
    final updatedUser = user.copyWith(
      vibration: newVibroSet,
    );
    await repository.updateUser(updatedUser);
  }
}
