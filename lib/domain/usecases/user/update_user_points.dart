import 'package:flame_game/domain/entities/user.dart';
import 'package:flame_game/domain/repositories/user_repository.dart';

class UpdateUserPoints {
  final UserRepository repository;

  UpdateUserPoints(this.repository);

  Future<void> call(User user, int delta) async {
    final updatedUser = user.copyWith(
      points: (user.points != null ? user.points! + delta : 0).clamp(0, 99999999),
    );
    await repository.updateUser(updatedUser);
  }
}
