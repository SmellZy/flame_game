import 'package:flame_game/domain/repositories/user_repository.dart';

class GetUserName {
  final UserRepository repository;

  GetUserName(this.repository);

  Future<String?> call() async {
    final user = await repository.getUser();
    return user?.username;
  }
}
