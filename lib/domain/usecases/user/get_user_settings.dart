import 'package:flame_game/domain/repositories/user_repository.dart';

class GetUserSettings {
  final UserRepository repository;

  GetUserSettings(this.repository);

  Future<List<bool?>> call() async {
    final user = await repository.getUser();
    final List<bool?> userSettings = [user?.sound, user?.notifications, user?.vibration];
    return userSettings;
  }
}
