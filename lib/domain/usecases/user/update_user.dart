import 'package:flame_game/domain/entities/user.dart';
import 'package:flame_game/domain/repositories/user_repository.dart';

class UpdateUser {
  final UserRepository repository;

  UpdateUser(this.repository);

  Future<void> call(
    User user,
    String? newUserName,
    String? newAvatarPath,
    int? deltaCoins,
    String? newCurrentEgg,
    int? newCurrentLevel,
    int? deltaPoints,
    List<String>? newPurshasedEggs,
    bool? newSound,
    bool? newNotification,
    bool? newVibration,
  ) async {
    final updatedUser = user.copyWith(
      username: newUserName ?? user.username,
      avatarPath: newAvatarPath ?? user.avatarPath,
      coins: deltaCoins != null
          ? ((user.coins ?? 0) + deltaCoins).clamp(0, 99999999)
          : user.coins,
      currentEgg: newCurrentEgg ?? user.currentEgg,
      currentLevel: newCurrentLevel ?? user.currentLevel,
      points: deltaPoints != null
          ? ((user.points ?? 0) + deltaPoints).clamp(0, 99999999)
          : user.points,
      purshasedEggs: newPurshasedEggs != null
          ? _mergeEggs(user.purshasedEggs, newPurshasedEggs)
          : user.purshasedEggs,

      sound: newSound ?? user.sound,
      notifications: newNotification ?? user.notifications,
      vibration: newVibration ?? user.vibration,
    );
    await repository.updateUser(updatedUser);
  }

  List<String> _mergeEggs(List<String>? existing, List<String>? newOnes) {
    final updated = List<String>.from(existing ?? []);
    for (final egg in newOnes ?? []) {
      if (!updated.contains(egg)) {
        updated.add(egg);
      }
    }
    return updated;
  }
}


