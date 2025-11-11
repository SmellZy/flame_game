import 'package:flame_game/domain/repositories/user_repository.dart';

class GetUserPoints {
  final UserRepository repository;

  GetUserPoints(this.repository);

  Future<int?> call() async {
    final user = await repository.getUser();
    return user?.points;
  }
}
