import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../models/user_model.dart';
import '../sources/user_local_datasource.dart';

class UserRepositoryImpl implements UserRepository {
  final UserLocalDataSource localDataSource;

  UserRepositoryImpl({required this.localDataSource});

  @override
  Future<User?> getUser() async {
    return await localDataSource.getUser();
  }

  @override
  Future<void> updateUser(User user) async {
    await localDataSource.saveUser(UserModel(
      username: user.username,
      avatarPath: user.avatarPath,
      coins: user.coins,
      currentEgg: user.currentEgg,
      currentLevel: user.currentLevel,
      points: user.points,
      purshasedEggs: user.purshasedEggs,
      sound: user.sound,
      notifications: user.notifications,
      vibration: user.vibration
    ));
  }

  @override
  Future<void> createUser(User user) async {
    await localDataSource.createUser(UserModel(
      username: user.username ?? "Player",
      avatarPath: user.avatarPath ?? "assets/images/avatars/avatar1.png",
      coins: user.coins ?? 0,
      currentEgg: user.currentEgg ?? "assets/images/eggs/egg1.png",
      currentLevel: user.currentLevel ?? 0,
      points: user.points ?? 0,
      purshasedEggs: user.purshasedEggs ?? ["egg1.png"],
      sound: user.sound ?? true,
      notifications: user.notifications ?? true,
      vibration: user.vibration ?? true
    ));
  }
}
