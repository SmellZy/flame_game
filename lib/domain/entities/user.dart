// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  final String? username;
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
}
