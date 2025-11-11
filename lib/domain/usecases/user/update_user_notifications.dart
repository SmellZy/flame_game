import 'package:flame_game/domain/entities/user.dart';
import 'package:flame_game/domain/repositories/user_repository.dart';

class UpdateUserNotifications {
  final UserRepository repository;

  UpdateUserNotifications(this.repository);

  Future<void> call(User user, bool newNotificationSet) async {
    final updatedUser = user.copyWith(
      notifications: newNotificationSet,
    );
    await repository.updateUser(updatedUser);
  }
}
