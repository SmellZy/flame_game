import 'package:flame_game/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    super.username,
    super.email,
    super.avatarPath,
    super.coins,
    super.currentEgg,
    super.currentLevel,
    super.points,
    super.purshasedEggs,
    super.sound,
    super.notifications,
    super.vibration,
  });

  @override
  UserModel copyWith({
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
    return UserModel(
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

  Map<String, dynamic> toJson() => {
    'username': username,
    'email': email,
    'avatarPath': avatarPath,
    'coins': coins,
    'currentEgg': currentEgg,
    'currentLevel': currentLevel,
    'points': points,
    'purshasedEggs': purshasedEggs,
    'sound': sound,
    'notifications': notifications,
    'vibration': vibration,
  };

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final purshasedEggsJson = json['purshasedEggs'] as List<dynamic>?;

    return UserModel(
      username: json['username'],
      email: json['email'],
      avatarPath: json['avatarPath'],
      coins: json['coins'],
      currentEgg: json['currentEgg'],
      currentLevel: json['currentLevel'],
      points: json['points'],
      purshasedEggs: purshasedEggsJson?.map((e) => e.toString()).toList(),
      sound: json['sound'],
      notifications: json['notifications'],
      vibration: json['vibration'],
    );
  }
}
