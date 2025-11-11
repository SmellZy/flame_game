import 'package:flame_game/domain/repositories/user_repository.dart';

class GetUserPurshasedEggs {
  final UserRepository repository;

  GetUserPurshasedEggs(this.repository);

  Future<List<String>?> call() async {
    final user = await repository.getUser();
    return user?.purshasedEggs;
  }
}
