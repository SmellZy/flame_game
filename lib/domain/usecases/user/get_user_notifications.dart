import 'package:flame_game/domain/repositories/user_repository.dart';

class GetUserNotifications {
  final UserRepository repository;

  GetUserNotifications(this.repository);

  Future<bool?> call() async {
    final user = await repository.getUser();
    return user?.notifications;
  }
}
