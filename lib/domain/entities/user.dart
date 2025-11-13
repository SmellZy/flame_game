// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  final String? username;
  final String? email;
  final String? avatarPath;
  final int? coins;
  final String? currentEgg;
  final int? currentLevel;
  final int? points;
  final List<String>? purshasedEggs;
  final bool? sound;
  final bool? notifications;
  final bool? vibration;

  User({
    this.username,
    this.email,
    this.avatarPath,
    this.coins,
    this.currentEgg,
    this.currentLevel,
    this.points,
    this.purshasedEggs,
    this.sound,
    this.notifications,
    this.vibration,
  });
  User copyWith({
    String? username,
    String? email,
    String? avatarPath,
    int? coins,
    String? currentEgg,
    int? currentLevel,
    int? points,
    List<String>? purshasedEggs,
    bool? sound,
    bool? notifications,
    bool? vibration,
  }) {
    return User(
      username: username ?? this.username,
      email: email ?? this.email,
      avatarPath: avatarPath ?? this.avatarPath,
      coins: coins ?? this.coins,
      currentEgg: currentEgg ?? this.currentEgg,
      currentLevel: currentLevel ?? this.currentLevel,
      points: points ?? this.points,
      purshasedEggs: purshasedEggs ?? this.purshasedEggs,
      sound: sound ?? this.sound,
      notifications: notifications ?? this.notifications,
      vibration: vibration ?? this.vibration,
    );
  }
}
