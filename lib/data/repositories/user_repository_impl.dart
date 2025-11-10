import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../models/user_model.dart';
import '../sources/local_datasource.dart';

class UserRepositoryImpl implements UserRepository {
  final LocalDataSource localDataSource;

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
}
