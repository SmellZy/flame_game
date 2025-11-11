import 'package:flame_game/domain/repositories/user_repository.dart';

class GetUserVibration {
  final UserRepository repository;

  GetUserVibration(this.repository);

  Future<bool?> call() async {
    final user = await repository.getUser();
    return user?.vibration;
  }
}
