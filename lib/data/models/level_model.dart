import '../../domain/entities/level.dart';

class LevelModel extends Level {
  const LevelModel({
    required super.level,
    required super.minRequiredUserLevel,
    required super.targetScore,
    required super.timeLimit,
    required super.eggLifetime,
    required super.eggCostPoint,
    required super.maxEggSpawnLimit,
  });

  factory LevelModel.fromJson(Map<String, dynamic> json) {
    return LevelModel(
      level: json['level'] as int,
      minRequiredUserLevel: json['minRequiredUserLevel'] as int,
      targetScore: json['targetScore'] as int,
      timeLimit: json['timeLimit'] as int,
      eggLifetime: (json['eggLifetime'] as num).toDouble(),
      eggCostPoint: json['eggCostPoint'] as int,
      maxEggSpawnLimit: json['maxEggSpawnLimit'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'level': level,
      'minRequiredUserLevel': minRequiredUserLevel,
      'targetScore': targetScore,
      'timeLimit': timeLimit,
      'eggLifetime': eggLifetime,
      'eggCostPoint': eggCostPoint,
      'maxEggSpawnLimit': maxEggSpawnLimit,
    };
  }
}
