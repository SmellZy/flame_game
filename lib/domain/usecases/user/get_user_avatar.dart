import 'package:flame_game/domain/repositories/user_repository.dart';

class GetUserAvatar {
  final UserRepository repository;

  GetUserAvatar(this.repository);

  Future<String?> call() async {
    final user = await repository.getUser();
    return user?.avatarPath;
  }
}
