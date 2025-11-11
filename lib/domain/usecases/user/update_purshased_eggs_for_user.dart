import 'package:flame_game/domain/entities/user.dart';
import 'package:flame_game/domain/repositories/user_repository.dart';

class AddPurchasedEgg {
  final UserRepository repository;

  AddPurchasedEgg(this.repository);

  Future<void> call(User user, String newEggId) async {
    final updatedEggs = List<String>.from(user.purshasedEggs ?? []);

    if (!updatedEggs.contains(newEggId)) {
      updatedEggs.add(newEggId);
    }

    // створюємо оновленого користувача
    final updatedUser = user.copyWith(
      purshasedEggs: updatedEggs,
    );

    // зберігаємо зміни через репозиторій
    await repository.updateUser(updatedUser);
  }
}
