import 'package:flame_game/domain/entities/user.dart';
import 'package:flame_game/domain/repositories/user_repository.dart';

class UpdateUserName {
  final UserRepository repository;

  UpdateUserName(this.repository);

  Future<void> call(User user, String newUserName) async {
    final updatedUser = user.copyWith(
      username: newUserName,
    );
    await repository.updateUser(updatedUser);
  }
}
