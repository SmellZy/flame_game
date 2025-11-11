import 'package:flame_game/domain/repositories/user_repository.dart';

class GetUserSound {
  final UserRepository repository;

  GetUserSound(this.repository);

  Future<bool?> call() async {
    final user = await repository.getUser();
    return user?.sound;
  }
}
