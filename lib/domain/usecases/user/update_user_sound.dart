import 'package:flame_game/domain/entities/user.dart';
import 'package:flame_game/domain/repositories/user_repository.dart';

class UpdateUserSound {
  final UserRepository repository;

  UpdateUserSound(this.repository);

  Future<void> call(User user, bool newSoundSet) async {
    final updatedUser = user.copyWith(
      sound: newSoundSet,
    );
    await repository.updateUser(updatedUser);
  }
}
