import 'package:flame_game/domain/entities/user.dart';
import 'package:flame_game/domain/repositories/user_repository.dart';

class UpdateUserPhoto {
  final UserRepository repository;

  UpdateUserPhoto(this.repository);

  Future<void> call(User user, String newPhotoPath) async {
    final updatedUser = user.copyWith(
      avatarPath: newPhotoPath,
    );
    await repository.updateUser(updatedUser);
  }
}
