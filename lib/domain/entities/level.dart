class Level {
  final int level;
  final int minRequiredUserLevel;
  final int targetScore;
  final int timeLimit;
  final double eggLifetime;
  final int eggCostPoint;
  final int maxEggSpawnLimit;

  const Level({
    required this.level,
    required this.minRequiredUserLevel,
    required this.targetScore,
    required this.timeLimit,
    required this.eggLifetime,
    required this.eggCostPoint,
    required this.maxEggSpawnLimit,
  });
}
